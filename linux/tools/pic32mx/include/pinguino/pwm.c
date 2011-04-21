/*	----------------------------------------------------------------------------
	FILE:			pwm.c
	PROJECT:		pinguinoX
	PURPOSE:		
	PROGRAMER:		jean-pierre mandon <jp.mandon@gmail.com>
	FIRST RELEASE:	20 feb. 2011
	LAST RELEASE:	26 feb. 2011
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
// 2 .april 2011 fixed conditional compilation for board support  jp.mandon

#ifndef __PWM__
#define __PWM__

#include <typedef.h>
#include <macro.h>
#include <const.h>

/*	----------------------------------------------------------------------------
	init_pwm
	PWM use Timer 3 with a fixed value of 20 khz
	resolution is 10 bits.
	--------------------------------------------------------------------------*/
	
void pwm_init(void)
{
	T3CON|=0x8020;		// timer 3 use a 1:4 prescaler for PWM 20 khz
	PR3=1023;			// resolution is 10 bits ( 0..1023 )
}

u8 analogwrite(u8 pin,u16 setpoint)
{
#ifdef PIC32_PINGUINO
	switch (pin)
		{
			case 2:  TRISDSET=0x10;
					 TRISDCLR=0x01;
					 OC1CON=0;
					 OC1R=setpoint;
					 OC1RS=setpoint;
					 OC1CON=0x000E;
					 OC1CON|=0x8000;
					 return 1;
					 break;
			case 0:  TRISDCLR=0x02;
					 OC2CON=0;
					 OC2R=setpoint;
					 OC2RS=setpoint;
					 OC2CON=0x000E;
					 OC2CON|=0x8000;
					 return 1;
					 break;
			case 1:  TRISDCLR=0x04;
					 OC3CON=0;
					 OC3R=setpoint;
					 OC3RS=setpoint;
					 OC3CON=0x000E;
					 OC3CON|=0x8000;
					 return 1;
					 break;
			default: return 0;
		}		
#endif
#if defined(EMPEROR460) || defined(EMPEROR795)
	switch (pin)
		{
			case  0:
			case 72: TRISDCLR=0x01;
					 OC1CON=0;
					 OC1R=setpoint;
					 OC1RS=setpoint;
					 OC1CON=0x000E;
					 OC1CON|=0x8000;
					 return 1;
					 break;
			case  1:
			case 69: TRISDCLR=0x02;
					 OC2CON=0;
					 OC2R=setpoint;
					 OC2RS=setpoint;
					 OC2CON=0x000E;
					 OC2CON|=0x8000;
					 return 1;
					 break;
			case  2:
			case 68: TRISDCLR=0x04;
					 OC3CON=0;
					 OC3R=setpoint;
					 OC3RS=setpoint;
					 OC3CON=0x000E;
					 OC3CON|=0x8000;
					 return 1;
					 break;
			case  3:
			case 67: TRISDCLR=0x08;
					 OC4CON=0;
					 OC4R=setpoint;
					 OC4RS=setpoint;
					 OC4CON=0x000E;
					 OC4CON|=0x8000;
					 return 1;
					 break;
			case  4:
			case 66: TRISDCLR=0x10;
					 OC5CON=0;
					 OC5R=setpoint;
					 OC5RS=setpoint;
					 OC5CON=0x000E;
					 OC5CON|=0x8000;
					 return 1;
					 break;
			default: return 0;
		}		
#endif
#if defined(UBW32_460) || defined(UBW32_795)
	switch (pin)
		{
			case  0:
			case 40: TRISDCLR=0x01;
					 OC1CON=0;
					 OC1R=setpoint;
					 OC1RS=setpoint;
					 OC1CON=0x000E;
					 OC1CON|=0x8000;
					 return 1;
					 break;
			case  1:
			case 43: TRISDCLR=0x02;
					 OC2CON=0;
					 OC2R=setpoint;
					 OC2RS=setpoint;
					 OC2CON=0x000E;
					 OC2CON|=0x8000;
					 return 1;
					 break;
			case  2:
			case 44: TRISDCLR=0x04;
					 OC3CON=0;
					 OC3R=setpoint;
					 OC3RS=setpoint;
					 OC3CON=0x000E;
					 OC3CON|=0x8000;
					 return 1;
					 break;
			case  3:
			case 45: TRISDCLR=0x08;
					 OC4CON=0;
					 OC4R=setpoint;
					 OC4RS=setpoint;
					 OC4CON=0x000E;
					 OC4CON|=0x8000;
					 return 1;
					 break;
			case  4:
			case 60: TRISDCLR=0x010;
					 OC5CON=0;
					 OC5R=setpoint;
					 OC5RS=setpoint;
					 OC5CON=0x000E;
					 OC5CON|=0x8000;
					 return 1;
					 break;
			default: return 0;
		}		
#endif
}
			
#endif
