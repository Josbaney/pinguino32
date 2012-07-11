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

// 05 jul 2012 gagabi Added support for GENERIC 32 bits boards
// 06 feb 2012 Z Added volatile for _millis variable
// 17 apr 2010 Regis Blanchot added millis=f(pbclk)

#ifndef __MILLIS__
#define __MILLIS__

#include <interrupt.c>
#include <system.c>

/**
 * This variable is accessed both by the ISR and "normal" code. It
 * must be declared as "volatile" to prevent caching.
 */
volatile u32 _millis;
#if defined(PIC32_PINGUINO_220)||defined(GENERIC32MX250F128)||defined(GENERIC32MX220​F032)
volatile u32 _tmr2;
#endif

void millis_init(void)
{
	u32 pf;			// peripheral bus frequency

	pf = GetPeripheralClock();
	IntConfigureSystem(INT_SYSTEM_CONFIG_MULT_VECTOR);
	T2CON=0;
	#if defined(PIC32_PINGUINO_220)||defined(GENERIC32MX250F128)||defined(GENERIC32MX220​F032)
	_tmr2 = pf / 1000 / 2;
	TMR2 = 65535 - _tmr2;
	IPC2bits.T2IP=1;
	IPC2bits.T2IS=1;
	IFS0bits.T2IF=0;
	IEC0bits.T2IE=1;
	#else
	TMR2=0x00;
	PR2 = pf / 1000 / 2; //0x4E00;
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
	#if defined(PIC32_PINGUINO_220)||defined(GENERIC32MX250F128)||defined(GENERIC32MX220​F032)
	TMR2 = _tmr2; // 0xD910;	// because PR2 don't work on PIC32MX220F032D
	if (IFS0bits.T2IF)
	#else
	if (IntGetFlag(INT_TIMER2)) // TODO : add PIC32_PINGUINO_220 support
	#endif
	{
		#if defined(PIC32_PINGUINO_220)||defined(GENERIC32MX250F128)||defined(GENERIC32MX220​F032)
		IFS0bits.T2IF=0;
		#else
		//IFS0CLR=0x00000100;
		IntClearFlag(INT_TIMER2);
		#endif
		_millis++;
	}
}
	
#endif	/* __MILLIS__ */
