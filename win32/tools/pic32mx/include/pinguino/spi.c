/*	----------------------------------------------------------------------------
	FILE:			spi.c
	PROJECT:		pinguino
	PURPOSE:		Serial Peripheral Interface functions
	PROGRAMER:		Marcus Fazzi <anunakin@gmail.com>
	FIRST RELEASE:	16 mar. 2011
	LAST RELEASE:	24 may. 2011
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
/**
 *  This library expects 80MHz clock, default for Pinguino32X.
 * 
 *	Microchip making changes do SPI SFR numbers and changing 2A to 3, and 3A to 4
 *  but it need a new processor.o and updated compiler libraries, not released at this time.
 *  
 *  MX440 and MX460 have only 2 SPI ports
 */

// 24 may. 2011 fixed a bug in writeSPI, RX int flag must be called even for write jp.mandon

#ifndef __SPI_C
#define __SPI_C

#ifndef SPIx  		//Use SPI port 1, see PIC32 Datasheet
#define SPIx 2		// default SPI port is 2 ( 32MX440F256H has only one SPI port )
#endif

#if defined(UBW32_460) || defined(EMPEROR460)

#if (SPIx == 1)
#define BUFFER		SPI1BUF
#define STATRX  	SPI1STATbits.SPIRBF	// receive buffer full
#define STATTX		SPI1STATbits.SPITBE	// transmit buffer full
#define SPICONF		SPI1CON
#define CLKSPD		SPI1BRG
#endif

#endif

#if (SPIx == 2)
#define BUFFER		SPI2BUF
#define STATRX  	SPI2STATbits.SPIRBF	// receive buffer full
#define STATTX		SPI2STATbits.SPITBE	// transmit buffer full
#define SPICONF		SPI2CON
#define CLKSPD		SPI2BRG
#define	PULLUPS		0xF00 //Use CNPUE = PULLUPS for enable internal pullups 8,9,10,11
#endif 

//Only 795 boards have SPI3 and SPI4
#if defined(UBW32_795) || defined(EMPEROR795)

#if (SPIx == 3)
#define BUFFER		SPI3ABUF
#define STATRX  	SPI3ASTATbits.SPIRBF	// receive buffer full
#define STATTX		SPI3ASTATbits.SPITBE	// transmit buffer full
#define SPICONF		SPI3ACON
#define CLKSPD		SPI3ABRG
#endif

#if (SPIx == 4)
#define BUFFER		SPI4ABUF
#define STATRX  	SPI4ASTATbits.SPIRBF	// receive buffer full
#define STATTX		SPI4ASTATbits.SPITBE	// transmit buffer full
#define SPICONF		SPI4ACON
#define CLKSPD		SPI4ABRG
#endif

#endif
/** 
 * 0x8220,		   SPI->ON/CKE->1/CKP->0/8 bit Master 0x8120
 * 159,            Fpb / (2 * (SPIxBRG + 1)  :.  80M / (2 * (149 +1)) = 250KHz
 */
void InitSPI(int speed, int clk){
	SPICONF = speed;
	CLKSPD  = clk;
}

void InitSPI0(){
	SPICONF=0x8120;
	CLKSPD=149;
}

unsigned int WriteSPI( unsigned int data_out )
{
	BUFFER = data_out; 	// write to buffer for TX
	while( !STATRX); 	// wait for transfer complete
	return BUFFER;
}

unsigned int ReadSPI( void )
{
	BUFFER=0x00;
	while ( !STATRX );			// wait until cycle complete
	return ( BUFFER );			// return with byte read
}

#endif
