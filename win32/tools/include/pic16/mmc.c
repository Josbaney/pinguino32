/*	----------------------------------------------------------------------------
	FILE:			mmc.c
	PROJECT:		pinguino
	PURPOSE:		Serial Peripheral Interface functions
	PROGRAMER:		Written by Ed Waugh 2004, http://www.edwaugh.co.uk
					original source : http://www.microchipc.com/sourcecode/#mmc
	ADAPTED BY:		regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	31 jan. 2011
	LAST RELEASE:	31 jan. 2011
	----------------------------------------------------------------------------
	TODO : 
	----------------------------------------------------------------------------
	This library is free software; you can redistribute it and/or
	modify it under the terms of the GNU Lesser General Public
	License as published by the Free Software Foundation; either
	version 2.1 of the License, or (at your option) any later version.

	This library is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
	Lesser General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with this library; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
	--------------------------------------------------------------------------*/

#ifndef __MMC_C
	#define __MMC_C

#include <spi.c>

int MMC_init();
int MMC_response(u8 response);
int MMC_read_block(u16 block_number);
int MMC_write_block(u16 block_number);
int MMC_get_status();


/************************** MMC Init **************************************/
/* Initialises the MMC into SPI mode and sets block size, returns 0 on success */

int MMC_init()
{
	int i;

	//SPI_init(SPI_MASTER | SPI_H_TO_L | SPI_CLK_DIV_4 | SPI_SS_DISABLED);
	SPI_init(SPI_MASTER_MODE_CLOCK_FOSC4, SPI_MODE_00, SPI_HIGH_SPEED_MODE)

	pinmode(SPI_SLAVE_SELECT, OUTPUT);
	digitalwrite(SPI_SLAVE_SELECT, HIGH);	// set SS = 1 (off)

	for(i=0;i<10;i++)						// initialise the MMC card into SPI mode by sending clks on
		SPI_write(0xFF);

	digitalwrite(SPI_SLAVE_SELECT, LOW);	// set SS = 0 (on) tells card to go to spi mode when it receives reset

	SPI_write(0x40);						// send reset command
	SPI_write(0x00);						// all the arguments are 0x00 for the reset command
	SPI_write(0x00);
	SPI_write(0x00);
	SPI_write(0x00);
	SPI_write(0x95);						// precalculated checksum as we are still in MMC mode

	//puts("Sent go to SPI\n\r");

	if(MMC_response(0x01)==1) return 1;		// if = 1 then there was a timeout waiting for 0x01 from the mmc

	//puts("Got response from MMC\n\r");

	i = 0;

	while((i < 255) && (MMC_response(0x00)==1))// must keep sending command if response
	{
		SPI_write(0x41);					// send mmc command one to bring out of idle state
		SPI_write(0x00);					// all the arguments are 0x00 for command one
		SPI_write(0x00);
		SPI_write(0x00);
		SPI_write(0x00);
		SPI_write(0xFF);					// checksum is no longer required but we always send 0xFF
		i++;
	}
	if(i >= 254) return 1;					// if >= 254 then there was a timeout waiting for 0x00 from the mmc

	//puts("Got out of idle response from MMC\n\r");

	digitalwrite(SPI_SLAVE_SELECT, HIGH);	// set SS = 1 (off)

	SPI_write(0xFF);						// extra clocks to allow mmc to finish off what it is doing

	digitalwrite(SPI_SLAVE_SELECT, LOW);	// set SS = 0 (on)

	SPI_write(0x50);						// send mmc command one to bring out of idle state
	SPI_write(0x00);
	SPI_write(0x00);
	SPI_write(0x02);						// high block length bits - 512 bytes
	SPI_write(0x00);						// low block length bits
	SPI_write(0xFF);						// checksum is no longer required but we always send 0xFF

	if((MMC_response(0x00))==1) return 1;
	digitalwrite(SPI_SLAVE_SELECT, HIGH);	// set SS = 1 (off)
	//puts("Got set block length response from MMC\n\r");
	return 0;
}

/************************** MMC Get Status **************************************/
/* Get the status register of the MMC, for debugging purposes */

int MMC_get_status()
{
	digitalwrite(SPI_SLAVE_SELECT, LOW);	// set SS = 0 (on)

	SPI_write(0x58);						// send mmc command one to bring out of idle state
	SPI_write(0x00);
	SPI_write(0x00);
	SPI_write(0x00);
	SPI_write(0x00);						// always zero as mulitples of 512
	SPI_write(0xFF);						// checksum is no longer required but we always send 0xFF

	digitalwrite(SPI_SLAVE_SELECT, HIGH);	// set SS = 1 (off)
	return 0;
}

/************************** MMC Write Block **************************************/

int MMC_write_block(u16 block_number)
{
	u16 i;
	u16 varh,varl;

	varl=((block_number&0x003F)<<9);
	varh=((block_number&0xFFC0)>>7);

	//puts("Write block\n\r");				// block size has been set in MMC_init()

	digitalwrite(SPI_SLAVE_SELECT, LOW);	// set SS = 0 (on)

	SPI_write(0x58);						// send mmc write block
	SPI_write(HIGH(varh));
	SPI_write(LOW(varh));
	SPI_write(HIGH(varl));
	SPI_write(0x00);						// always zero as mulitples of 512
	SPI_write(0xFF);						// checksum is no longer required but we always send 0xFF

	if((MMC_response(0x00))==1) return 1;
	//puts("Got response to write block\n\r");

	SPI_write(0xFE);						// send data token

	for(i=0;i<512;i++)
		SPI_write(i2c_eeprom_read(HIGH(i),LOW(i)));// send data

	SPI_write(0xFF);						// dummy CRC
	SPI_write(0xFF);

	if((SPI_read(0xFF)&0x0F)!=0x05) return 1;

	//puts("Got data response to write block\n\r");

	digitalwrite(SPI_SLAVE_SELECT, HIGH);	// set SS = 1 (off)
	return 0;
}



/************************** MMC Read Block **************************************/
/**** Reads a 512 Byte block from the MMC and out//puts each byte to RS232 ****/

int MMC_read_block(u16 block_number)
{
	u16 i;
	u16 varh,varl;

	varl=((block_number&0x003F)<<9);
	varh=((block_number&0xFFC0)>>7);

	digitalwrite(SPI_SLAVE_SELECT, LOW);	// set SS = 0 (on)

	SPI_write(0x51);						// send mmc read single block command
	SPI_write(HIGH(varh));					// arguments are address
	SPI_write(LOW(varh));
	SPI_write(HIGH(varl));
	SPI_write(0x00);
	SPI_write(0xFF);						// checksum is no longer required but we always send 0xFF

	if((MMC_response(0x00))==1) return 1;	// if MMC_response returns 1 then we failed to get a 0x00 response (affirmative)

	//puts("Got response to read block command\n\r");

	if((MMC_response(0xFE))==1) return 1;	// wait for data token

	//puts("Got data token\n\r");

	for(i=0;i<512;i++)
		putc(SPI_read(0xFF));				// we should now receive 512 bytes

	SPI_read(0xFF);							// CRC bytes that are not needed
	SPI_read(0xFF);

	digitalwrite(SPI_SLAVE_SELECT, HIGH);	// set SS = 1 (off)
	SPI_write(0xFF);						// give mmc the clocks it needs to finish off

	//puts("\n\rEnd of read block\n\r");

	return 0;
}

/************************** MMC get response **************************************/
/**** Repeatedly reads the MMC until we get the response we want or timeout ****/

int MMC_response(u8 response)
{
	u16 count = 0xFFFF;					 	// 16bit repeat, it may be possible to shrink this to 8 bit but there is not much point

	while(SPI_read(0xFF) != response && --count > 0);

	if(count==0) return 1;					// loop was exited due to timeout
	else return 0;							// loop was exited before timeout
}

#endif
