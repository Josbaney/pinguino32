// Digital Library for Pinguino
// jean-pierre MANDON 2008
// modification 2009/08/08 18F4550
// regis blanchot 2011/08/09 : FreeJALduino support
// regis blanchot 2012/02/14 : Pinguino 26J50 support

#ifndef __DIGITALW__
#define __DIGITALW__

#include <pic18fregs.h>
#include <typedef.h>

#define pB	0
#define pC	1
#define pA	2
#define pD	3
#define pE	4
#define pF	5
#define pG	6

#define _0	1<<0	// 0x01
#define _1	1<<1	// 0x02
#define _2	1<<2	// 0x04
#define _3	1<<3	// 0x08
#define _4	1<<4	// 0x10
#define _5	1<<5	// 0x20
#define _6	1<<6	// 0x40
#define _7	1<<7	// 0x80

#ifdef PIC18F4550
const u8 mask[29]={	_0,_1,_2,_3,_4,_5,_6,_7,		// PORTB
					_6,_7,_0,_1,_2,					// PORTC
					_0,_1,_2,_3,_5,					// PORTA
					_0,_1,_2,						// PORTE
					_0,_1,_2,_3,_4,_5,_6,_7};		// PORTD

//const u8 port[29]={	0,0,0,0,0,0,0,0,1,1,1,1,1,2,2,2,2,2,4,4,4,3,3,3,3,3,3,3,3};

const u8 port[29]={	pB, pB, pB, pB, pB, pB, pB, pB,
					pC, pC, pC, pC, pC,
					pA, pA, pA, pA, pA,
					pE, pE, pE,
					pD, pD, pD, pD, pD, pD, pD, pD};
#endif

#ifdef PIC18F2550
const u8 mask[19]={	_0,_1,_2,_3,_4,_5,_6,_7,
					_6,_7,_0,_1,_2,
					_0,_1,_2,_3,_5,_4};

const u8 port[19]={	pB, pB, pB, pB, pB, pB, pB, pB,
					pC, pC, pC, pC, pC,
					pA, pA, pA, pA, pA, pA};
#endif

#ifdef PIC18F26J50
const u8 mask[18]={	_0,_1,_2,_3,_4,_5,_6,_7,        // 0 - 7
					_6,_7,_0,_1,_2,                 // 8 - 12
					_0,_1,_2,_3,_5};                // 13 -17

const u8 port[18]={	pB, pB, pB, pB, pB, pB, pB, pB, // 0 -7
					pC, pC, pC, pC, pC,             // 8 - 12
					pA, pA, pA, pA, pA};            // 13 - 17
#endif

#ifdef FREEJALDUINO
const u8 mask[19]={_7,_6,_4,_0,_1,_2,_3,_4,_5,_6,_7,_0,_1,_2,_0,_1,_2,_3, _5};
const u8 port[19]={1,1,2,0,0,0,0,0,0,0,0,1,1,1,2,2,2,2,2};
#endif

#ifdef PICUNO_EQUO
const u8 mask[14]={_7,_6,_2,_3,_0,_2,_1,_1,_2,_3,_4,_5,_6,_7};
const u8 port[14]={1,1,0,0,3,1,1,3,3,3,3,3,3,3};
#endif

void digitalwrite(u8 output, u8 state)
{
	switch (port[output])
	{
		case pB: if (state) PORTB=PORTB | mask[output]; 
				else PORTB=PORTB & (255-mask[output]);
				break;
		case pC: if (state) PORTC=PORTC | mask[output];
				else PORTC=PORTC & (255-mask[output]);
				break;
		case pA: if (state) PORTA=PORTA | mask[output];
				else PORTA=PORTA & (255-mask[output]);
				break;
		#if defined(PIC18F4550) || defined(PICUNO_EQUO) 
		case pD: if (state) PORTD=PORTD | mask[output]; 
				else PORTD=PORTD & (255-mask[output]);
				break;
		case pE: if (state) PORTE=PORTE | mask[output]; 
				else PORTE=PORTE & (255-mask[output]);
				break;
		#endif
	}
}

u8 digitalread(u8 input)
{
	switch (port[input])
	{
		case pB: if ((PORTB & mask[input])!=0) return (1);
			else return (0);
			break;
		case pC: if ((PORTC & mask[input])!=0) return (1);
			else return (0);
			break;
		case pA: if ((PORTA & mask[input])!=0) return (1);
			else return (0);
			break;
		#if defined(PIC18F4550) || defined(PICUNO_EQUO) 
		case pD: if ((PORTD & mask[input])!=0) return (1);
			else return (0);
			break;
		case pE: if ((PORTE & mask[input])!=0) return (1);
			else return (0);
			break;
		#endif	
	}
	return (0);
}

void pinmode(u8 input, u8 state)
{
	switch (port[input])
	{
		case pB: if (state) TRISB=TRISB | mask[input];
			else TRISB=TRISB & (255-mask[input]);
			break;
		case pC: if (state) TRISC=TRISC | mask[input];
			else TRISC=TRISC & (255-mask[input]);
			break;
		case pA: if (state) TRISA=TRISA | mask[input];
			else TRISA=TRISA & (255-mask[input]);
			break;
		#if defined(PIC18F4550) || defined(PICUNO_EQUO) 
		case pD: if (state) TRISD=TRISD | mask[input];
			else TRISD=TRISD & (255-mask[input]);
			break;
		case pE: if (state) TRISE=TRISE | mask[input];
			else TRISE=TRISE & (255-mask[input]);
			break;
		#endif	
	}
}

void toggle(u8 pin)
{
	u8 val;
	val = digitalread(pin);
	digitalwrite(pin, val^1);
}

#endif
