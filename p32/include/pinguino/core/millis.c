/*	----------------------------------------------------------------------------
	FILE:			millis.c
	PROJECT:		pinguinoX
	PURPOSE:		
	PROGRAMER:		jean-pierre mandon <jp.mandon@gmail.com>
	FIRST RELEASE:	19 feb. 2011
	LAST RELEASE:	19 feb. 2011
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

// 06 feb 2012 Z Added volatile for _millis variable

#ifndef __MILLIS__
#define __MILLIS__

#include <interrupt.c>

/**
 * This variable is accessed both by the ISR and "normal" code. It
 * must be declared as "volatile" to prevent caching.
 */
volatile u32 _millis;

void millis_init(void)
{
	IntConfigureSystem(INT_SYSTEM_CONFIG_MULT_VECTOR);
	T2CON=0;
	TMR2=0x00;
	#ifdef PIC32_PINGUINO_220
	IPC2bits.T2IP=1;
	IPC2bits.T2IS=1;
	IFS0bits.T2IF=0;
	IEC0bits.T2IE=1;
	#else
	PR2=0x4E00;
	IPC2SET = 0x0000000D;
	IFS0CLR = 0x00000100;
	IEC0SET = 0x00000100;
	#endif
	T2CONSET = 0x8010;		// prescale=1/2
	_millis = 0;
}

u32 millis()
{
	return(_millis);
}

/*	----------------------------------------------------------------------------
	TMR2 interrupt
	--------------------------------------------------------------------------*/

//#pragma interrupt Tmr2Interrupt ipl3 vector 8
void Tmr2Interrupt()
{
	// is this an TMR2 interrupt ?
	#ifdef PIC32_PINGUINO_220
	TMR2=0xD910;	// because PR2 don't work on PIC32MX220F032D
	if (IFS0bits.T2IF)
	#else
	if (IntGetFlag(INT_TIMER2))
	#endif
	{
		#ifdef PIC32_PINGUINO_220
		IFS0bits.T2IF=0;
		#else
		IFS0CLR=0x00000100;
		#endif
		_millis++;
	}
}
	
#endif	/* __MILLIS__ */
