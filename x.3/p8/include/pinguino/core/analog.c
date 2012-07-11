// analogic input library for pinguino
// Jean-Pierre MANDON 2008
// added 18F4550 support 2009/08/10
// 2012-07-10 regis blanchot added 18F26J50 support

#ifndef __ANALOG__
#define __ANALOG__

#define ANALOG 		1
#define DEFAULT		0
#define	EXTERNAL	1

#include <pic18fregs.h>
#include <typedef.h>

void analog_init(void)
{
#if defined(PIC18F4550)
	TRISA=TRISA | 0x2F;
	TRISE=TRISE | 0x07;	
	ADCON1=0x07;
	ADCON2=0xBD;
#elif defined(PICUNO_EQUO)
	TRISA=TRISA | 0x2F;	//RA0..2, RA5
	TRISE=TRISE | 0x03;	//RE0..1
	ADCON1=0x08;		//AN0-AN6, Vref+ = VDD, RA4 as Digital o/p
	ADCON2=0xBD;		//Right justified, 20TAD, FOSC/16
#elif defined(PIC18F26J50)
	TRISA=TRISA | 0x2F;	// 0b00101111 = RA0,1,2,3 and RA5 = AN0 to AN4 are INPUT
	ANCON0=0x1F;        // 0b00011111 = AN0 to AN4 enabled, AN5 to AN7 disabled
	ANCON1=0x0A;        // 0b00000000 = AN8 to AN12 disabled
	ADCON0=0x00;        // 0b00000000 = VRef-=VSS, VRef+=VDD, CHS = AN0 to AN4 
	ADCON1=0xBD;		// 0b10111101 = Right justified, Calibration Normal, 20TAD, FOSC/16
#else
	TRISA=TRISA | 0x2F; // 0b00101111 = RA0,1,2,3 and RA5 = AN0 to AN4 are INPUT
	ADCON1=0x0A;        // 0b00001000 = 0, 0, VRef-=VSS, VRef+=VDD, AN0 to AN4 enabled 
	ADCON2=0xBD;        // 0b10111101 = Right justified, 0, 20 TAD, FOSC/16
#endif
}


void analogReference(u8 Type)
{
#if !defined(PIC18F26J50)
	if(Type == DEFAULT)			//the default analog reference of 5 volts (on 5V Arduino boards) or 3.3 volts (on 3.3V Arduino boards)
		ADCON1|=0x00;			//Vref+ = VDD
	else if(Type == EXTERNAL)	//the voltage applied to the AREF pin (0 to 5V only) is used as the reference.
		ADCON1|=0x10;			//Vref+ = External source
#else
	if(Type == DEFAULT)			//the default analog reference of 5 volts (on 5V Arduino boards) or 3.3 volts (on 3.3V Arduino boards)
		ADCON0|=0x00;			//Vref+ = VDD
	else if(Type == EXTERNAL)	//the voltage applied to the AREF pin (0 to 5V only) is used as the reference.
		ADCON0|=0x40;			//Vref+ = External source
#endif
}

u16 analogread(u8 channel)
{
	u16 result=0;
// #if defined(PIC18F4550) || defined(PICUNO_EQUO)
// ADCON1=0x07;
// #else
// ADCON1=0x0A;
// #endif

	#ifdef PICUNO_EQUO
		if(channel>=14 && channel<=16)
			ADCON0=(channel-14)*4;
		else if(channel>=17 && channel<=19)
			ADCON0=(channel-13)*4;
	#else
		ADCON0=(channel-13)*4;
	#endif
	
// ADCON2=0xBD;
	ADCON0bits.ADON=1;
	for (result=1;result<10;result++) __asm NOP __endasm;
		ADCON0bits.GO=1;
	while (ADCON0bits.GO);
	result=ADRESH<<8;
	result+=ADRESL;
	ADCON0bits.ADON=0;
	return(result);
}

#endif
