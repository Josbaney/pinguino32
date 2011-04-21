/*	----------------------------------------------------------------------------
	macro.h
	Régis Blanchot
	--------------------------------------------------------------------------*/

#ifndef __MACRO_H
	#define __MACRO_H

	/// ASM

	#define interrupts()	asm("ei")
	#define noInterrupts()	asm("di")

	/// BYTES

	#define high8(x)			(unsigned char) (x >> 8)
	#define low8(x)				(unsigned char) (x & 0xFF)

	/// BITWISE OPERATION

	// Lire le bit n de octet
	#define BitRead(byte, n) \
		(byte = byte >> n & 1)

	// Met le bit n à 1 dans octet
	#define BitSet(byte, n) \
		(byte |= (1 << n))

	// Met le bit n à 0 dans octet
	#define BitClear(byte, n) \
		(byte = byte & !(1 << n))

	#define BitWrite(value, bit, bitvalue) \
		(bitvalue ? bitSet(value, bit) : bitClear(value, bit))
	
	#define bit(b) \
		(1 << (b))

	/// MATH

	//#define min(a,b) ((a)<(b)?(a):(b))
	//#define max(a,b) ((a)>(b)?(a):(b))
	//#define abs(x) ((x)>0?(x):-(x))
	//#define constrain(amt,low,high) ((amt)<(low)?(low):((amt)>(high)?(high):(amt)))
	//#define round(x)     ((x)>=0?(long)((x)+0.5):(long)((x)-0.5))
	//#define radians(deg) ((deg)*DEG_TO_RAD)
	//#define degrees(rad) ((rad)*RAD_TO_DEG)
	//#define sq(x) ((x)*(x))

#endif
