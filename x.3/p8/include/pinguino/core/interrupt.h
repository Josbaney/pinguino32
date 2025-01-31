/*	----------------------------------------------------------------------------
	FILE:			interrupt.h
	PROJECT:		pinguino
	PURPOSE:		interrupt routines
	PROGRAMER:		regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	08-06-2012
	LAST RELEASE:	11-06-2012
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

#ifndef __INTERRUPT_H
	#define __INTERRUPT_H

	#define INT_ENABLE			1
	#define INT_DISABLE			0
	#define INT_ENABLE_PRIORITY	1
	#define INT_DISABLE_PRIORITY 0
	#define INT_HIGH_PRIORITY	1
	#define INT_LOW_PRIORITY	0
	#define INT_RISING_EDGE		1			// Interrupt on rising edge
	#define INT_FALLING_EDGE	0			// Interrupt on falling edge
	#define INT_NOT_USED		0
	#define INT_USED			1
	#define INT_MICROSEC		1
	#define INT_MILLISEC		2
	#define INT_SEC				3

	/// Interrupts list

	#define INT_TMR0			0
	#define INT_TMR1			1
	#define INT_TMR2			2
	#define INT_TMR3			3
	#define INT_TMR4			4

	#define INT_INT0			5
	#define INT_INT1			6
	#define INT_INT2			7
	#define INT_RB				8

	#define INT_CCP1			9
	#define INT_CCP2			10
	#define INT_CM				11

	#define INT_RC				12
	#define INT_TX				13
	#define INT_AD				14
	#define INT_OSCF			15
	#define INT_EE				16
	#define INT_HLVD			17
	#define INT_BCL				18
	#define INT_USB				19
	#define INT_SSP				20

	#define INT_NUM				21

	///
	/// CCPxCON: STANDARD CCPx CONTROL REGISTER
	///

	// bit 3-0 CCP1M3:CCP1M0: Enhanced CCP Mode Select bits
	#define CCP_RESET			 0b0000 // Capture/Compare/PWM off (resets ECCP module)
	#define CCP_MODE_TOGGLE		 0b0010 // Compare mode, toggle output on match
	#define CCP_FALLING_EDGE	 0b0100 // Capture mode, every falling edge
	#define CCP_RISING_EDGE 	 0b0101 // Capture mode, every rising edge
	#define CCP_4TH_RISING_EDGE	 0b0110 // Capture mode, every 4th rising edge
	#define CCP_16TH_RISING_EDGE 0b0111 // Capture mode, every 16th rising edge
	#define CCP_INIT_PIN_LOW	 0b1000 // Compare mode, initialize CCP1 pin low, set output on compare match (set CCP1IF)
	#define CCP_INIT_PIN_HIGH	 0b1001 // Compare mode, initialize CCP1 pin high, clear output on compare match (set CCP1IF)
	#define CCP_INT_ON_CMP_MATCH 0b1010 // Compare mode, generate software interrupt only, CCP1 pin reverts to I/O state
	#define CCP_SPECIAL_EVENT	 0b1011 // Compare mode, trigger special event (CCP1 resets TMR1 or TMR3, sets CCP1IF bit)

	///
	/// T0CON: TIMER0 CONTROL REGISTER
	///

	// bit 7
	#define T0_ON				(1<<7)  // 1 = Enables Timer0
	#define T0_OFF				(0)     // 0 = Stops Timer0
	// bit 6   T08BIT: Timer0 8-Bit/16-Bit Control bit
	#define T0_8BIT				(1<<6)  // 1 = Timer0 is configured as an 8-bit timer/counter
	#define T0_16BIT			(0)     // 0 = Timer0 is configured as a 16-bit timer/counter
	// bit 5   T0CS: Timer0 Clock Source Select bit
	#define	T0_SOURCE_EXT		(1<<5)  // 1 = Transition on T0CKI pin
	#define	T0_SOURCE_INT		(0)     // 0 = Internal instruction cycle clock (CLKO)
	// bit 4   T0SE: Timer0 Source Edge Select bit
	#define	T0_H2L				(1<<4)  // 1 = Increment on high-to-low transition on T0CKI pin
	#define	T0_L2H				(0)     // 0 = Increment on low-to-high transition on T0CKI pin
	// bit 3   PSA: Timer0 Prescaler Assignment bit
	#define	T0_PS_OFF			(1<<3)  // 1 = TImer0 prescaler is NOT assigned. Timer0 clock input bypasses prescaler.
	#define	T0_PS_ON			(0)     // 0 = Timer0 prescaler is assigned. Timer0 clock input comes from prescaler output.
	// bit 2-0 T0PS2:T0PS0: Timer0 Prescaler Select bits
	#define	T0_PS_1_256			0b111 // 1:256 Prescale value
	#define	T0_PS_1_128			0b110 // 1:128 Prescale value
	#define	T0_PS_1_64			0b101 // 1:64 Prescale value
	#define	T0_PS_1_32			0b100 // 1:32 Prescale value
	#define	T0_PS_1_16			0b011 // 1:16 Prescale value
	#define	T0_PS_1_8			0b010 // 1:8 Prescale value
	#define	T0_PS_1_4			0b001 // 1:4 Prescale value
	#define	T0_PS_1_2			0b000 // 1:2 Prescale value

	///
	/// T1CON: TIMER1 CONTROL REGISTER
	///

	#if defined(PIC18F2550) || defined(PIC18F4550)

	// bit 7 RD16: 16-Bit Read/Write Mode Enable bit
	#define T1_16BIT			(1<<7)	// 16-bit mode
	#define T1_8BIT				(0) 	// 8-bit mode

	// bit 6 T1RUN: Timer1 System Clock Status bit
	#define T1_RUN_FROM_OSC		(1<<6)  // 1 = Device clock is derived from Timer1 oscillator
	#define T1_RUN_FROM_ANOTHER	(0)     // 0 = Device clock is derived from another source

	// bit 1 TMR1CS: Timer1 Clock Source Select bit
	#define T1_SOURCE_EXT		(1<<1)  // 1 = External clock from RC0/T13CKI
	#define T1_SOURCE_INT		(0)     // 0 = Internal clock source (FOSC/4)

    #endif

	#if defined(PIC18F26J50)

    // bit 7-6 TMR1CS<1:0>: Timer1 Clock Source Select bits
    #define T1_SOURCE_EXT       0b10000000  // Timer1 clock source is the T1OSC or T1CKI pin
    #define T1_RUN_FROM_OSC     0b01000000  // Timer1 clock source is the system clock (FOSC)(1)
    #define T1_SOURCE_INT       0b00000000  // Timer1 clock source is the instruction clock (FOSC/4)

	// bit 1 RD16: 16-Bit Read/Write Mode Enable bit
	#define T1_16BIT			(1<<1)  // 16-bit mode
	#define T1_8BIT				(0)     // 8-bit mode

    #endif

	// bit 5-4 T1CKPS1:T1CKPS0: Timer1 Input Clock Prescale Select bits
	#define T1_PS_1_1			0b00000000	// 1:1 prescale value
	#define T1_PS_1_2			0b00010000	// 1:2 prescale value
	#define T1_PS_1_4			0b00100000	// 1:4 prescale value
	#define T1_PS_1_8			0b00110000	// 1:8 prescale value
	// bit 3 T1OSCEN: Timer1 Oscillator Enable bit
	#define T1_OSC_OFF			(1<<3)  // Timer 1 oscilator is shut off
	#define T1_OSC_ON			(0)     // Timer 1 oscilator enable on
	// bit 2 T1SYNC: Timer1 External Clock Input Synchronization Select bit
	#define T1_SYNC_EXT_ON		(1<<2)  // Synchronize external clock input
	#define T1_SYNC_EXT_OFF		(0)     // Do not synchronize external clock input
	// bit 0 TMR1ON: Timer1 On bit
	#define T1_ON				(1<<0)  // 1 = Enables Timer1
	#define T1_OFF				(0)     // 0 = Stops Timer1

	///
	/// T2CON: TIMER2 CONTROL REGISTER
	///

	// bit 6-3 T2OUTPS3:T2OUTPS0: Timer2 Output Postscale Select bits
	#define T2_POST_1_1			(0<<3) // 1:1 Postscale
	#define T2_POST_1_2			(1<<3) // 1:2 Postscale
	#define T2_POST_1_3			(2<<3) // 1:3 Postscale
	#define T2_POST_1_4			(3<<3) // 1:4 Postscale
	#define T2_POST_1_5			(4<<3) // 1:5 Postscale
	#define T2_POST_1_6			(5<<3) // 1:6 Postscale
	#define T2_POST_1_7			(6<<3) // 1:7 Postscale
	#define T2_POST_1_8			(7<<3) // 1:8 Postscale
	#define T2_POST_1_9			(8<<3) // 1:9 Postscale
	#define T2_POST_1_10		(9<<3) // 1:10 Postscale
	#define T2_POST_1_11		(10<<3) // 1:11 Postscale
	#define T2_POST_1_12		(11<<3) // 1:12 Postscale
	#define T2_POST_1_13		(12<<3) // 1:13 Postscale
	#define T2_POST_1_14		(13<<3) // 1:14 Postscale
	#define T2_POST_1_15		(14<<3) // 1:15 Postscale
	#define T2_POST_1_16		(15<<3) // 1:16 Postscale
	//bit 2 TMR2ON: Timer2 On bit
	#define T2_ON				(1<<2)  // Timer2 is on
	#define T2_OFF				(0)     // Timer2 is off
	// bit 1-0 T2CKPS1:T2CKPS0: Timer2 Clock Prescale Select bits
	#define T2_PS_1_1			0b00 // Prescaler is 1
	#define T2_PS_1_4			0b01 // Prescaler is 4
	#define T2_PS_1_16			0b11 // Prescaler is 16

	///
	/// T3CON: TIMER3 CONTROL REGISTER
	///

	#if defined(PIC18F2550) || defined(PIC18F4550)

	// bit 7 RD16: 16-Bit Read/Write Mode Enable bit
	#define T3_16BIT			(1<<7)  // 1 = Enables register read/write of Timer3 in one 16-bit operation
	#define T3_8BIT				(0)     // 0 = Enables register read/write of Timer3 in two 8-bit operations
	// bit 6, 3 T3CCP2:T3CCP1: Timer3 and Timer1 to CCPx Enable bits
	#define T3_CPP1_CCP2		0b01001000 // 1x = Timer3 is the capture/compare clock source for both CCP modules
	#define T3_CCP2_T1_CCP1		0b00001000 // 01 = Timer3 is the capture/compare clock source for CCP2; Timer1 is the capture/compare clock source for CCP1
	#define T1_CCP1_CCP2		0b00000000 // 00 = Timer1 is the capture/compare clock source for both CCP modules
	// bit 5-4 T3CKPS1:T3CKPS0: Timer3 Input Clock Prescale Select bits
	#define T3_PS_1_8			(0b11<<4) // 1:8 Prescale value
	#define T3_PS_1_4			(0b10<<4) // 1:4 Prescale value
	#define T3_PS_1_2			(0b01<<4) // 1:2 Prescale value
	#define T3_PS_1_1			(0b00<<4) // 1:1 Prescale value
	// bit 2 T3SYNC: Timer3 External Clock Input Synchronization Control bit
	// When TMR3CS = 1:
	#define T3_NOT_SYNC			(1<<2)      // 1 = Do not synchronize external clock input
	#define T3_SYNC				(0)         // 0 = Synchronize external clock input
	// bit 1 TMR3CS: Timer3 Clock Source Select bit
	#define T3_SOURCE_EXT		(1<<1)      // 1 = External clock input from Timer1 oscillator or T13CKI (on the rising edge after the first falling edge)
	#define T3_SOURCE_INT		(0)         // 0 = Internal clock (FOSC/4)
	// bit 0 TMR3ON: Timer3 On bit
	#define T3_ON				(1<<0)      // 1 = Enables Timer3
	#define T3_OFF				(0)         // 0 = Stops Timer3

    #endif

	#if defined(PIC18F26J50)

    // bit 7-6 TMR3CS<1:0>: Timer1 Clock Source Select bits
    #define T3_SOURCE_EXT       (0b10<<6)   // Timer3 clock source is the T1OSC or T1CKI pin
    #define T3_RUN_FROM_OSC     (0b01<<6)   // Timer3 clock source is the system clock (FOSC)(1)
    #define T3_SOURCE_INT       (0b00<<6)   // Timer3 clock source is the instruction clock (FOSC/4)
	// bit 5-4 T3CKPS1:T3CKPS0: Timer3 Input Clock Prescale Select bits
	#define T3_PS_1_8			(0b11<<4)   // 1:8 Prescale value
	#define T3_PS_1_4			(0b10<<4)   // 1:4 Prescale value
	#define T3_PS_1_2			(0b01<<4)   // 1:2 Prescale value
	#define T3_PS_1_1			(0b00<<4)   // 1:1 Prescale value
    // bit 3 T3OSCEN: Timer3 Oscillator Source Select bit
    // When TMR3CS<1:0> = T3_SOURCE_EXT:
    #define T3_SOURCE_T1OSC     (1<<3)      // Power up the Timer1 crystal driver (T1OSC) and supply the Timer3 clock from the crystal output
    #define T3_SOURCE_T3OSC     (0)         // Timer1 crystal driver is off, Timer3 clock is from the T3CKI digital input pin assigned in PPS module(2)
    // When TMR3CS<1:0> = T3_RUN_FROM_OSC or T3_SOURCE_INT:
    //#define T3_SOURCE_T1OSC   (1<<3)      // Power up the Timer1 crystal driver (T1OSC)
    #define T3_SOURCE_T1OFF     (0)         // Timer1 crystal driver is off(2)
	// bit 2 T3SYNC: Timer3 External Clock Input Synchronization Control bit
	// When TMR3CS = T3_SOURCE_EXT:
	#define T3_NOT_SYNC			(1<<2)      // 1 = Do not synchronize external clock input
	#define T3_SYNC				(0)         // 0 = Synchronize external clock input
	// bit 1 RD16: 16-Bit Read/Write Mode Enable bit
	#define T3_16BIT			(1<<1)      // 16-bit mode
	#define T3_8BIT				(0)         // 8-bit mode
	// bit 0 TMR3ON: Timer3 On bit
	#define T3_ON				(1<<0)      // 1 = Enables Timer3
	#define T3_OFF				(0)         // 0 = Stops Timer3

    #endif

	#if defined(PIC18F26J50)

    // bit 6-3  T4OUTPS<3:0>: Timer4 Output Postscale Select bits
	#define T4_POST_1_1			(0<<3) // 1:1 Postscale
	#define T4_POST_1_2			(1<<3) // 1:2 Postscale
	#define T4_POST_1_3			(2<<3) // 1:3 Postscale
	#define T4_POST_1_4			(3<<3) // 1:4 Postscale
	#define T4_POST_1_5			(4<<3) // 1:5 Postscale
	#define T4_POST_1_6			(5<<3) // 1:6 Postscale
	#define T4_POST_1_7			(6<<3) // 1:7 Postscale
	#define T4_POST_1_8			(7<<3) // 1:8 Postscale
	#define T4_POST_1_9			(8<<3) // 1:9 Postscale
	#define T4_POST_1_10		(9<<3) // 1:10 Postscale
	#define T4_POST_1_11		(10<<3) // 1:11 Postscale
	#define T4_POST_1_12		(11<<3) // 1:12 Postscale
	#define T4_POST_1_13		(12<<3) // 1:13 Postscale
	#define T4_POST_1_14		(13<<3) // 1:14 Postscale
	#define T4_POST_1_15		(14<<3) // 1:15 Postscale
	#define T4_POST_1_16		(15<<3) // 1:16 Postscale
    // bit 2    TMR4ON: Timer4 On bit
	#define T4_ON				(1<<2)  // Timer4 is on
	#define T4_OFF				(0)     // Timer4 is off
    // bit 1-0  T4CKPS<1:0>: Timer4 Clock Prescale Select bits
	#define T4_PS_1_1			0b00 // Prescaler is 1
	#define T4_PS_1_4			0b01 // Prescaler is 4
	#define T4_PS_1_16			0b11 // Prescaler is 16

    #endif

#endif /* __INTERRUPT_H */
