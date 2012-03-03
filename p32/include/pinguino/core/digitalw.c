/*	----------------------------------------------------------------------------
	FILE:			digitalw.c
	PROJECT:		pinguino
	PURPOSE:		
	PROGRAMER:		jean-pierre mandon <jp.mandon@gmail.com>
	FIRST RELEASE:	02 dec. 2010
	LAST RELEASE:	30 jan. 2012
	----------------------------------------------------------------------------
	CHANGELOG:
	[02-12-10][jp.mandon@gmail.com][tested from 0 to 31 OK except PORTA pin]
	[02-12-10][rblanchot@gamil.com][PORTA pin issue fixed in system.c]
	[13-02-11][jp.mandon@gmail.com][updated for EMPEROR 460 and PIC32_PINGUINO]
	[15-02-11][Marcus Fazzi][UBW32 mask fixed]
	[23-02-11][Marcus Fazzi][PGC/PGD order for UBW32 mask fixed]
	[18-03-11][Marcus Fazzi][Added support for MX795]
	[20-03-11][Marcus Fazzi][IO mapping for Emperor boards] 
	[31-03-11][rblanchot@gmail.com][fixed conditional compilation for board support]
	[30-01-12][rblanchot@gmail.com][added PIC32-PINGUINO-220 et PIC32-PINGUINO-MICRO]
	[03-03-12][jp.mandon@gmail.com][added UEXT pin for PIC32-PINGUINO-MX220]
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

#ifndef __DIGITALW_C
#define __DIGITALW_C
	
#include <p32xxxx.h>
#include <typedef.h>

#define pA	0
#define pB	1
#define pC	2
#define pD	3
#define pE	4
#define pF	5
#define pG	6

#define _0	1<<0
#define _1	1<<1
#define _2	1<<2
#define _3	1<<3
#define _4	1<<4
#define _5	1<<5
#define _6	1<<6
#define _7	1<<7
#define _8	1<<8
#define _9	1<<9
#define _10	1<<10
#define _11	1<<11
#define _12	1<<12
#define _13	1<<13
#define _14	1<<14
#define _15	1<<15

// #define for PIC32_PINGUINO

#ifdef PIC32_PINGUINO

const u32 portmask[]=
				 {3,3,3,3,3,3,3,3,	// 0-7
				  1,1,6,6,6,6,1,1,	// 8-15
				  1,1,3,3,1,1,4,4,	// 16-23
				  4,4,4,4,4,4,3,5,	// 24-31
				  5};				// 32
				  
const u32 pinmask[]={0x04,0x08,0x01,0x20,0x40,0x80,0x100,0x800,		// 0-7
				  0x4000,0x8000,0x200,0x100,0x80,0x40,0x02,0x04,	// 8-15
				  0x08,0x10,0x200,0x400,0x800,0x400,0x01,0x02,		// 16-23
				  0x04,0x08,0x10,0x20,0x40,0x80,0x02,0x02,			// 24-31
				  0x01};											// 32
#endif

#ifdef PIC32_PINGUINO_OTG

const u32 portmask[]=
				 {3,3,3,3,3,3,3,3,	// 0-7
				  1,1,6,6,6,6,1,1,	// 8-15
				  1,1,3,3,1,1,4,4,	// 16-23
				  4,4,4,4,4,4,3,5,	// 24-31
				  5};				// 32
				  
const u32 pinmask[]={0x04,0x08,0x01,0x20,0x40,0x80,0x100,0x800,		// 0-7
				  0x2000,0x4000,0x200,0x100,0x80,0x40,0x02,0x04,	// 8-15
				  0x08,0x10,0x200,0x400,0x800,0x400,0x01,0x02,		// 16-23
				  0x04,0x08,0x10,0x20,0x40,0x80,0x02,0x02,			// 24-31
				  0x01};											// 32
#endif

#ifdef PIC32_PINGUINO_MICRO

const u32 portmask[]= {	 pB,  pB,  pB,  pB,  pB,  pB,  pB,  pB,	// 0-7
				  		 pB,  pB,  pD,  pD,  pD,  pD,  pD,  pD,	// 8-15
				  		 pB,  pD,  pD,  pD,  pG,  pF,  pE,  pE,	// 16-23
				  		 pE,  pE,  pE,  pE,  pE,  pE,  pC,  pC,	// 24-31
				  		 pG };									// 32

const u32 pinmask[]=  {  _1,  _2,  _3,  _4,  _8,  _9, _10, _11,	// 0-7
				  	    _12, _14,  _1,  _2,  _3,  _4,  _5,  _6,	// 8-15
				  		 _0,  _7,  _8, _11,  _9,  _1,  _7,  _6,	// 16-23
				  		 _5,  _4,  _3,  _2,  _1,  _0, _13, _14,	// 24-31
				  		 _6 };									// 32
#endif

#ifdef PIC32_PINGUINO_220

const u32 portmask[]={	pC,pC,pC,pC,pC,pC,pC,pC,	// D0-D7	: C8,C9,C2,C3,C4,C5,C6,C7 
				  		pB,pA,pA,pB,pB,pB,			// D8-D13	: B7,A10,A1,B5,B13,B15
						pC,pC,pB,pB,pB,pB,			// D14-D19
						pA,pB,pB };					// D20 (UEXT_CS),D21 (SDA1 UEXT), D22 (SCL1 UEXT)
				  
const u32 pinmask[]={	_8,_9,_2,_3,_4,_5,_6,_7,	// D0-D7	: C8,C9,C2,C3,C4,C5,C6,C7
						_7,_10,_1,_5,_13,_15,		// D8-D13	: B7,A10,A1,B5,B13,B15
						_0,_1,_0,_1,_2,_3,			// A0-A5	: C0,C1,B0,B1,B2,B3
						_7,_9,_8 };					// D20		: A7,B9,B8
#endif

//define for EMPEROR 460/795 boards
#if defined(EMPEROR460) || defined(EMPEROR795)

const u32 portmask[]=
				 {2,6,6,6,6,0,4,4, //0-7
				  1,1,1,1,1,1,0,0, //8-15
				  1,1,1,1,0,5,5,1, //16-23
				  1,1,1,3,3,5,5,5, //24-31
				  5,5,0,0,0,0,0,0, //32-39				  
				  2,2,2,4,4,4,6,4, //40-47				  
				  4,4,6,6,6,4,4,0, //48-55				  
				  0,6,6,5,5,3,3,3, //56-63				  
				  3,3,3,3,3,3,2,2, //64-71
				  3,3,3,3,3,1,1};  //72-78

const u32 pinmask[]={0x10,0x40,0x80,0x100,0x200,0x01,0x100,0x200,		//0-7
				  0x20,0x10,0x08,0x04,0x02,0x01,0x200,0x400,			//8-15
				  0x100,0x200,0x400,0x800,0x02,0x2000,0x1000,0x1000,	//16-23
				  0x2000,0x4000,0x8000,0x4000,0x8000,0x10,0x20,0x08,	//24-31
				  0x04,0x100,0x04,0x08,0x10,0x20,0x4000,0x8000,			//32-39				  
				  0x08,0x04,0x02,0x80,0x40,0x20,0x8000,0x10,			//40-47				  
				  0x08,0x04,0x2000,0x1000,0x4000,0x02,0x01,0x80,		//48-55				  
				  0x40,0x01,0x02,0x02,0x01,0x80,0x40,0x20,				//56-63				  
				  0x10,0x2000,0x1000,0x08,0x04,0x02,0x4000,0x2000,		//64-71
				  0x01,0x800,0x400,0x200,0x100,0x80,0x40};				//72-78
#endif				  

// define for UBW32 460/795 boards, same for Pinguino Minimum

#if defined(UBW32_460) || defined(UBW32_795)

const u32 portmask[]=
				 {2,6,6,6,6,0,4,4, //0-7
				  1,1,1,0,0,1,1,1, //8-15
				  1,0,5,5,1,1,1,1, //16-23
				  3,3,5,5,5,5,0,0, //24-31
				  0,0,0,0,3,3,3,3, //32-39
				  3,2,2,3,3,3,3,3, //40-47
				  3,3,3,3,5,5,6,6, //48-55
				  0,0,4,4,6,6,6,4, //56-63
				  4,4,6,4,4,4,2,2, //64-71
				  2,1,1,1,1,1,5};  //72-78
				  

const u32 pinmask[]={0x10,0x40,0x80,0x100,0x200,0x01,0x100,0x200,		//0-7
				  0x20,0x10,0x08,0x200,0x400,0x100,0x200,0x400,				//8-15
				  0x800,0x02,0x2000,0x1000,0x1000,0x2000,0x4000,0x8000, 	//16-23
				  0x4000,0x8000,0x10,0x20,0x04,0x100,0x04,0x08,				//24-31
				  0x10,0x20,0x4000,0x8000,0x100,0x200,0x400,0x800,			//32-39
				  0x1,0x2000,0x4000,0x2,0x4,0x8,0x1000,0x2000,				//40-47
				  0x10,0x20,0x40,0x80,0x1,0x2,0x2,0x1,							//48-55
				  0x40,0x80,0x1,0x2,0x4000,0x1000,0x2000,0x4,				//56-63
				  0x8,0x10,0x8000,0x20,0x40,0x80,0x2,0x4,						//64-71
				  0x8,0x80,0x40,0x4,0x2,0x1,0x8 };								//72-78

#endif

void pinmode(u8 pin,u8 state)
{
	switch (portmask[pin])
	{
		#ifndef __32MX440F256H__
		case 0: if (state) TRISASET=pinmask[pin];
				else TRISACLR=pinmask[pin];
				break;
		#endif
		case 1: if (state) TRISBSET=pinmask[pin];
				else TRISBCLR=pinmask[pin];
				break;
		case 2: if (state) TRISCSET=pinmask[pin];
				else TRISCCLR=pinmask[pin];
				break;
		#ifndef __32MX220F032D__
		case 3: if (state) TRISDSET=pinmask[pin];
				else TRISDCLR=pinmask[pin];
				break;
		case 4: if (state) TRISESET=pinmask[pin];
				else TRISECLR=pinmask[pin];
				break;
		case 5: if (state) TRISFSET=pinmask[pin];
				else TRISFCLR=pinmask[pin];
				break;
		case 6: if (state) TRISGSET=pinmask[pin];
				else TRISGCLR=pinmask[pin];
				break;
		#endif
	}
}

u8 pinread(u8 pin)
{
	u32 reg;

	switch (portmask[pin])
	{
		#ifndef __32MX440F256H__
		case 0:
			reg = TRISA;
			break;
		#endif
		case 1:
			reg = TRISB;
			break;
		case 2:
			reg = TRISC;
			break;
		#ifndef __32MX220F032D__
		case 3:
			reg = TRISD;
			break;
		case 4:
			reg = TRISE;
			break;
		case 5:
			reg = TRISF;
			break;
		case 6:
			reg = TRISG;
			break;
		#endif
	}
	if ((reg & pinmask[pin])!=0)
		return 1;
	else
		return 0;
}
		  
void digitalwrite(u8 pin,u8 state)
{
	switch (portmask[pin])
	{
		#ifndef __32MX440F256H__
		case 0: if (state) PORTASET=pinmask[pin];
				else PORTACLR=pinmask[pin];
				break;
		#endif
		case 1: if (state) PORTBSET=pinmask[pin];
				else PORTBCLR=pinmask[pin];
				break;
		case 2: if (state) PORTCSET=pinmask[pin];
				else PORTCCLR=pinmask[pin];
				break;
		#ifndef __32MX220F032D__
		case 3: if (state) PORTDSET=pinmask[pin];
				else PORTDCLR=pinmask[pin];
				break;
		case 4: if (state) PORTESET=pinmask[pin];
				else PORTECLR=pinmask[pin];
				break;
		case 5: if (state) PORTFSET=pinmask[pin];
				else PORTFCLR=pinmask[pin];
				break;
		case 6: if (state) PORTGSET=pinmask[pin];
				else PORTGCLR=pinmask[pin];
				break;
		#endif
	}	
}

u8 digitalread(u8 pin)
{
	switch (portmask[pin])
	{
		#ifndef __32MX440F256H__
		case 0: return((PORTA&pinmask[pin])!=0);
				break;
		#endif
		case 1: return((PORTB&pinmask[pin])!=0);
				break;
		case 2: return((PORTC&pinmask[pin])!=0);
				break;
		#ifndef __32MX220F032D__
		case 3: return((PORTD&pinmask[pin])!=0);
				break;
		case 4: return((PORTE&pinmask[pin])!=0);
				break;
		case 5: return((PORTF&pinmask[pin])!=0);
				break;
		case 6: return((PORTG&pinmask[pin])!=0);
				break;
		#endif
		default: return -1;
	}
	return -1;			
}

void toggle(u8 pin)
{
	digitalwrite(pin, digitalread(pin)^1);
}

#endif	/* __DIGITALW_C */
