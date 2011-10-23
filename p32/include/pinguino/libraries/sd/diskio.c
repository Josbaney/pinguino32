/*-----------------------------------------------------------------------*/
/* Low level disk I/O module skeleton for Petit FatFs (C)ChaN, 2009      */
/*-----------------------------------------------------------------------*/

#ifndef __DISKIO_C__
#define __DISKIO_C__

#include <sd/diskio.h>
#include <spi.c>
#include <millis.c>
#include <digitalw.c>

#define DUMMY 0xFF

// I/O pin definitions
#if defined(PIC32_PINGUINO) || defined (PIC32_PINGUINO_OTG)
	// CD and CS are on the same pin (???)
	// D10 = SS2
	#define SD_CS		8		// Card Chip Select (SS) is on pin 10 (D10)
	#define SD_CD		8		// Card Card Detect is on pin 10 (D10)
#endif

// Port Controls (Platform dependent)
// TODO:try with digitalwrite
#define SELECT()		(pinmode(SD_CS, 0))	/* MMC CS = L */
#define DESELECT()	(pinmode(SD_CS, 1))	/* MMC CS = H */

// Definitions for MMC/SDC command
#define CMD0			(0x40+0)		/* GO_IDLE_STATE */
#define CMD1			(0x40+1)		/* SEND_OP_COND (MMC) */
#define ACMD41			(0xC0+41)	/* SEND_OP_COND (SDC) */
#define CMD8			(0x40+8)		/* SEND_IF_COND */
#define CMD9			(0x40+9)		/* SEND_CSD */
#define CMD10			(0x40+10)	/* SEND_CID */
#define CMD12			(0x40+12)	/* STOP_TRANSMISSION */
#define ACMD13			(0xC0+13)	/* SD_STATUS (SDC) */
#define CMD16			(0x40+16)	/* SET_BLOCKLEN */
#define CMD17			(0x40+17)	/* READ_SINGLE_BLOCK */
#define CMD18			(0x40+18)	/* READ_MULTIPLE_BLOCK */
#define CMD23			(0x40+23)	/* SET_BLOCK_COUNT (MMC) */
#define ACMD23			(0xC0+23)	/* SET_WR_BLK_ERASE_COUNT (SDC) */
#define CMD24			(0x40+24)	/* WRITE_BLOCK */
#define CMD25			(0x40+25)	/* WRITE_MULTIPLE_BLOCK */
#define CMD55			(0x40+55)	/* APP_CMD */
#define CMD58			(0x40+58)	/* READ_OCR */

static u8 Time;			// 1000Hz (1ms) decrement timer
static u8 CardType;
long start_time;			// time stamp in ms of when the last step was taken

/*	-----------------------------------------------------------------------------
	Wait for card ready in timeout of 500ms
	---------------------------------------------------------------------------*/

static u8 wait_ready(void)
{
	u8 res;

	Time = 500;							/* Wait for ready  */
	start_time = millis();
	
	SPI_write(DUMMY);
	do
		res = SPI_write(DUMMY);
	while ( (res != DUMMY) && ( (millis() - start_time) < Time) );

	return res;
}

/*	-----------------------------------------------------------------------------
	Deselect the card and release SPI bus
	---------------------------------------------------------------------------*/

static void release_spi (void)
{
	DESELECT();
	SPI_write(DUMMY);
}

/*	-----------------------------------------------------------------------------
	Power Control  (Platform dependent)
	-----------------------------------------------------------------------------
	When the target system does not support socket power control, there
	is nothing to do in these functions and chk_power always returns 1.
	---------------------------------------------------------------------------*/

static void power_on(void)
{
	// SPI Master mode, clock = FOSC/64, Mode 01
	//SSPSTAT = 0x40; // 0b0100.0000 => CKE = 1 & SMP = 0 (High-Speed mode 400 kHz)
	//SSPCON1 = 0x02; // 0b0000.0010 => CKP = 0 & SSPM = 0b0010
	DESELECT();
	SPI_init();
	//SPI_mode(SPI_MASTER);
	//SPI_clock(SPI_CLOCK_DIV64);
}

static void power_off(void)
{
	SELECT();				/* Wait for card ready */
	wait_ready();
	release_spi();

	//SSPCON1bits.SSPEN = 0;				/* Disable SPI1 */
}

/*	-----------------------------------------------------------------------------
	Send a command packet to MMC
	---------------------------------------------------------------------------*/

static u8 send_cmd(u8 cmd, u32 arg)
{
	u8 n, res;

	if (cmd & 0x80)
	{
		/* ACMD<n> is the command sequense of CMD55-CMD<n> */
		cmd &= 0x7F;
		res = send_cmd(CMD55, 0);
		if (res > 1) return res;
	}

	/* Select the card and wait for ready */
	DESELECT();
	SELECT();
	if (wait_ready() != DUMMY) return DUMMY;

	/* Send command packet */
	SPI_write(cmd);						/* Start + Command index */
	SPI_write((u8)(arg >> 24));		/* Argument[31..24] */
	SPI_write((u8)(arg >> 16));		/* Argument[23..16] */
	SPI_write((u8)(arg >> 8));			/* Argument[15..8] */
	SPI_write((u8)arg);					/* Argument[7..0] */
	n = 0x01;								/* Dummy CRC + Stop */
	if (cmd == CMD0) n = 0x95;			/* Valid CRC for CMD0(0) */
	if (cmd == CMD8) n = 0x87;			/* Valid CRC for CMD8(0x1AA) */
	SPI_write(n);

	/* Receive command response */
	if (cmd == CMD12) SPI_write(DUMMY);		/* Skip a stuff byte when stop reading */
	n = 10;								/* Wait for a valid response in timeout of 10 attempts */
	do
		res = SPI_write(DUMMY);
	while ((res & 0x80) && --n);

	return res;			/* Return with the response value */
}

/*	-----------------------------------------------------------------------------
	Initialize Disk Drive : SD.init
	---------------------------------------------------------------------------*/

DSTATUS disk_initialize(void)
{
	u8 n, cmd, ty, ocr[4];
	u16 tmr;

//	if (digitalread(SD_CD))	return STA_NODISK;	/* No card in the socket */

	power_on();												/* Force socket power on */
	//FCLK_SLOW();
	SPI_init();
	SPI_clock(SPI_PBCLOCK_DIV64);

	for (n = 10; n; n--) SPI_write(DUMMY);			/* Dummy clocks */
	
	ty = 0;
	/* Enter Idle state */
	if (send_cmd(CMD0, 0) == 1)
	{
		/* SDHC */
		if (send_cmd(CMD8, 0x1AA) == 1)
		{
			for (n = 0; n < 4; n++)
				ocr[n] = SPI_write(DUMMY);		/* Get trailing return value of R7 resp */
			/* The card can work at vdd range of 2.7-3.6V */
			if (ocr[2] == 0x01 && ocr[3] == 0xAA)
			{
				for (tmr = 25000; tmr && send_cmd(ACMD41, 1UL << 30); tmr--) ;	/* Wait for leaving idle state (ACMD41 with HCS bit) */
				/* Check CCS bit in the OCR */
				if (tmr && send_cmd(CMD58, 0) == 0)
				{
					for (n = 0; n < 4; n++)
						ocr[n] = SPI_write(DUMMY);
					ty = (ocr[0] & 0x40) ? CT_SD2 | CT_BLOCK : CT_SD2;	/* SDv2 */
				}
			}
		}
		/* SDSC or MMC */
		else
		{
			if (send_cmd(ACMD41, 0) <= 1)
			{
				ty = CT_SD1; cmd = ACMD41;	/* SDv1 */
			}
			else
			{
				ty = CT_MMC; cmd = CMD1;	/* MMCv3 */
			}
			for (tmr = 25000; tmr && send_cmd(cmd, 0); tmr--) ;	/* Wait for leaving idle state */
			if (!tmr || send_cmd(CMD16, 512) != 0)						/* Set R/W block length to 512 */
				ty = 0;
		}
	}
	
	CardType = ty;
	release_spi();
	
	if (ty)
	{
		/* Initialization succeded */
		//FCLK_FAST();
	 	SPI_init();
		SPI_clock(SPI_PBCLOCK_DIV16);
		return DRES_OK;
	}
	else
	{
		/* Initialization failed */
		power_off();
		return STA_NOINIT;
	}
}

/*	-----------------------------------------------------------------------------
	Read Partial Sector
	-----------------------------------------------------------------------------
	u8 *buff		Pointer to the read buffer (NULL:Read bytes are forwarded to the stream)
	u32 lba		Sector number (LBA)
	u16 ofs		Byte offset to read from (0..511)
	u16 cnt		Number of bytes to read (ofs + cnt mus be <= 512)
	---------------------------------------------------------------------------*/

DRESULT disk_readp (u8 *buff, u32 lba, u16 ofs, u16 cnt)
{
	DRESULT res;
	u8 rc;
	u16 bc;

	if (!(CardType & CT_BLOCK)) lba *= 512;	/* Convert to byte address if needed */

	res = DRES_ERROR;
	if (send_cmd(CMD17, lba) == 0) {				/* READ_SINGLE_BLOCK */

		Time = 200;										/* Wait for ready in timeout of 200ms */
		start_time = millis();
		do {												/* Wait for data packet in timeout of 200ms */
			rc = SPI_write(DUMMY);
		} while (rc == 0xFF && ( (millis() - start_time) < Time) );

		if (rc == 0xFE) {								/* A data packet arrived */
			bc = 514 - ofs - cnt;

			/* Skip leading bytes */
			if (ofs) {
				do SPI_write(DUMMY); while (--ofs);
			}

			/* Receive a part of the sector */
//			if (buff) {	/* Store data to the memory */
				do
					*buff++ = SPI_write(DUMMY);
				while (--cnt);
//			} else {	/* Forward data to the outgoing stream (depends on the project) */
//				do
//					xmit(rcvr_spi());	/* (Console output) */
//				while (--cnt);
//			}

			/* Skip trailing bytes and CRC */
			do SPI_write(DUMMY); while (--bc);

			res = cnt ? 1 : DRES_OK;
		}
	}

	release_spi();

	return res;
}

/*	-----------------------------------------------------------------------------
	Write partial sector
	-----------------------------------------------------------------------------
	const u8 *buff		Pointer to the bytes to be written (NULL:Initiate/Finalize sector write)
	u32 sa				Number of bytes to send, Sector number (LBA) or zero
	---------------------------------------------------------------------------*/

DRESULT disk_writep(const u8 *buff,	u32 sa)
{
	DRESULT res;
	u16 bc;
	static u16 wc;

	res = DRES_ERROR;

	if (buff)
	{		/* Send data bytes */
		bc = (u16)sa;
		while (bc && wc)
		{															/* Send data bytes to the card */
			SPI_write(*buff++);
			wc--; bc--;
		}
		res = DRES_OK;
	}
	else
	{
		if (sa)
		{	/* Initiate sector write process */
			if (!(CardType & CT_BLOCK)) sa *= 512;		/* Convert to byte address if needed */
			if (send_cmd(CMD24, sa) == 0)
			{														/* WRITE_SINGLE_BLOCK */
				SPI_write(0xFF);								/* Data block header */
				SPI_write(0xFE);								/* Data block header */
				wc = 512;										/* Set byte counter */
				res = DRES_OK;
			}
		}
		else
		{	/* Finalize sector write process */
			bc = wc + 2;
			while (bc--) SPI_write(0);	/* Fill left bytes and CRC with zeros */
			if ((SPI_write(DUMMY) & 0x1F) == 0x05)
			{	/* Receive data response and wait for end of write process in timeout of 300ms */
				for (bc = 65000; SPI_write(DUMMY) != 0xFF && bc; bc--) ;	/* Wait ready */
				if (bc) res = DRES_OK;
			}
			release_spi();
		}
	}

	return res;
}

#endif /* __DISKIO_C__ */

