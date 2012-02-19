/*-------------------------------------------------------------------------
  main32.c - Application main function for Pinguino 32

             (c) 2010, 2011 Jean-Pierre Mandon <jp.mandon@gmail.com>
             (c) 2010, 2011 Régis Blanchot <rblanchot@gmail.com> 

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
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
    
    * 2011-09-22  Added UART3,4,5,6 support, Marcus Fazzi <anunakin@gmail.org>
-------------------------------------------------------------------------*/

#include <p32xxxx.h>			// always in first place to avoid conflict with const.h ON
#include <typedef.h>
#include <const.h>
#include <macro.h>
#include <system.c>
#include "define.h"
#ifndef __32MX220F032D__
	#include <newlib.c>
#endif	
#include <cdc.h> 

#include "user.c"

int main()
{
	#if defined(PIC32_PINGUINO) || defined(PIC32_PINGUINO_OTG)
	TRISDbits.TRISD9=1;			// because PORTB is shared with SDA on Olimex board
	TRISDbits.TRISD10=1;		// because PORTB is shared with SCL on Olimex board
	#endif	
	
	#ifdef PIC32_PINGUINO_220
	SystemConfig(40000000);
	// configure port maping
	SystemUnlock();
	CFGCONbits.IOLOCK=0;		// unlock configuration
	CFGCONbits.PMDLOCK=0;
	#ifdef __SERIAL__
		U2RXRbits.U2RXR=6;			// Define U2RX as RC8 ( D0 )
		RPC9Rbits.RPC9R=2;			// Define U2TX as RC9 ( D1 )
		U1RXRbits.U1RXR=2;			// Define U1RX as RA4 ( UEXT SERIAL )
		RPB4Rbits.RPB4R=1;			// Define U1TX as RB4 ( UEXT SERIAL )
	#endif
	#ifdef __SPI__
		SDI1Rbits.SDI1R=5;			// Define SDI1 as RA8 ( UEXT SPI )
		RPA9Rbits.RPA9R=3;			// Define SDO1 as RA9 ( UEXT SPI )
	#endif
	CFGCONbits.IOLOCK=1;		// relock configuration
	CFGCONbits.PMDLOCK=1;	
	SystemLock();
	TRISCbits.TRISC9 = OUTPUT;	// RC9 / U2TX output
	TRISCbits.TRISC8 = INPUT;	// RC8 / U2RX input			
	#else
	SystemConfig(80000000);	// default clock frequency is 80Mhz
							// default peripheral freq. is 40MHz (cf. system.c)
	#endif

	// All pins of PORTB as digital IOs
#ifdef __32MX220F032D__
	DDPCONbits.JTAGEN=0;
	ANSELA = 0;
	ANSELB = 0;
	ANSELC = 0;
#else
	AD1PCFG = 0xFFFF;
#endif
	
	#ifdef __ANALOG__
	analog_init();
	#endif

	#ifdef __MILLIS__
	millis_init();
	#endif

	#ifdef __PWM__
	PWM_init();
	#endif    

	#ifdef __USBCDC
	CDC_init();
	#endif    

	#ifdef __RTCC__
	RTCC_init();
	#endif    
	
	setup();

	while (1)
	{
		#ifdef __USBCDC
		CDCTxService();
		#endif    
		loop();
	}

	return(0);    
}

#ifndef __SERIAL__
void Serial1Interrupt(void)
{
	Nop();    
}

void Serial2Interrupt(void)
{
	Nop();    
}
#else
#ifndef ENABLE_UART3
void Serial3Interrupt(void)
{
	Nop();
}
#endif
#ifndef ENABLE_UART4
void Serial4Interrupt(void)
{
	Nop();
}
#endif
#ifndef ENABLE_UART5
void Serial5Interrupt(void)
{
	Nop();
}
#endif
#ifndef ENABLE_UART6
void Serial6Interrupt(void)
{
	Nop();
}
#endif
#endif /* __SERIAL__ */

#ifndef __MILLIS__
void Tmr2Interrupt(void)
{
	Nop();    
}
#endif /* __MILLIS__ */

#ifndef __SPI__
/*
void SPIxInterrupt(void)
{
	Nop();    
}
*/
#endif /* __SPI__ */

// vector 35
#ifndef __RTCC__
void RTCCInterrupt(void)
{
	Nop();    
}
#endif /* __RTCC__ */


