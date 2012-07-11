/*	----------------------------------------------------------------------------
	FILE:			system.c
	PROJECT:		pinguino
	PURPOSE:		pinguino system functions
	PROGRAMER:		regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	5 jan. 2011
	LAST RELEASE:	5 jan. 2011
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

#ifndef __SYSTEM_C
#define __SYSTEM_C

#include <pic18fregs.h>
#include <typedef.h>
#include <const.h>
#include <macro.h>

#define GetSystemClock()	    48000000
#define GetInstructionClock()	(GetSystemClock()/4)
#define GetPeripheralClock()	GetInstructionClock()	

u8 _gie_status_ = 0;

/*	----------------------------------------------------------------------------
	SystemUnlock() perform a system unlock sequence
	--------------------------------------------------------------------------*/

void SystemUnlock()
{
    if (INTCONbits.GIE)
    {
        INTCONbits.GIE = 0; // disable interrupts
        _gie_status_ = 1;
    }
    EECON2 = 0x55;          // magic sequence
    EECON2 = 0xAA;
/*
    __asm
    movlw   0x55
    movwf   _EECON2,1 
    movlw   0xAA
    movwf   _EECON2,1
    __endasm;
*/
}

/*	----------------------------------------------------------------------------
	SystemLock() relock OSCCON by relocking the SYSKEY
	--------------------------------------------------------------------------*/

void SystemLock()
{
    if (_gie_status_)
        INTCONbits.GIE = 1; // enable interrupts back
}

/*	----------------------------------------------------------------------------
	Software Reset
	--------------------------------------------------------------------------*/

void SystemReset()
{
	// TODO
	// prevent any unwanted code execution until reset occurs
	while(1);
}

#endif

