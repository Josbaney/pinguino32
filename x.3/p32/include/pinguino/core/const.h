/*	----------------------------------------------------------------------------
 *	const.h
 *	Régis Blanchot
 *	UBW32 and Emperor board revised - Marcus Fazzi SET/2011
 *	--------------------------------------------------------------------------*/
// 17 mar. 2012 [hgmvanbeek@gmail.com] added support for PIC32_PINGUINO_MICRO

#ifndef __CONST_H
	#define __CONST_H

	#ifndef PI
		#define PI				3.1415926535897932384626433832795
	#endif

	#ifndef HALF_PI
		#define HALF_PI		1.5707963267948966192313216916398
	#endif

	#ifndef TWO_PI
		#define TWO_PI			6.283185307179586476925286766559
	#endif

	#ifndef DEG_TO_RAD
		#define DEG_TO_RAD	0.017453292519943295769236907684886
	#endif

	#ifndef RAD_TO_DEG
		#define RAD_TO_DEG	57.295779513082320876798154814105
	#endif

	#ifndef NULL
		#define NULL	0
	#endif

	#ifndef ON
		#define ON		1
	#endif

	#ifndef OFF
		#define OFF		0
	#endif

	#ifndef FALSE
		#define FALSE	0 
	#endif

	#ifndef TRUE
		#define TRUE	!FALSE
	#endif

	//lower case

	#ifndef false
		#define false	0
	#endif

	#ifndef true 
		#define true	!false
	#endif

	#ifndef False
		#define False	0
	#endif

	#ifndef True 
		#define True	!False
	#endif

	#ifndef INPUT
		#define INPUT	1
	#endif

	#ifndef OUTPUT
		#define OUTPUT	0
	#endif

	#ifndef HIGH
		#define HIGH	1
	#endif

	#ifndef LOW
		#define LOW		0
	#endif
	
	//Booleans

	#ifndef AND
		#define AND		&&
	#endif

	#ifndef OR 
		#define OR		||
	#endif

	//lower case (not compatible with c++)
	//#define and		&&
	//#define or		||	

	#ifndef BYTE
		#define BYTE	1
	#endif

	#ifndef BIN
		#define BIN		2
	#endif

	#ifndef OCT
		#define OCT		8 
	#endif

	#ifndef DEC
		#define DEC		10
	#endif

	#ifndef HEX
		#define HEX		16
	#endif

	#ifndef FLOAT
		#define FLOAT	32
	#endif

#if defined(UBW32_460) || defined(UBW32_795)
		// UBW32 build-in leds
		#define LED1			63 //PORTEbits.RE2	// white led
		#define LED2			59 //PORTEbits.RE1	// red led
		#define LED3			58 //PORTEbits.RE0	// yellow led
		#define LED4			64 //PORTEbits.RE3	// green led	

		#define WHITELED		63 //PORTEbits.RE2	// led1
		#define GREENLED		59 //PORTEbits.RE3	// led2	
		#define YELLOWLED		58 //PORTEbits.RE0	// led3
		#define REDLED			64 //PORTEbits.RE1	// led4

		// UBW32 build-in buttons
		#define PROGBUTTON	68 //PORTEbits.RE7 = prog button
		#define USERBUTTON	69 //PORTEbits.RE6 = user button
		 
	#elif defined(EMPEROR460) || defined(EMPEROR795)
		// EMPEROR build-in leds
		#define LED1			49 //PORTEbits.RE2	// blue led
		#define LED2			48 //PORTEbits.RE3	// red led

		#define BLUELED		49 //pin49 PORTEbits.RE2	// led1
		#define REDLED			48 //pin48 PORTEbits.RE3	// led2

		// UBW32 build-in buttons
		#define USERBUTTON	43 //PORTEbits.RE7 = user button

	#elif defined (PIC32_PINGUINO_MICRO)
		#define GREENLED		32	//PORTGbits.RG6	// led1
		#define YELLOWLED		10	//PORTDbits.RD1	// led2

	#elif defined(PIC32_PINGUINO) || defined(PIC32_PINGUINO_OTG)
		// Arduino's digital pins
		#define D0		0
		#define D1		1
		#define D2		2
		#define D3		3
		#define D4		4
		#define D5		5
		#define D6		6
		#define RTCC	6
		#define D7		7
		#define D8		8
		#define D9		9
		#define D10		10
		#define D11		11
		#define D12		12
		#define D13		13
		// Arduino's analogic pins
		#if defined(__ANALOG__)
			#define A0		0
			#define A1		1
			#define A2		2
			#define A3		3
			#define A4		4
			#define A5		5
			#define A6		6
			#define A7		7
		#else
			#define A0		14
			#define A1		15
			#define A2		16
			#define A3		17
			#define A4		18
			#define A5		19
			#define A6		20
			#define A7		21
		#endif
		// OLIMEX build-in leds
		#define LED1			13	//PORTGbits.RG6	// green led
		#define LED2			30	//PORTDbits.RD1	// yellow led

		#define GREENLED		13	//PORTGbits.RG6	// led1
		#define YELLOWLED		30	//PORTDbits.RD1	// led2

		// OLIMEX build-in buttons
		#define USERBUTTON		2	//PORTDbits.RD0 = user button

	#endif

#endif /* __CONST_H */
