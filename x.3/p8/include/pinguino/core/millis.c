// millis library for pinguino
// Jean-Pierre MANDON 2009
// added interrupt.c functions (regis blanchot 2011)
// [14-05-12][jp.mandon changed long to u32 and Millis to millis / thanks mark harper]

#ifndef __MILLIS__
#define __MILLIS__

#include <pic18fregs.h>
#include <typedef.h>
#include <interrupt.c>

volatile u32 _millis;

void millis_init(void)
{
	intUsed[INT_TMR0] = INT_USED;
	T0CON = 0x80;		// TMR0 on, 16 bits counter, prescaler=2
	INTCON |= 0xA0;		// set GIE and TMR0IE
	_millis = 0;
}

u32 millis()
{
	return(_millis);
}

#endif
