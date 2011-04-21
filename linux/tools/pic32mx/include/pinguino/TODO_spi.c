/*	----------------------------------------------------------------------------
	FILE:			spi.c
	PROJECT:		pinguino
	PURPOSE:		Serial Peripheral Interface functions
	PROGRAMER:		regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	04 jan. 2011
	LAST RELEASE:	04 jan. 2011
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

#ifndef __SPI_C
	#define __SPI_C

unsigned char WriteSPI( unsigned char data_out )
{
	SSPBUF = data_out;				// write byte to SSPBUF register
	if ( SSPCON1 & 0x80 )			// test if write collision occurred
		return (-1);				// if WCOL bit is set return negative #
	else
		while( !SSPSTATbits.BF );	// wait until bus cycle complete
	return (0);						// if WCOL bit is not set return non-negative#
}

unsigned char ReadSPI( void )
{
	SSPBUF = 0x00;					// initiate bus cycle
	while ( !SSPSTATbits.BF );		// wait until cycle complete
	return ( SSPBUF );				// return with byte read
}

#endif
