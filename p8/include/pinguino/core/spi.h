/**
 * SPI Hardware library for pinguino project
 *
 * Author: Francisco J. Sánchez Rivas (FJ_Sanchez)
 * fran [at] mipixel [dot] com
 *
 * http://www.mipixel.com
 *
 */
 
#ifndef __SPI_H__
#define __SPI_H__

// pins
#define SDIPIN		TRISBbits.TRISB0
#define SDOPIN		TRISCbits.TRISC7
#define SCKPIN		TRISBbits.TRISB1
#define SSPIN		TRISAbits.TRISA5

/*	----------------------------------------------------------------------------
	---------- *** MODES ***
	----------------------------------------------------------------------------
	SSPM<3:0>: Synchronous Serial Port Mode Select bits
	0000 = SPI Master mode, clock = FOSC/4
	0001 = SPI Master mode, clock = FOSC/16
	0010 = SPI Master mode, clock = FOSC/64
	0011 = SPI Master mode, clock = TMR2 output/2
	0100 = SPI Slave mode, clock = SCK pin, SS pin control enabled
	0101 = SPI Slave mode, clock = SCK pin, SS pin control disabled, SS can be used as I/O pin
	---------------------------------------------------------------------------*/

#define SPI_MASTER			0x00
#define SPI_MASTER_FOSC_4	0x00
#define SPI_MASTER_FOSC_16	0x01
#define SPI_MASTER_FOSC_64	0x02
#define SPI_MASTER_FOSC_T2	0x03
#define SPI_SLAVE_SS			0x04
#define SPI_SLAVE				0x05

#define SPI_CLOCK_DIV4		0x00
#define SPI_CLOCK_DIV16		0x01
#define SPI_CLOCK_DIV64		0x02
#define SPI_CLOCK_TIMER2	0x03

#define SPI_MODE0				0x00
#define SPI_MODE1				0x04
#define SPI_MODE2				0x08
#define SPI_MODE3				0x0C


#define SPI_FALLING_EDGE	0x00  // negated
#define SPI_RISING_EDGE		0x01  // negated

#endif   /* __SPI_H__ */
