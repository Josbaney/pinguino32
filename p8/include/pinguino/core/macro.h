/*	----------------------------------------------------------------------------
	---------- macro.h
	---------- rblanchot@gmail.com
	---------- Part of Pinguino - http://www.pinguino.cc/
	--------------------------------------------------------------------------**/

#ifndef __MACRO_H
	#define __MACRO_H

	//#include <const.h>

	/// ASM

	#define nop()					{_asm nop _endasm;}
	#define clrwdt()				{_asm clrwdt _endasm;}
	#define reset()				{_asm reset _endasm;}
	#define sleep()				{OSCCONbits.IDLEN = 0;\
										_asm sleep _endasm;}

	#define interrupts()			INTCONbits.GIE  = 1;
	#define noInterrupts()		INTCONbits.GIE  = 0;

	/// C

	#define NoEndLoop		while(1)

	/// BYTES

	#define highByte(x)			((unsigned char) ((x) >> 8))
	#define high8(x)				((unsigned char) ((x) >> 8))
	#define lowByte(x)			((unsigned char) ((x) & 0xFF))
	#define low8(x)				((unsigned char) ((x) & 0xFF))
	#define make16(low,high)	(low | (high << 8))

	/// MATH

	#define min(a,b)				((a)<(b)?(a):(b))
	#define max(a,b)				((a)>(b)?(a):(b))
	#define abs(x)					((x)>0?(x):-(x))
	#define constrain(amt,low,high) ((amt)<(low)?(low):((amt)>(high)?(high):(amt)))
	#define round(x)				((x)>=0?(long)((x)+0.5):(long)((x)-0.5))
	#define radians(deg)			((deg)*DEG_TO_RAD)
	#define degrees(rad)			((rad)*RAD_TO_DEG)
	#define sq(x)					((x)*(x))

	/// CLOCK

	//#define clockCyclesPerMicrosecond() ( F_CPU / 1000000L )
	//#define clockCyclesToMicroseconds(a) ( (a) / clockCyclesPerMicrosecond() )
	//#define microsecondsToClockCycles(a) ( (a) * clockCyclesPerMicrosecond() )

	/// BITWISE OPERATION

	#define BIN_BIT(value, bit, dec) \
		(((((unsigned long)(value##.0))/dec)&1 == 1)? (1<<bit) : 0)

	#define Bin(value) \
	(	BIN_BIT(value,  0, 1) | \
		BIN_BIT(value,  1, 10) | \
		BIN_BIT(value,  2, 100) | \
		BIN_BIT(value,  3, 1000) | \
		BIN_BIT(value,  4, 10000) | \
		BIN_BIT(value,  5, 100000) | \
		BIN_BIT(value,  6, 1000000) | \
		BIN_BIT(value,  7, 10000000))

	// Read bit #n from octet
	#define BitRead(octet, n) \
		(octet = octet >> n & 1)

	// Set bit #n from octet
	#define BitSet(octet, n) \
		(octet |= (1 << n))

	// Clear (0) bit #n from octet
	#define BitClear(octet, n) \
		(octet &= !(1 << n))

	#define BitWrite(value, bit, bitvalue) \
		(bitvalue ? bitSet(value, bit) : bitClear(value, bit))
	
	#define Bit(b) \
		(1 << (b))

#endif

