/*	----------------------------------------------------------------------------
	FILE:			analog.c
	PROJECT:		pinguinoX
	PURPOSE:		
	PROGRAMER:		jean-pierre mandon <jp.mandon@gmail.com>
	FIRST RELEASE:	19 feb. 2011
	LAST RELEASE:	26 feb. 2011
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
// 2.april 2011 fixed conditional compilation for board support jp.mandon

#ifndef __ANALOG__
#define __ANALOG__

#ifdef PIC32_PINGUINO
u16 __analogmask[]={0x0002,0x0004,0x0008,0x0010,0x0100,0x0200,0x0800,0x0400,
		    		0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0002,0x0004,
		    		0x0008,0x0010,0x0100,0x0200,0x0800,0x0400};
u16 __bufmask[]=   {0x0004,0x0008,0x000C,0x0010,0x0020,0x0024,0x002C,0x0028,
		    		0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0004,0x0008,
		    		0x000C,0x0010,0x0020,0x0024,0x002C,0x0028};
#endif

#if defined(EMPEROR460) || defined(EMPEROR795)
u16 __analogmask[]={0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
				    0x0020,0x0010,0x0008,0x0004,0x0002,0x0001,0x0000,0x0000,
				    0x0100,0x0200,0x0400,0x0800,0x0000,0x0000,0x0000,0x1000,
				    0x2000,0x4000,0x8000};
u16 __bufmask[]=   {0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,				  
					0x0014,0x0010,0x000C,0x0008,0x0004,0x0000,0x0000,0x0000,				  
					0x001E,0x0022,0x0026,0x002A,0x0000,0x0000,0x0000,0x002E,
					0x0032,0x0036,0x003A};					
#endif

#if defined(UBW32_460) || defined(UBW32_795)
u16 __analogmask[]={0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
				    0x0020,0x0010,0x0008,0x0000,0x0000,0x0100,0x0200,0x0400,
				    0x0800,0x0000,0x0000,0x0000,0x1000,0x2000,0x4000,0x8000};
u16 __bufmask[]=   {0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
					0x0014,0x0010,0x000C,0x0000,0x0000,0x0020,0x0024,0x0028,
					0x002C,0x0000,0x0000,0x0000,0x0030,0x0034,0x0038,0x003C};				    
#endif

void SetAnalog(u8 pin)
{
	#ifdef PIC32_PINGUINO
	if ((pin==4)||(pin==18)) TRISDbits.TRISD9=1;   // analog input 18 is shared with I2C
	if ((pin==5)||(pin==19)) TRISDbits.TRISD10=1;  // analog input 19 is shared with I2C
	#endif
	TRISBSET=__analogmask[pin];
	AD1PCFGCLR=__analogmask[pin];
}

u8 IsDigital(u8 pin)
{
	if ((AD1PCFG&__analogmask[pin])!=0) return 1;
	else return 0;
}
	
void analog_init(void)
{
	AD1CSSL = 0;
	AD1CON1=0x00E0;
	AD1CON2=0;
	AD1CON3 = 0x8F00;
	AD1CON1bits.ADON = 1;
}

u16 analogRead(u8 pin)
{
	
	if (IsDigital(pin)) SetAnalog(pin);	  // set analog
	AD1CHS=(__bufmask[pin]/4)<<16;		  // select channel
	AD1CON1bits.SAMP=1;					  // start sampling
	while (!AD1CON1bits.DONE);			  // wait for conversion
	return(ADC1BUF0+(8*(AD1CON2bits.BUFS&0x01))); // return result
}

#endif
