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

#ifndef __MILLIS__
#define __MILLIS__

#include <interrupt.c>

u32 _millis;

void millis_init(void)
{
	IntConfigureSystem(INT_SYSTEM_CONFIG_MULT_VECTOR);
	T2CON=0;
	TMR2=0x00;
	PR2=0x9C40;		// 1 mS
	IPC2SET = 0x0000000D;
	IFS0CLR = 0x00000100;
	IEC0SET = 0x00000100;
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

#pragma interrupt Tmr2Interrupt ipl3 vector 8
void Tmr2Interrupt(void)
{
	// is this an TMR2 interrupt ?
	if (IntGetFlag(INT_TIMER2))
	{
		TMR2=0;
		IFS0CLR=0x00000100;
		_millis++;
	}
}
	
#endif
