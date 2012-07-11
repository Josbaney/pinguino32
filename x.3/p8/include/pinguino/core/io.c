/*	----------------------------------------------------------------------------
	FILE:			io.c
	PROJECT:		pinguino
	PURPOSE:		Peripheral Remappage and IOs Configuration
	PROGRAMER:		Régis Blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	20 jun. 2012
	LAST RELEASE:	20 jun. 2012
	----------------------------------------------------------------------------
	CHANGELOG:
	[Date][Name][Description]
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

#ifndef __REMAP_C
#define __REMAP_C

#include <pic18fregs.h>
#include <typedef.h>
#include <const.h>
#include <macro.h>
#include <system.c>

void IOsetSpecial()
{
}

// All Analog Pins as Digital IOs
void IOsetDigital()
{
	#if defined(PIC18F4550) || defined(PIC18F4455) || defined(PIC18F2550) || defined(PIC18F2455)
	ADCON1 = 0x0F;				// AN0 to AN12 Digital I/O
	#endif

	#if defined(PIC18F26J50)
	ANCON0 = 0xFF;				// AN0 to AN7  Digital I/O
	ANCON1 = 0x1F;				// AN8 to AN12 Digital I/O
	#endif
}

/**
 * PIC  PINGUINO    PPS
 * 0    RB0         RP3
 * 1    RB1         RP4
 * 2    RB2         RP5
 * 3    RB3         RP6
 * 4    RB4         RP7
 * 5    RB5         RP8
 * 6    RB6         RP9
 * 7    RB7         RP10
 * 8    RC6         RP17
 * 9    RC7         RP18
 * 10   RC0         RP11
 * 11   RC1         RP12
 * 12   RC2         RP13
 * 13   RA0         RP0
 * 14   RA1         RP1
 * 15   RA2         -
 * 16   RA3         -
 * 17   RA5         RP2
 **/
// Peripheral Remappage
// NB1 : the Configuration bit IOL1WAY is set to OFF in the bootloader
// NB2 : pins must be explicitly reconfigured as digital I/O when used with a PPS

void IOsetRemap()
{
    #if defined(PIC18F26J50)

	SystemUnlock();
	PPSCONbits.IOLOCK = 0;			// Turn off PPS Write Protect
	SystemLock();

	#ifdef __SERIAL__
    RPINR16 = 4;                    // RP4 <- RX2
    RPOR3 = 5;                      // RP3 -> TX2 (func. num. 5)
    //RPINR17 = ;                     // EUSART2 Clock Input (CKR2)
	#endif

	#ifdef __SPI2__
    RPINR21 = 6;                    // RP6 (RB3) <- SDI2
    RPOR5 = 10;                     // RP5 (RB2) -> SCK2
    RPOR4 = 9;                      // RP4 (RB1) -> SDO2 (func. num. 9)
    //RPOR3 = 12;                     // RP3 (RB0) -> SS2 (SPI DMA Slave Select)
	#endif

	#ifdef __PWM__
    // TODO
    // RPINR24 = ;                     // PWM Fault Input (FLT0)
    
	#endif

	SystemUnlock();
	PPSCONbits.IOLOCK = 1;			// Turn on PPS Write Protect
	SystemLock();

    #endif /* defined(PIC18F26J50) */
}

#endif /* __REMAP_C */
