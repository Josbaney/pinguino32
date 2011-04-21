/*	----------------------------------------------------------------------------
	FILE:			spi.c
	PROJECT:		pinguino
	PURPOSE:		Serial Peripheral Interface functions
	PROGRAMER:		Marcus Fazzi <anunakin@gmail.com>
	FIRST RELEASE:	16 mar. 2011
	LAST RELEASE:	18 mar. 2011
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
#ifndef __SPI_C
#define __SPI_C

#ifndef SPIx  //Use SPI port 1, see PIC32 Datasheet
#define SPIx 1
#endif

#if SPIx == 1
#define BUFFER		SPI1BUF
#define STATBIT		SPI1STATbits.SPIRBF
#define SPICONF		SPI1CON
#define CLKSPD		SPI1BRG
#endif

#if SPIx == 2
#define BUFFER		SPI2BUF
#define STATBIT		SPI2STATbits.SPIRBF
#define SPICONF		SPI2CON
#define CLKSPD		SPI2BRG
#define	PULLUPS		0xF00 //Use CNPUE = PULLUPS for enable internal pullups 8,9,10,11
#endif

//Only 795 boards have SPI3 and SPI4
#if defined(UBW32_795) || defined(EMPEROR795)

#if SPIx == 3
#define BUFFER		SPI2ABUF
#define STATBIT		SPI2ASTATbits.SPIRBF
#define SPICONF		SPI2ACON
#define CLKSPD		SPI2ABRG
#endif

#if SPIx == 4
#define BUFFER		SPI3ABUF
#define STATBIT		SPI3ASTATbits.SPIRBF
#define SPICONF		SPI3ACON
#define CLKSPD		SPI3ABRG
#endif

#endif
/** 
 * 0x8120,		   SPI->ON/CKE->1/CKP->0/8 bit Master
 * 159,            Fpb / (2 * (SPIxBRG + 1)  :.  80M / (2 * (149 +1)) = 250KHz
 */
void InitSPI(int speed, int clk){
	SPICONF = speed;
	CLKSPD  = clk;
}

void InitSPI0(){
	SPICONF = 0x8120;
	CLKSPD  = 159;
}

unsigned char WriteSPI( unsigned char data_out )
{
	BUFFER = data_out;				// write byte to SSPBUF register
	while( !STATBIT );	        	// wait until bus cycle complete
	return (SSPBUF);				// return response data
}

unsigned char ReadSPI( void )
{
	BUFFER = 0xFF;				// initiate bus cycle
	while ( !STATBIT );			// wait until cycle complete
	return ( BUFFER );			// return with byte read
}

#endif
