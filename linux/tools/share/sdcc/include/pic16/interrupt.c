/*	----------------------------------------------------------------------------
	---------- interrupt.c
	----------------------------------------------------------------------------
	@author				(c)2010 - R. Blanchot <rblanchot@gmail.com>
	@version			0.4 (last update 24-12-2010)
	@IDE				Pinguino IDE >= 9.5
	--------------------------------------------------------------------------*/

#ifndef __INTERRUPT

	#define __INTERRUPT

	#ifndef USERINT
		#define USERINT
	#endif

	#include <pic18fregs.h>

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

	#define INT_INT0			4
	#define INT_INT1			5
	#define INT_INT2			6
	#define INT_RB				7

	#define INT_CCP1			8
	#define INT_CCP2			9
	#define INT_CM				10

	#define INT_RC				11
	#define INT_TX				12
	#define INT_AD				13
	#define INT_OSCF			14
	#define INT_EE				15
	#define INT_HLVD			16
	#define INT_BCL				17
	#define INT_USB				18
	#define INT_SSP				19

	#define INT_NUM				20

	///
	/// CCPxCON: STANDARD CCPx CONTROL REGISTER
	///

	// bit 3-0 CCP1M3:CCP1M0: Enhanced CCP Mode Select bits
	#define CCP_RESET			0b11110000 // Capture/Compare/PWM off (resets ECCP module)
	#define CCP_MODE_TOGGLE		0b11110010 // Compare mode, toggle output on match
	#define CCP_FALLING_EDGE	0b11110100 // Capture mode, every falling edge
	#define CCP_RISING_EDGE 	0b11110101 // Capture mode, every rising edge
	#define CCP_4TH_RISING_EDGE	0b11110110 // Capture mode, every 4th rising edge
	#define CCP_16TH_RISING_EDGE 0b11110111 // Capture mode, every 16th rising edge
	#define CCP_INIT_PIN_LOW	0b11111000 // Compare mode, initialize CCP1 pin low, set output on compare match (set CCP1IF)
	#define CCP_INIT_PIN_HIGH	0b11111001 // Compare mode, initialize CCP1 pin high, clear output on compare match (set CCP1IF)
	#define CCP_INT_ON_CMP_MATCH 0b11111010 // Compare mode, generate software interrupt only, CCP1 pin reverts to I/O state
	#define CCP_SPECIAL_EVENT	0b11111011 // Compare mode, trigger special event (CCP1 resets TMR1 or TMR3, sets CCP1IF bit)

	///
	/// T0CON: TIMER0 CONTROL REGISTER
	///

	// bit 7
	#define T0_ON				0b11111111 // 1 = Enables Timer0
	#define T0_OFF				0b01111111 // 0 = Stops Timer0
	// bit 6   T08BIT: Timer0 8-Bit/16-Bit Control bit
	#define T0_8BIT				0b11111111 // 1 = Timer0 is configured as an 8-bit timer/counter
	#define T0_16BIT			0b10111111 // 0 = Timer0 is configured as a 16-bit timer/counter
	// bit 5   T0CS: Timer0 Clock Source Select bit
	#define	T0_CKI				0b11111111 // 1 = Transition on T0CKI pin
	#define	T0_CLK				0b11011111 // 0 = Internal instruction cycle clock (CLKO)
	// bit 4   T0SE: Timer0 Source Edge Select bit
	#define	T0_H2L				0b11111111 // 1 = Increment on high-to-low transition on T0CKI pin
	#define	T0_L2H				0b11101111 // 0 = Increment on low-to-high transition on T0CKI pin
	// bit 3   PSA: Timer0 Prescaler Assignment bit
	#define	T0_PS_OFF			0b11111111 // 1 = TImer0 prescaler is NOT assigned. Timer0 clock input bypasses prescaler.
	#define	T0_PS_ON			0b11110111 // 0 = Timer0 prescaler is assigned. Timer0 clock input comes from prescaler output.
	// bit 2-0 T0PS2:T0PS0: Timer0 Prescaler Select bits
	#define	T0_PS_1_256			0b11111111 // 1:256 Prescale value
	#define	T0_PS_1_128			0b11111110 // 1:128 Prescale value
	#define	T0_PS_1_64			0b11111101 // 1:64 Prescale value
	#define	T0_PS_1_32			0b11111100 // 1:32 Prescale value
	#define	T0_PS_1_16			0b11111011 // 1:16 Prescale value
	#define	T0_PS_1_8			0b11111010 // 1:8 Prescale value
	#define	T0_PS_1_4			0b11111001 // 1:4 Prescale value
	#define	T0_PS_1_2			0b11111000 // 1:2 Prescale value

	///
	/// T1CON: TIMER1 CONTROL REGISTER
	///

	// bit 7 RD16: 16-Bit Read/Write Mode Enable bit
	#define T1_16BIT			0b11111111	// 16-bit mode
	#define T1_8BIT				0b01111111	// 8-bit mode
	// bit 6 T1RUN: Timer1 System Clock Status bit
	#define T1_RUN_FROM_OSC		0b11111111 // 1 = Device clock is derived from Timer1 oscillator
	#define T1_RUN_FROM_ANOTHER	0b10111111 // 0 = Device clock is derived from another source
	// bit 5-4 T1CKPS1:T1CKPS0: Timer1 Input Clock Prescale Select bits
	#define T1_PS_1_1			0b11001111	// 1:1 prescale value
	#define T1_PS_1_2			0b11011111	// 1:2 prescale value
	#define T1_PS_1_4			0b11101111	// 1:4 prescale value
	#define T1_PS_1_8			0b11111111	// 1:8 prescale value
	// bit 3 T1OSCEN: Timer1 Oscillator Enable bit
	#define T1_OSC_OFF			0b11110111	// Timer 1 oscilator is shut off
	#define T1_OSC_ON			0b11111111	// Timer 1 oscilator enable on
	// bit 2 T1SYNC: Timer1 External Clock Input Synchronization Select bit
	#define T1_SYNC_EXT_ON		0b11111011	// Synchronize external clock input
	#define T1_SYNC_EXT_OFF		0b11111111	// Do not synchronize external clock input
	// bit 1 TMR1CS: Timer1 Clock Source Select bit
	#define T1_SOURCE_EXT		0b11111111	// 1 = External clock from RC0/T13CKI
	#define T1_SOURCE_INT		0b11111101	// 0 = Internal clock source (FOSC/4)
	// bit 0 TMR1ON: Timer1 On bit
	#define T1_ON				0b11111111	// 1 = Enables Timer1
	#define T1_OFF				0b11111110	// 0 = Stops Timer1

	///
	/// T2CON: TIMER2 CONTROL REGISTER
	///

	// bit 6-3 T2OUTPS3:T2OUTPS0: Timer2 Output Postscale Select bits
	#define T2_POST_1_1			0b00001111 // 1:1 Postscale
	#define T2_POST_1_2			0b00011111 // 1:2 Postscale
	#define T2_POST_1_3			0b00101111 // 1:3 Postscale
	#define T2_POST_1_4			0b00111111 // 1:4 Postscale
	#define T2_POST_1_5			0b01001111 // 1:5 Postscale
	#define T2_POST_1_6			0b01011111 // 1:6 Postscale
	#define T2_POST_1_7			0b01101111 // 1:7 Postscale
	#define T2_POST_1_8			0b01111111 // 1:7 Postscale
	#define T2_POST_1_9			0b10001111 // 1:8 Postscale
	#define T2_POST_1_10		0b10011111 // 1:9 Postscale
	#define T2_POST_1_11		0b10101111 // 1:10 Postscale
	#define T2_POST_1_12		0b10111111 // 1:11 Postscale
	#define T2_POST_1_13		0b11001111 // 1:12 Postscale
	#define T2_POST_1_14		0b11011111 // 1:13 Postscale
	#define T2_POST_1_15		0b11101111 // 1:14 Postscale
	#define T2_POST_1_16		0b11111111 // 1:15 Postscale
	//bit 2 TMR2ON: Timer2 On bit
	#define T2_ON				0b11111111 // Timer2 is on
	#define T2_OFF				0b11111011 // Timer2 is off
	// bit 1-0 T2CKPS1:T2CKPS0: Timer2 Clock Prescale Select bits
	#define T2_PS_1_1			0b11111100 // Prescaler is 1
	#define T2_PS_1_4			0b11111101 // Prescaler is 4
	#define T2_PS_1_16			0b11111111 // Prescaler is 16

	///
	/// T3CON: TIMER3 CONTROL REGISTER
	///
	
	// bit 7 RD16: 16-Bit Read/Write Mode Enable bit
	#define T3_16BIT			0b11111111 // 1 = Enables register read/write of Timer3 in one 16-bit operation
	#define T3_8BIT				0b01111111 // 0 = Enables register read/write of Timer3 in two 8-bit operations
	// bit 6, 3 T3CCP2:T3CCP1: Timer3 and Timer1 to CCPx Enable bits
	#define T3_CPP1_CCP2		0b11111111 // 1x = Timer3 is the capture/compare clock source for both CCP modules
	#define T3_CCP2_T1_CCP1		0b10111111 // 01 = Timer3 is the capture/compare clock source for CCP2; Timer1 is the capture/compare clock source for CCP1
	#define T1_CCP1_CCP2		0b10110111 // 00 = Timer1 is the capture/compare clock source for both CCP modules
	// bit 5-4 T3CKPS1:T3CKPS0: Timer3 Input Clock Prescale Select bits
	#define T3_PS_1_8			0b11111111 // 1:8 Prescale value
	#define T3_PS_1_4			0b11101111 // 1:4 Prescale value
	#define T3_PS_1_2			0b11011111 // 1:2 Prescale value
	#define T3_PS_1_1			0b11001111 // 1:1 Prescale value
	// bit 2 T3SYNC: Timer3 External Clock Input Synchronization Control bit
	// When TMR3CS = 1:
	#define T3_NOT_SYNC			0b11111111 // 1 = Do not synchronize external clock input
	#define T3_SYNC				0b11111011 // 0 = Synchronize external clock input
	// bit 1 TMR3CS: Timer3 Clock Source Select bit
	#define T3_EXT_CLK			0b11111111 // 1 = External clock input from Timer1 oscillator or T13CKI (on the rising edge after the first falling edge)
	#define T3_INT_CLK			0b11111101 // 0 = Internal clock (FOSC/4)
	// bit 0 TMR3ON: Timer3 On bit
	#define T3_ON				0b11111111 // 1 = Enables Timer3
	#define T3_OFF				0b11111110 // 0 = Stops Timer3

	typedef void (*callback) (void);				// type of: void callback()

	static callback intFunction[INT_NUM];
	u8  intUsed[INT_NUM];
	volatile u16 intCount[4];
	volatile u16 intCountLimit[4];
	volatile u8 preloadH[4];
	volatile u8 preloadL[4];

/*	----------------------------------------------------------------------------
	---------- detachInterrupt
	----------------------------------------------------------------------------
	@author		Regis Blanchot <rblanchot@gmail.com>
	@descr		Disable the interrupt
	@param		inter:		interrupt number
	--------------------------------------------------------------------------*/

void detachInterrupt(u8 inter)
{
	intUsed[inter] = INT_NOT_USED;	// This interrupt is no longer used

	switch(inter)
	{
		case INT_INT0:
			INTCONbits.INT0IE = INT_DISABLE;
			break;
		case INT_INT1:
			INTCON3bits.INT1IE = INT_DISABLE;
			break;
		case INT_INT2:
			INTCON3bits.INT2IE = INT_DISABLE;
			break;
		case INT_TMR0:
			INTCONbits.TMR0IE = INT_DISABLE;
			break;
		case INT_TMR1:
			PIE1bits.TMR1IE = INT_DISABLE;
			break;
		case INT_TMR2:
			PIE1bits.TMR2IE = INT_DISABLE;
			break;
		case INT_TMR3:
			PIE2bits.TMR3IE = INT_DISABLE;
			break;
		case INT_RB:
			INTCONbits.RBIE = INT_DISABLE;
			break;
		case INT_USB:
			PIE2bits.USBIE = INT_DISABLE;
			break;
		case INT_AD:
			PIE1bits.ADIE = INT_DISABLE;
			break;
		case INT_RC:
			PIE1bits.RCIE = INT_DISABLE;
			break;
		case INT_TX:
			PIE1bits.TXIE = INT_DISABLE;
			break;
		case INT_CCP1:
			PIE1bits.CCP1IE = INT_DISABLE;
			break;
		case INT_CCP2:
			PIE2bits.CCP2IE = INT_DISABLE;
			break;
		case INT_OSCF:
			PIE2bits.OSCFIE = INT_DISABLE;
			break;
		case INT_CM:
			PIE2bits.CMIE = INT_DISABLE;
			break;
		case INT_EE:
			PIE2bits.EEIE = INT_DISABLE;
			break;
		case INT_BCL:
			PIE2bits.BCLIE = INT_DISABLE;
			break;
		case INT_HLVD:
			PIE2bits.HLVDIE = INT_DISABLE;
			break;
		#ifdef PIC18F4550
		case INT_SSP:
			PIE1bits.SSPIE = INT_DISABLE;
			break;
		#endif
	}
}

/*	----------------------------------------------------------------------------
	---------- int_init
	----------------------------------------------------------------------------
	@author		Régis Blanchot <rblanchot@gmail.com>
	@descr		Disable all the interrupt
	--------------------------------------------------------------------------*/

void int_init()
{
	u8 i;
	
	RCONbits.IPEN = 1;					// Enable HP/LP interrupts
	INTCONbits.GIEH = 1;				// Enable HP interrupts
	INTCONbits.GIEL = 1;				// Enable LP interrupts

	for (i = 0; i < INT_NUM; i++)		// Disable all interrupts
		detachInterrupt(i);
}

/*	----------------------------------------------------------------------------
	---------- int_start
	----------------------------------------------------------------------------
	@author		Régis Blanchot <rblanchot@gmail.com>
	@descr		Start all timers together
	--------------------------------------------------------------------------*/

void int_start()
{
	#ifdef TMR0INT
		T0CONbits.TMR0ON = ON;
	#endif

	#ifdef TMR1INT
		T1CONbits.TMR1ON = ON;
	#endif

	#ifdef TMR2INT
		T2CONbits.TMR2ON = ON;
	#endif

	#ifdef TMR3INT
		T3CONbits.TMR3ON = ON;
	#endif
}

/*	----------------------------------------------------------------------------
	---------- int_stop
	----------------------------------------------------------------------------
	@author		Régis Blanchot <rblanchot@gmail.com>
	@descr		Stop all timers together
	--------------------------------------------------------------------------*/

void int_stop()
{
	#ifdef TMR0INT
		T0CONbits.TMR0ON = OFF;
	#endif

	#ifdef TMR1INT
		T1CONbits.TMR1ON = OFF;
	#endif

	#ifdef TMR2INT
		T2CONbits.TMR2ON = OFF;
	#endif

	#ifdef TMR3INT
		T3CONbits.TMR3ON = OFF;
	#endif
}

/*	----------------------------------------------------------------------------
	---------- OnTimerX
	----------------------------------------------------------------------------
	@author		Regis Blanchot <rblanchot@gmail.com>
	@descr		Configure timers to execute function func every delay ms, us or sec
	@param		timediv:	INT_MICROSEC, INT_MILLISEC, INT_SEC
				func:		function called when interrupt occures
				delay:		delay before overload (us)
	--------------------------------------------------------------------------*/

#ifdef TMR0INT
void OnTimer0(callback func, u8 timediv, u16 delay)
{
	u8 _t0con = 0;

	if (intUsed[INT_TMR0] == INT_NOT_USED)
	{
		intUsed[INT_TMR0] = INT_USED;
		intCount[INT_TMR0] = 0;
		intCountLimit[INT_TMR0] = delay;
		intFunction[INT_TMR0] = func;

		switch(timediv)
		{
			case INT_MICROSEC:
				// 1 us = 1.000 ns = 12 cy
				preloadH[INT_TMR0] = high8(0xFFFF - 12);
				preloadL[INT_TMR0] =  low8(0xFFFF - 12);
				_t0con = T0_OFF & T0_16BIT & T0_CLK & T0_PS_OFF;
				break;
			case INT_MILLISEC:
				// 1 ms = 1.000.000 ns = 12.000 cy
				// 12.000 / 8 = 1.500
				preloadH[INT_TMR0] = high8(0xFFFF - 1500);
				preloadL[INT_TMR0] =  low8(0xFFFF - 1500);
				_t0con = T0_OFF & T0_16BIT & T0_CLK & T0_PS_ON & T0_PS_1_8;
				break;
			case INT_SEC:
				// 1 sec = 1.000.000.000 ns = 12.000.000 cy
				// 12.000.000 / 256 = 46875
				preloadH[INT_TMR0] = high8(0xFFFF - 46875);
				preloadL[INT_TMR0] =  low8(0xFFFF - 46875);
				_t0con = T0_OFF & T0_16BIT & T0_CLK & T0_PS_ON & T0_PS_1_256;
				break;
		}

		INTCON2bits.TMR0IP = INT_LOW_PRIORITY;
		INTCONbits.TMR0IE = INT_ENABLE;
		INTCONbits.TMR0IF = 0;
		TMR0H = preloadH[INT_TMR0];
		TMR0L = preloadL[INT_TMR0];
		T0CON = _t0con;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt TIMER0 is already used !");
	}
	#endif
}
#endif

#ifdef TMR1INT
void OnTimer1(callback func, u8 timediv, u16 delay)
{
	u8 _t1con = 0;

	if (intUsed[INT_TMR1] == INT_NOT_USED)
	{
		intUsed[INT_TMR1] = INT_USED;
		intCount[INT_TMR1] = 0;
		intCountLimit[INT_TMR1] = delay;
		intFunction[INT_TMR1] = func;

		switch(timediv)
		{
			case INT_MICROSEC:
				// 1us = 1.000 ns = 12 cy
				preloadH[INT_TMR1] = high8(0xFFFF - 12);
				preloadL[INT_TMR1] =  low8(0xFFFF - 12);
				_t1con = T1_OFF & T1_16BIT & T1_PS_1_1 & T1_RUN_FROM_ANOTHER & T1_OSC_OFF & T1_SYNC_EXT_OFF & T1_SOURCE_INT;
				break;
			case INT_MILLISEC:
				// 1ms = 1.000.000ns = 12.000 cy
				// 12.000 / 8 = 1.500
				preloadH[INT_TMR1] = high8(0xFFFF - 1500);
				preloadL[INT_TMR1] =  low8(0xFFFF - 1500);
				_t1con = T1_OFF & T1_16BIT & T1_PS_1_8 & T1_RUN_FROM_ANOTHER & T1_OSC_OFF & T1_SYNC_EXT_OFF & T1_SOURCE_INT;
				break;
			case INT_SEC:
				// 1 sec = 1.000.000.000 ns = 12.000.000 cy
				// 12.000.000 / 8 = 1.500.000
				// 1.500.000 / 25 = 60000
				preloadH[INT_TMR1] = high8(0xFFFF - 60000); // 62500
				preloadL[INT_TMR1] =  low8(0xFFFF - 60000);
				intCountLimit[INT_TMR1] = delay * 25;
				_t1con = T1_OFF & T1_16BIT & T1_PS_1_8 & T1_RUN_FROM_ANOTHER & T1_OSC_OFF & T1_SYNC_EXT_OFF & T1_SOURCE_INT;
				break;
		}

		IPR1bits.TMR1IP = INT_LOW_PRIORITY;
		PIE1bits.TMR1IE = INT_ENABLE;
		PIR1bits.TMR1IF = 0;
		TMR1H = preloadH[INT_TMR1];
		TMR1L = preloadL[INT_TMR1];
		T1CON = _t1con;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt TIMER1 is already used !");
	}
	#endif
}
#endif

#ifdef TMR2INT
void OnTimer2(callback func, u8 timediv, u16 delay)
{
	u8 _t2con = 0;
	u8 _pr2 = 0;

	if (intUsed[INT_TMR2] == INT_NOT_USED)
	{
		intUsed[INT_TMR2] = INT_USED;
		intCount[INT_TMR2] = 0;
		intCountLimit[INT_TMR2] = delay;
		intFunction[INT_TMR2] = func;

		// time = Tcy*postscaler*pr2*prescaler
		switch(timediv)
		{
			case INT_MICROSEC:
				// 1us = 12 cy
				_pr2 = 12;
				_t2con = T2_OFF & T2_PS_1_1 & T2_POST_1_1;
				break;
			case INT_MILLISEC:
				// 1ms = 12.000 cy
				// 12.000 / 15 / 16 = 50
				_pr2 = 50;
				_t2con = T2_OFF & T2_POST_1_15 & T2_PS_1_16;
				break;
			case INT_SEC:
				// 1sec = 12.000.000 cy
				// 12.000.000 / 15 / 16 = 50.000 = 200 * 25
				_pr2 = 250;
				intCountLimit[INT_TMR2] = delay * 200;
				_t2con = T2_OFF & T2_POST_1_15 & T2_PS_1_16;
				break;
		}

		IPR1bits.TMR2IP = INT_LOW_PRIORITY;
		PIE1bits.TMR2IE = INT_ENABLE;
		PIR1bits.TMR2IF = 0;
		PR2 = _pr2;	// Timer2 Match value
		T2CON = _t2con;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt TIMER2 is already used !");
	}
	#endif
}
#endif

#ifdef TMR3INT
void OnTimer3(callback func, u8 timediv, u16 delay)
{
	u8 _t3con = 0;

	if (intUsed[INT_TMR3] == INT_NOT_USED)
	{
		intUsed[INT_TMR3] = INT_USED;
		intCount[INT_TMR3] = 0;
		intCountLimit[INT_TMR3] = delay;
		intFunction[INT_TMR3] = func;

		switch(timediv)
		{
			case INT_MICROSEC:
				// 1us = 1.000 ns = 12 cy
				preloadH[INT_TMR3] = high8(0xFFFF - 12);
				preloadL[INT_TMR3] =  low8(0xFFFF - 12);
				_t3con = T3_OFF & T3_16BIT & T3_PS_1_1 & T3_INT_CLK;
				break;
			case INT_MILLISEC:
				// 1 ms = 1.000.000 ns = 12.000 cy
				// 12.000 / 8 = 1.500
				preloadH[INT_TMR3] = high8(0xFFFF - 1500);
				preloadL[INT_TMR3] =  low8(0xFFFF - 1500);
				_t3con = T3_OFF & T3_16BIT & T3_PS_1_8 & T3_INT_CLK;
				break;
			case INT_SEC:
				// 1 sec = 1.000.000.000 ns = 12.000.000 cy
				// 12.000.000 / 8 = 1.500.000
				// 1.500.000 / 25 = 60000
				preloadH[INT_TMR3] = high8(0xFFFF - 60000);
				preloadL[INT_TMR3] =  low8(0xFFFF - 60000);
				intCountLimit[INT_TMR3] = delay * 25;
				_t3con = T3_OFF & T3_16BIT & T3_PS_1_8 & T3_INT_CLK;
				break;
		}

		IPR2bits.TMR3IP = INT_LOW_PRIORITY;
		PIE2bits.TMR3IE = INT_ENABLE;
		PIR2bits.TMR3IF = 0;
		TMR3H = preloadH[INT_TMR3];
		TMR3L = preloadL[INT_TMR3];
		T3CON = _t3con;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt TIMER3 is already used !");
	}
	#endif
}
#endif

/*	----------------------------------------------------------------------------
	---------- OnCounter
	----------------------------------------------------------------------------
	@author		Regis Blanchot <rblanchot@gmail.com>
	@descr		Configure counters
	@param		inter:		interrupt number (INT_TMR0, INT_TMR1, or INT_TMR3)
				func:		function called when interrupt comes
	--------------------------------------------------------------------------*/

#ifdef CNTR0INT
// Not available on Pinguino with 2 buttons (RA4 = Run Led)
void OnCounter0(callback func, u8 config)
{
	if (intUsed[INT_TMR0] == INT_NOT_USED)
	{
		intUsed[INT_TMR0] = INT_USED;
		intFunction[INT_TMR0] = func;
		intCount[INT_TMR0] = 0;
		intCountLimit[INT_TMR0] = 0;
		INTCON2bits.TMR0IP = INT_LOW_PRIORITY;
		INTCONbits.TMR0IE = INT_ENABLE;
		preloadH[INT_TMR0] = 0;
		preloadL[INT_TMR0] = 0;
		TMR0H = 0;
		TMR0L = 0;
		T0CON = T0_ON & T0_16BIT & T0_CKI & T0_L2H & T0_PS_ON & T0_PS_1_2;
		T0CON |= config;
		INTCONbits.TMR0IF = 0;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt TMR0 is already used !");
	}
	#endif
}
#endif

#ifdef CNTR1INT
void OnCounter1(callback func, u8 config)
{
	if (intUsed[INT_TMR1] == INT_NOT_USED)
	{
		intUsed[INT_TMR1] = INT_USED;
		intFunction[INT_TMR1] = func;
		intCount[INT_TMR1] = 0;
		intCountLimit[INT_TMR1] = 0;
		IPR1bits.TMR1IP = INT_LOW_PRIORITY;
		PIE1bits.TMR1IE = INT_ENABLE;
		preloadH[INT_TMR1] = 0;
		preloadL[INT_TMR1] = 0;
		TMR1H = 0;
		TMR1L = 0;
		T1CON = T1_ON & T1_16BIT & T1_PS_1_8 & T1_RUN_FROM_ANOTHER & T1_OSC_OFF & T1_SYNC_EXT_ON & T1_SOURCE_EXT;
		T1CON |= config;
		PIR1bits.TMR1IF = 0;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt TMR1 is already used !");
	}
	#endif
}
#endif

#ifdef CNTR3INT
void OnCounter3(callback func, u8 config)
{
	if (intUsed[INT_TMR3] == INT_NOT_USED)
	{
		intUsed[INT_TMR3] = INT_USED;
		intFunction[INT_TMR3] = func;
		intCount[INT_TMR3] = 0;
		intCountLimit[INT_TMR3] = 0;
		IPR2bits.TMR3IP = INT_LOW_PRIORITY;
		PIE2bits.TMR3IE = INT_ENABLE;
		preloadH[INT_TMR3] = 0;
		preloadL[INT_TMR3] = 0;
		TMR3H = 0;
		TMR3L = 0;
		T3CON = T3_ON & T3_16BIT & T3_PS_1_8 & T3_EXT_CLK; // default
		T3CON |= config;
		PIR2bits.TMR3IF = 0;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt TMR3 is already used !");
	}
	#endif
}
#endif

/*	----------------------------------------------------------------------------
	---------- OnChange
	----------------------------------------------------------------------------
	@author		Regis Blanchot <rblanchot@gmail.com>
	@descr		Configure interrupt-on-change
	@param		inter:		interrupt number
				config:		INT_RISING_EDGE or INT_FALLING_EDGE
				func:		function called when interrupt comes
	--------------------------------------------------------------------------*/

#ifdef INT0INT
void OnChangePin0(callback func, u8 config)
{
	if (intUsed[INT_INT0] == INT_NOT_USED)
	{
		intUsed[INT_INT0] = INT_USED;
		intFunction[INT_INT0] = func;
		INTCON2bits.INTEDG0 = config;
		INTCON2bits.RBPU = 0;						// PORTB pull-ups are enabled
		TRISBbits.TRISB0 = INPUT;
		//INTCON3bits.INT0IP = INT_LOW_PRIORITY;
		INTCONbits.INT0IE = INT_ENABLE;
		INTCONbits.INT0IF = 0;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt INT0 is already used !");
	}
	#endif
}
#endif

#ifdef INT1INT
void OnChangePin1(callback func, u8 config)
{
	if (intUsed[INT_INT1] == INT_NOT_USED)
	{
		intUsed[INT_INT1] = INT_USED;
		intFunction[INT_INT1] = func;
		INTCON2bits.INTEDG1 = config;
		INTCON2bits.RBPU = 0;						// PORTB pull-ups are enabled
		TRISBbits.TRISB1 = INPUT;
		INTCON3bits.INT1IP = INT_LOW_PRIORITY;
		INTCON3bits.INT1IE = INT_ENABLE;
		INTCON3bits.INT1IF = 0;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt INT1 is already used !");
	}
	#endif
}
#endif

#ifdef INT2INT
void OnChangePin2(callback func, u8 config)
{
	if (intUsed[INT_INT2] == INT_NOT_USED)
	{
		intUsed[INT_INT2] = INT_USED;
		intFunction[INT_INT2] = func;
		INTCON2bits.INTEDG2 = config;
		INTCON2bits.RBPU = 0;						// PORTB pull-ups are enabled
		TRISBbits.TRISB2 = INPUT;
		INTCON3bits.INT2IP = INT_LOW_PRIORITY;
		INTCON3bits.INT2IE = INT_ENABLE;
		INTCON3bits.INT2IF = 0;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt INT2 is already used !");
	}
	#endif
}
#endif

#ifdef RBINT

/*
PORTB<7:4> Interrupt-on-Change
Only pins configured as inputs can
cause this interrupt to occur. Any RB7:RB4 pin
configured as an output is excluded from the interrupt-
on-change comparison. The pins are compared with
the old value latched on the last read of PORTB.
*/

void OnChangePin4to7(callback func, u8 pin)
{
	if (intUsed[INT_RB] == INT_NOT_USED)
	{
		intUsed[INT_RB] = INT_USED;
		intFunction[INT_RB] = func;
		INTCON2bits.INTEDG2 = config;
		TRISB |= (1 << pin);	// pin as an INPUT
		INTCON2bits.RBIP = INT_LOW_PRIORITY;
		INTCONbits.RBIE = INT_ENABLE;
		INTCONbits.RBIF = 0;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt RB is already used !");
	}
	#endif
}
#endif

/*	----------------------------------------------------------------------------
	---------- OnCompare
	----------------------------------------------------------------------------
	@author		Regis Blanchot <rblanchot@gmail.com>
	@descr		Configure compare interrupt mode
	@param		inter:		interrupt number
				func:		function called when interrupt occured
	--------------------------------------------------------------------------*/

#ifdef CCP1INT
void OnCompare1(callback func, u8 config)
{
	if (intUsed[INT_CCP1] == INT_NOT_USED)
	{
		intUsed[INT_CCP1] = INT_USED;
		intFunction[INT_CCP1] = func;
		IPR1bits.CCP1IP = INT_LOW_PRIORITY;
		PIE1bits.CCP1IE = INT_ENABLE;
		CCP1CON &= config;
		PIR1bits.CCP1IF = 0;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt CCP1 is already used !");
	}
	#endif
}
#endif

#ifdef CCP2INT
void OnCompare2(callback func, u8 config)
{
	if (intUsed[INT_CCP2] == INT_NOT_USED)
	{
		intUsed[INT_CCP2] = INT_USED;
		intFunction[INT_CCP2] = func;
		IPR2bits.CCP2IP = INT_LOW_PRIORITY;
		PIE2bits.CCP2IE = INT_ENABLE;
		CCP2CON &= config;
		PIR2bits.CCP2IF = 0;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt CCP2 is already used !");
	}
	#endif
}
#endif

#ifdef CMINT
void OnCompareAll(callback func, u8 config)
{
	if (intUsed[INT_CM] == INT_NOT_USED)
	{
		intUsed[INT_CM] = INT_USED;
		intFunction[INT_CM] = func;
		IPR2bits.CMIP = INT_LOW_PRIORITY;
		PIE2bits.CMIE = INT_ENABLE;
		PIR2bits.CMIF = 0;
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt CM is already used !");
	}
	#endif
}
#endif

/*	----------------------------------------------------------------------------
	---------- OnEvent
	----------------------------------------------------------------------------
	@author		Regis Blanchot <rblanchot@gmail.com>
	@descr		Configure interrupt event
	@param		inter:		interrupt number
				func:		function called when interrupt occured
	--------------------------------------------------------------------------*/

#ifdef RCINT || TXINT || ADINT || OSCFINT || EEINT || HLVDINT || BCLINT || USBINT || SSPINT
void OnEvent(u8 inter, callback func)
{
	if (intUsed[inter] == INT_NOT_USED)
	{
		intUsed[inter] = INT_USED;
		intFunction[inter] = func;

		switch(inter)
		{
			case INT_RC:					// serial rx
				PIR1bits.RCIF = 0;
				break;
			case INT_TX:					// serial tx
				PIR1bits.TXIF = 0;
				break;
			case INT_AD:					// ad conversion complete
				PIR1bits.ADIF = 0;
				break;
			case INT_OSCF:					// oscillator failed
				PIR2bits.OSCFIF = 0;
				break;
			case INT_EE:					// eeprom write operation
				PIR2bits.EEIF = 0;
				break;
			case INT_HLVD:					// high/low voltage detect
				PIR2bits.HLVDIF = 0;
				break;
			case INT_BCL:					// bus collision
				PIR2bits.BCLIF = 0;
				break;
			case INT_USB:					// usb 
				PIR2bits.USBIF = 0;
				break;
			case INT_SSP:				
				PIR1bits.SSPIF = 0;
				break;
		}
	}
	#ifdef DEBUG
	else
	{
		serial_printf("Error : interrupt #%u is already used !", inter);
	}
	#endif
}
#endif

#ifdef RCINT
void OnSerialRX(callback func)	{	OnEvent(INT_RC, func);	}
#endif

#ifdef TXINT
void OnSerialTX(callback func)	{	OnEvent(INT_TX, func);	}
#endif

#ifdef ADINT
void OnADC(callback func)		{	OnEvent(INT_AD, func);	}
#endif

#ifdef OSCFINT
void OnOscFailed(callback func)	{	OnEvent(INT_OSCF, func);}
#endif

#ifdef EEINT
void OnEeprom(callback func)	{	OnEvent(INT_EE, func);	}
#endif

#ifdef HLVDINT
void OnLowVoltage(callback func){	OnEvent(INT_HLVD, func);}
#endif

#ifdef BCLINT
void OnBusCol(callback func)	{	OnEvent(INT_BCL, func);	}
#endif

#ifdef USBINT
void OnUSB(callback func)		{	OnEvent(INT_USB, func);	}
#endif

#ifdef SSPINT
void OnParallel(callback func)	{	OnEvent(INT_SSP, func);	}
void OnI2CRequest(callback func)	{	OnEvent(INT_SSP, func);	}
void OnI2CReceive(callback func)	{	OnEvent(INT_SSP, func);	}
#endif

/*	----------------------------------------------------------------------------
	---------- userhighinterrupt
	----------------------------------------------------------------------------
	@author		Regis Blanchot <rblanchot@gmail.com>
	@descr		function called by high_priority_isr
	@param		none
	--------------------------------------------------------------------------*/

void userhighinterrupt()
{
	#ifdef INT0INT
	if (INTCONbits.INT0IE && INTCONbits.INT0IF)
	{
		intFunction[INT_INT0]();
		INTCONbits.INT0IF = 0;
	}
	#endif
}

/*	----------------------------------------------------------------------------
	---------- userinterrupt
	----------------------------------------------------------------------------
	@author		Regis Blanchot <rblanchot@gmail.com>
	@descr		function called by low_priority_isr
	@param		none
	--------------------------------------------------------------------------*/

void userinterrupt()
{
	#ifdef INT1INT
	if (INTCON3bits.INT1IE && INTCON3bits.INT1IF)
	{
		INTCON3bits.INT1IF = 0;
		intFunction[INT_INT1]();
	}
	#endif
	#ifdef INT2INT
	if (INTCON3bits.INT2IE && INTCON3bits.INT2IF)
	{
		INTCON3bits.INT2IF = 0;
		intFunction[INT_INT2]();
	}
	#endif
	#ifdef RBINT
	if (INTCONbits.RBIE && INTCONbits.RBIF)
	{
		INTCONbits.RBIF = 0;
		intFunction[INT_RB]();
	}
	#endif
	#ifdef TMR0INT || CNTR0INT
	if (INTCONbits.TMR0IE && INTCONbits.TMR0IF)
	{
		T0CONbits.TMR0ON = OFF;
		TMR0H = preloadH[INT_TMR0];
		TMR0L = preloadL[INT_TMR0];
		INTCONbits.TMR0IF = 0;
		if (intCount[INT_TMR0]++ >= intCountLimit[INT_TMR0])
		{
			intCount[INT_TMR0] = 0;
			intFunction[INT_TMR0]();
		}
	}
	#endif
	#ifdef TMR1INT || CNTR1INT
	if (PIE1bits.TMR1IE && PIR1bits.TMR1IF)
	{
		T1CONbits.TMR1ON = OFF;
		TMR1H = preloadH[INT_TMR1];
		TMR1L = preloadL[INT_TMR1];
		PIR1bits.TMR1IF = 0;
		if (intCount[INT_TMR1]++ >= intCountLimit[INT_TMR1])
		{
			intCount[INT_TMR1] = 0;
			intFunction[INT_TMR1]();
		}
	}
	#endif
	#ifdef TMR2INT
	if (PIE1bits.TMR2IE && PIR1bits.TMR2IF)
	{
		T2CONbits.TMR2ON = OFF;
		PIR1bits.TMR2IF = 0;
		if (intCount[INT_TMR2]++ >= intCountLimit[INT_TMR2])
		{
			intCount[INT_TMR2] = 0;
			intFunction[INT_TMR2]();
		}
		// NB : no need to reload PR2
	}
	#endif
	#ifdef TMR3INT || CNTR3INT
	if (PIE2bits.TMR3IE && PIR2bits.TMR3IF)
	{
		T3CONbits.TMR3ON = OFF;
		TMR3H = preloadH[INT_TMR3];
		TMR3L = preloadL[INT_TMR3];
		PIR2bits.TMR3IF = 0;
		if (intCount[INT_TMR3]++ >= intCountLimit[INT_TMR3])
		{
			intCount[INT_TMR3] = 0;
			intFunction[INT_TMR3]();
		}
	}
	#endif
	#ifdef ADINT
	if (PIE1bits.ADIE && PIR1bits.ADIF)
	{
		PIR1bits.ADIF = 0;
		intFunction[INT_AD]();
	}
	#endif
	#ifdef RCINT
	if (PIE1bits.RCIE && PIR1bits.RCIF)
	{
		PIR1bits.RCIF = 0;
		intFunction[INT_RC]();
	}
	#endif
	#ifdef TXINT
	if (PIE1bits.TXIE && PIR1bits.TXIF)
	{
		PIR1bits.TXIF = 0;
		intFunction[INT_TX]();
	}
	#endif
	#ifdef CCP1INT
	if (PIE1bits.CCP1IE && PIR1bits.CCP1IF)
	{
		PIR1bits.CCP1IF = 0;
		intFunction[INT_CCP1]();
	}
	#endif
	#ifdef CCP2INT
	if (PIE2bits.CCP2IE && PIR2bits.CCP2IF)
	{
		PIR2bits.CCP2IF = 0;
		intFunction[INT_CCP2]();
	}
	#endif
	#ifdef EEINT
	if (PIE2bits.EEIE && PIR2bits.EEIF)
	{
		PIR2bits.EEIF = 0;
		intFunction[INT_EE]();
	}
	#endif
	#ifdef USBINT
	if (PIE2bits.USBIE && PIR2bits.USBIF)
	{
		PIR2bits.USBIF = 0;
		intFunction[INT_USB]();
	}
	#endif
	#ifdef OSCFINT
	if (PIE2bits.OSCFIE && PIR2bits.OSCFIF)
	{
		PIR2bits.OSCFIF = 0;
		intFunction[INT_OSCF]();
	}
	#endif
	#ifdef CMINT
	if (PIE2bits.CMIE && PIR2bits.CMIF)
	{
		PIR2bits.CMIF = 0;
		intFunction[INT_CM]();
	}
	#endif
	#ifdef BCLINT
	if (PIE2bits.BCLIE && PIR2bits.BCLIF)
	{
		PIR2bits.BCLIF = 0;
		intFunction[INT_BCL]();
	}
	#endif
	#ifdef HLVDINT
	if (PIE2bits.HLVDIE && PIR2bits.HLVDIF)
	{
		PIR2bits.HLVDIF = 0;
		intFunction[INT_HLVD]();
	}
	#endif

	#ifdef SSPINT
	if (PIE1bits.SSPIE && PIR1bits.SSPIF)
	{
		PIR1bits.SSPIF = 0;
		intFunction[INT_SSP]();
	}
	#endif

	int_start();
}

#endif
