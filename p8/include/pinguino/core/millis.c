// millis library for pinguino
// Jean-Pierre MANDON 2009
// added interrupt.c functions (regis blanchot 2011)

#ifndef __MILLIS__
#define __MILLIS__

#include "interrupt.c"

long _millis;

void millis_init(void)
{
	intUsed[INT_TMR0] = INT_USED;
	T0CON = 0x80;		// TMR0 on, 16 bits counter, prescaler=2
	INTCON |= 0xA0;		// set GIE and TMR0IE
	_millis = 0;
}

long Millis()
{
	return(_millis);
}

#endif
