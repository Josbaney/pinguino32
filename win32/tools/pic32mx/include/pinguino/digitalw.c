/*	----------------------------------------------------------------------------
	FILE:			digitalw.c
	PROJECT:		pinguinoX
	PURPOSE:		
	PROGRAMER:		jean-pierre mandon <jp.mandon@gmail.com>
	FIRST RELEASE:	02 dec. 2010
	LAST RELEASE:	02 dec. 2010
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

// 02 dec.2010 tested from 0 to 31 OK except PORTA pin
// probably an alternate function on this port, to be fixed
// fixed by regis blanchot in system.c
// 13 feb.2011 updated for EMPEROR 460 and PIC32_PINGUINO
// 15 feb.2011 UBW32 mask fixed by Marcus Fazzi
// 23 feb.2011 PGC/PGD order for UBW32 mask fixed by Marcus Fazzi
// 17/18 mar.2011 Added support for MX795 by Marcus Fazzi
// 20 mar.2011 IO mapping for Emperor boards revised by Marcus Fazzi
// 2 .avr 2011 removed include p32xxxx.h and transfered to main32.c jp.mandon
// 2 .avr 2011 fixed multiboard support for pinMask jp.mandon

#ifndef __DIGITALW_C
	#define __DIGITALW_C
	
	#include "typedef.h"

// #define for PIC32_PINGUINO

#ifdef PIC32_PINGUINO

const u32 portmask[]=
				 {3,3,3,3,3,3,3,3,
				  1,1,6,6,6,6,1,1,
				  1,1,3,3,1,1,4,4,
				  4,4,4,4,4,4,5,5};
				  
const u32 pinmask[]={0x04,0x08,0x01,0x20,0x40,0x80,0x100,0x800,
				  0x4000,0x8000,0x200,0x100,0x80,0x40,0x02,0x04,
				  0x08,0x10,0x200,0x400,0x800,0x400,0x01,0x02,
				  0x04,0x08,0x10,0x20,0x40,0x80,0x04,0x02};

#endif

//define for EMPEROR 460/795 boards
#if  defined(EMPEROR460) || defined(EMPEROR795)

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
				  0x20,0x10,0x08,0x200,0x400,0x100,0x200,0x400,			//8-15
				  0x800,0x02,0x2000,0x1000,0x1000,0x2000,0x4000,0x8000, //16-23
				  0x4000,0x8000,0x10,0x20,0x04,0x100,0x04,0x08,			//24-31
				  0x10,0x20,0x4000,0x8000,0x100,0x200,0x400,0x800,		//32-39
				  0x1,0x2000,0x4000,0x2,0x4,0x8,0x1000,0x2000,			//40-47
				  0x10,0x20,0x40,0x80,0x1,0x2,0x2,0x1,					//48-55
				  0x40,0x80,0x1,0x2,0x4000,0x1000,0x2000,0x4,			//56-63
				  0x8,0x10,0x8000,0x20,0x40,0x80,0x2,0x4,				//64-71
				  0x8,0x80,0x40,0x4,0x2,0x1,0x8 };						//72-78

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
	}
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
		case 3: return((PORTD&pinmask[pin])!=0);
				break;
		case 4: return((PORTE&pinmask[pin])!=0);
				break;
		case 5: return((PORTF&pinmask[pin])!=0);
				break;
		case 6: return((PORTG&pinmask[pin])!=0);
				break;
		default: return -1;
	}
	return -1;			
}

void toggle(u8 pin)
{
	digitalwrite(pin, digitalread(pin)^1);
}

#endif
