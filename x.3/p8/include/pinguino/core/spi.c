/**
 * SPI Hardware library for pinguino project
 *
 * Author: Francisco J. Sánchez Rivas (FJ_Sanchez) <fran [at] mipixel [dot] com>
 * http://www.mipixel.com
 *
 * 20-05-2011 Modified by Régis Blanchot <rblanchot@gmail.com>
 */

#ifndef __SPI_C__
#define __SPI_C__

#define SPI

#include <pic18fregs.h>
#include <typedef.h>
#include <spi.h>
#include <digitalw.c>

u8 this_mode = SPI_MODE1;
u8 this_clock = SPI_CLOCK_DIV4;
u8 this_role = SPI_MASTER;

/**
 * This function initializes the SPI hardware configuring polarity and edge
 * of transition using Standard SPI Mode Terminology (datasheet Table 19-1 p206)
 *
 *    Mode0,Mode1 CKP   CKE
 *    0,0         0     1
 *    0,1         0     0
 *    1,0         1     1
 *    1,1         1     0
 *
 * Also is possible to use LOW or HIGH for mode0 to indicate the idle state
 * clock level, and RISING or FALLING to indicate when the transmit should
 * take place.
 *
 * The role param could be any of SPI_MASTER, MASTER_FOSC_4, MASTER_FOSC_16,
 * MASTER_FOSC_64, SLAVE or SLAVE_SS, where MASTER_FOSC_X indicates the SPI
 * clock speed used. If you want to use the /SS pin in slave mode you should
 * initialize the SPI using SPI_SLAVE_SS.
 */

void SPI_init()
{
	SSPCON1bits.SSPEN = 0;

	switch(this_mode)
	{
		case SPI_MODE0:
			SSPCON1bits.CKP = 0;
			SSPSTATbits.CKE = 1;
			break;
		case SPI_MODE1:
			SSPCON1bits.CKP = 0;
			SSPSTATbits.CKE = 0;
			break;
		case SPI_MODE2:
			SSPCON1bits.CKP = 1;
			SSPSTATbits.CKE = 1;
			break;
		case SPI_MODE3:
			SSPCON1bits.CKP = 1;
			SSPSTATbits.CKE = 0;
			break;
	}

	SSPCON1 = (SSPCON1 & 0xF7) | this_mode;

	if (this_clock <= SPI_CLOCK_TIMER2)
		pinmode(SCKPIN, OUTPUT);
	else
		pinmode(SCKPIN, INPUT);
		
	pinmode(SDIPIN, INPUT);
	pinmode(SDOPIN, OUTPUT);
	if (this_role == SPI_SLAVE_SS)
		pinmode(SSPIN, INPUT);

	SSPCON1bits.SSPEN = 1;
}

/**
 * This function sets the order of the bits shifted out of and into the SPI bus,
 * either LSBFIRST (least-significant bit first) or MSBFIRST (most-significant bit first). 
 */

void SPI_setBitOrder(u8 bitOrder)
{
	bitOrder = 0;
}

/**
 *	This function sets the SPI data mode (clock polarity and phase)
 *	mode is SPI_MODE0, SPI_MODE1, SPI_MODE2, or SPI_MODE3
 */
 
void SPI_setDataMode(u8 mode)
{
	this_mode = mode;
}

/**
 * This function sets the SPI clock divider relative to the system clock.
 * The dividers available are 4, 16, 64.
 * The default setting is SPI_CLOCK_DIV4, which sets the SPI clock to one-quarter
 * the frequency of the system clock. 
 */

void SPI_setClockDivider(u8 clock)
{
	this_clock = clock;
	this_role = this_clock;
}

/**
 * Function used to send a byte. In case that the microcontroller act as
 * master, this function provides the needed clock and returns the received
 * byte from the slave. In case that it's configured as slave, it waits for
 * a clock signal to send the byte.
 */

char SPI_write(char c)
{
	char junk;
	PIR1bits.SSPIF = 0;
	if(SSPCON1bits.SSPOV)
		SSPCON1bits.SSPOV = 0;
	junk = SSPBUF;
	SSPBUF = c;
	while(!SSPSTATbits.BF);
	c = SSPBUF;
	return c;
}

/**
 * This function is a simple call to the write function sending 0x00. This
 * is used to force the clock signal in case it's configured as master. In case
 * it's configured as slave, it checks if any byte is already in the buffer, if
 * it's empty it waits for a clock signal and returns the received byte.
 */
 
char SPI_read(void)
{
	char c;

	if(SSPSTATbits.BF)
		c = SSPBUF;
	else
		c = SPI_write(0x00);

	return c;
}

#endif

