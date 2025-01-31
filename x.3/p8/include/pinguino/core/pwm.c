/*	----------------------------------------------------------------------------
	FILE:			pwm.c
	PROJECT:		pinguino
	PURPOSE:		new hardware PWM control functions
	PROGRAMER:		regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	10 oct. 2010
	LAST RELEASE:	24 dec. 2010
	----------------------------------------------------------------------------
	freely adapted from JAL PWM Control Library.
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

#ifndef __PINGUINOPWM
#define __PINGUINOPWM

#include <pic18fregs.h>
#include <typedef.h>
#include <digitalw.c>
#include <system.c>
#include <interrupt.c>

#ifdef PICUNO_EQUO
	#define CCP1 		5
	#define CCP2 		6
//	#define	CCP2_ALT	3	//Digital Pin 3 = RB3. 
							//If the Configuration bit CCP2MX = 0, CCP2 is multiplexed with RB3.
							//But this can only be done if user can change the Configuration bit in bootloader firmware.
#else
	#define CCP1 		12
	#define CCP2 		11
#endif

/*----------------------------------------------------------------------------
GLOBAL VARIABLES
--------------------------------------------------------------------------*/

u16 _pr2_plus1 = 256;				// shadow value of PR2 set to max. + 1 
u8  _t2con;							// shadow value of T2CON

/*----------------------------------------------------------------------------
PWM_set_frequency
----------------------------------------------------------------------------
@param:	frequency in hertz (range 3kHz .. 12MHz)
----------------------------------------------------------------------------
let's say p = TMR2 Prescale Value
PWM Period 	= [(PR2) + 1] * 4 * TOSC * p
so [(PR2) + 1] = PWM Period / (4 * TOSC * p)
but PWM Period 	= 1 / PWM Frequency
so [(PR2) + 1] = (1/PWM Frequency) / (4 * 1/FOSC * p)
and [(PR2) + 1] = FOSC / (4 * PWM Frequency * p)
then [(PR2) + 1] = FOSC / PWM Frequency / 4 / p
--------------------------------------------------------------------------*/

void PWM_set_frequency(u32 freq)
{
	// PR2+1 calculation
	_pr2_plus1 = GetSystemClock() / 4 / freq;	// FOSC / (4 * PWM Frequency)

	// Timer2 prescaler calculation
	// PR2 max value is 255, so PR2+1 max value is 256
	// highest prescaler value is 16
	// 16 * 256 = 4096 so :
	if (_pr2_plus1 <= 4096)					// check if it's not too high
	{
		if (_pr2_plus1 <= 256)				// no needs of any prescaler
		{
			_t2con = 0b00;					// prescaler is 1
		}
		else if (_pr2_plus1 <= 1024)		// needs prescaler 1:4
		{
			_pr2_plus1 = _pr2_plus1 >> 2;	// divided by 4
			_t2con = 0b01;					// prescaler is 4
		}
		else								// needs prescaler 1:6
		{
			_pr2_plus1 = _pr2_plus1 >> 4;	// divided by 16
			_t2con = 0b10;					// prescaler is 16
		}
	}
}

/*----------------------------------------------------------------------------
PWM_set_dutycycle
----------------------------------------------------------------------------
Set dutycycle with 10-bits resolution, allowing 1024 PWM steps.
The 'duty' argument is a (max) 10-bits absolute value for the duty cycle:
* duty<1:0> are the 2 LSbits
* duty<9:2> are the 8 MSbits
Allowed range: 0..1023
@param pin:		CCPx pin where buzzer is connected (5 or 6)
@param duty:	10-bit duty cycle
----------------------------------------------------------------------------
PWM Duty Cycle = (CCPRxL:CCPxCON<5:4>) * Tosc * TMR2 prescaler
(CCPRxL:CCPxCON<5:4>) = PWM Duty Cycle / (Tosc * TMR2 prescaler)
--------------------------------------------------------------------------*/

void PWM_set_dutycycle(u8 pin, u16 duty)
{
	u8 temp;

	if (duty > 1023) duty = 1023;		// upper limit (10-bit)

	// PWM pin as INPUT
	pinmode(pin, INPUT);				// PWM pin as INPUT
	// PWM period
	PR2 = _pr2_plus1 - 1;				// set PR2

	switch (pin)
	{
		case CCP1:
			// PWM mode	
			CCP1CON = 0b00001111;
			// PWM duty cycle (10-bit)
			temp = duty & 0b00000011;		// extract 2 LSbits of the duty
			temp <<= 4;						// shift left 4 bits
			CCP1CON |= temp;				// put in CCP2CON 4:5
			CCPR1L = duty >> 2;				// 8 MSbits of the duty
			break;
		case CCP2:
			// PWM mode	
			CCP2CON = 0b00001111;			// reset also 2 LSbits of duty cycle
			// PWM duty cycle (10-bit)
			temp = duty & 0b00000011;		// extract 2 LSbits of duty
			temp <<= 4;						// shift left 4 bits
			CCP2CON |= temp;				// put in CCP2CON 4:5  (DCBx1 and DCBx0)
			CCPR2L = duty >> 2;				// 8 MSbits of duty
			break;
		default:
			#ifdef DEBUG
				#error "Invalid Pin (must be CCP1=5 or CCP2=6)"
			#endif
	}

	// TMR2 configuration
	intUsed[INT_TMR2] = INT_USED;		// tell interrupt.c we use TMR2
	//PIR1bits.TMR2IF = 0;				// reset this flag for the next test
	T2CON = _t2con;						// Timer2 prescaler
	T2CONbits.TMR2ON = ON;				// enable Timer2
	// PWM pin as OUTPUT
	while (PIR1bits.TMR2IF == 0);		// Wait until TMR2 overflows
	pinmode(pin, OUTPUT);				// PWM pin as OUTPUT
}

/*----------------------------------------------------------------------------
PWM_set_percent_dutycycle
----------------------------------------------------------------------------
Set a percentage duty cycle, allowing max 100 PWM steps.
Allowed range: 0..100
The duty cycle will be set to the specified percentage of the maximum
for the current PWM frequency.
Note: The number of available PWM steps can be lower than 100 with
(very) high PWM frequencies.
--------------------------------------------------------------------------*/

void PWM_set_percent_dutycycle(u8 pin, u8 percent)
{
	u16 duty;
	if (percent == 0)
	{
		duty = 0;
	}
	else if (percent >= 100)
	{
		duty = _pr2_plus1 - 1;
	}
	else
	{
		duty = percent * (_pr2_plus1 / 4) / 25;	// (factor PR2/100)
	}
	PWM_set_dutycycle(pin, duty << 2);
}

#endif
