// UART Library for PIC 18F2550
// SDCC version / small device c compiler
// written by Jean-Pierre MANDON 2008 jp.mandon@free.fr
/*
   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 2, or (at your option) any
   later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

   In other words, you are welcome to use, share and improve this program.
   You are forbidden to forbid anyone else to use, share and improve
   what you give them.   Help stamp out software-hoarding!
*/
// this program is intended for an oscillator frequency of 20 Mhz


// local definition UART.C

#ifndef __PINGUINOSERIAL
#define __PINGUINOSERIAL

#include <pic18fregs.h>
#include <typedef.h>
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.c>

//#define FLOAT 10

#ifndef RXBUFFERLENGTH
#define RXBUFFERLENGTH 128              // rx buffer length
#endif

char rx[RXBUFFERLENGTH];                // this is the buffer
unsigned char wpointer,rpointer;        // write and read pointer

#define __SERIAL__

// setup PIC UART
void serial_begin(unsigned long baudrate)
{
	unsigned long spbrg;
	unsigned char highbyte,lowbyte;

	spbrg=(48000000/(4*baudrate))-1;
	highbyte=spbrg/256;
	lowbyte=spbrg%256;
#if defined (PIC18F2550) || defined (PIC18F4550)
	TXSTAbits.BRGH=1;               	  	// set BRGH bit
	BAUDCONbits.BRG16=1;					// set 16 bits SPBRG
	SPBRGH=highbyte;                        // set UART speed SPBRGH
	SPBRG=lowbyte;   						// set UART speed SPBRGL
	RCSTA=0x90;                             // set RCEN and SPEN
	BAUDCONbits.RCIDL=1;			// set receive active
	PIE1bits.RCIE=1;                        // enable interrupt on RX
	IPR1bits.RCIP=1;                        // define high priority for RX interrupt
	TXSTAbits.TXEN=1;                       // enable TX
#endif
#ifdef PIC18F26J50
	TXSTA1bits.BRGH=1;               	  	// set BRGH bit
	BAUDCON1bits.BRG16=1;					// set 16 bits SPBRG
	SPBRGH1=highbyte;                        // set UART speed SPBRGH
	SPBRG1=lowbyte;   						// set UART speed SPBRGL
	RCSTA1=0x90;                             // set RCEN and SPEN
	BAUDCON1bits.RCIDL=1;			// set receive active
    PIR1bits.RC1IF = 0;		// Clear interrupt flag
	PIE1bits.RC1IE=1;                        // enable interrupt on RX
	IPR1bits.RC1IP=1;                        // define high priority for RX interrupt
	TXSTA1bits.TXEN=1;                       // enable TX
	PIR1bits.TX1IF=0;
	PIE1bits.TX1IE=0;
#endif
	wpointer=1;                             // initialize write pointer
	rpointer=1;                             // initialize read pointer
	INTCONbits.PEIE=1;                      // enable peripheral interrupts
	INTCONbits.GIE=1;
	RCONbits.IPEN = 1;       // enable interrupt priorities
}

// new character receive ?
unsigned char serial_available()
{
	return(wpointer!=rpointer);
}

// write char
void serial_putchar(unsigned char caractere)
{
#if defined (PIC18F2550) || defined (PIC18F4550)
	while (!TXSTAbits.TRMT);
	TXREG=caractere;		        // yes, send char
#endif
#ifdef PIC18F26J50
	while (!TXSTA1bits.TRMT);
	TXREG1=caractere;		        // yes, send char
#endif
}

// serial_int is called by interruption service routine
void serial_interrupt(void)
{
	char caractere;
	unsigned char newwp;

#if defined (PIC18F2550) || defined (PIC18F4550)
	PIR1bits.RCIF=0;				// clear RX interrupt flag
	caractere=RCREG;				// take received char
#endif
#ifdef PIC18F26J50
	PIR1bits.RC1IF=0;				// clear RX interrupt flag
	caractere=RCREG1;				// take received char
#endif
	if (wpointer!=RXBUFFERLENGTH-1)	// if not last place in buffer
		newwp=wpointer+1;			// place=place+1
	else
		newwp=1;					// else place=1

	if (rpointer!=newwp)			// if read pointer!=write pointer
		rx[wpointer++]=caractere;	// store received char

	if (wpointer==RXBUFFERLENGTH)	// if write pointer=length buffer
		wpointer=1;					// write pointer = 1
}

// get char
unsigned char serial_read()
{
	unsigned char caractere=0;

	if (serial_available())
    {
	    caractere=rx[rpointer++];
	    if (rpointer==RXBUFFERLENGTH)
		rpointer=1;
    }
	return(caractere);
}

// clear rx buffer
void serial_flush(void)
{
	wpointer=1;
	rpointer=1;
}

/*	----------------------------------------------------------------------------
	serial_printf()
	rblanchot@gmail.com
	write formated string on the serial port
	--------------------------------------------------------------------------*/

void serial_printf(char *fmt, ...)
{
	va_list args;

	va_start(args, fmt);
	pprintf(serial_putchar, fmt, args);
	va_end(args);
}

/*	----------------------------------------------------------------------------
	serial_getkey()
	rblanchot@gmail.com
	--------------------------------------------------------------------------*/

u8 serial_getkey()
{
	u8 c;
	while (!(serial_available()));
	c = serial_read();
	serial_flush();
	return (c);
}

/*	----------------------------------------------------------------------------
	serial_getstring()
	rblanchot@gmail.com
	--------------------------------------------------------------------------*/

u8 * serial_getstring()
{
	u8 buffer[80];
	u8 c;
	u8 i = 0;

	//buffer = (u8 *) malloc(80);
	do {
		c = serial_getkey();
		serial_printf("%c", c);
		buffer[i++] = c;
	} while (c != '\r');
	buffer[i] = '\0';
	return (buffer);
}

/*******************************************************************************
	And For Compatibility Reasons ....
	16-08-2011: fixed bug in print - Régis Blanchot & Tiew Weng Khai
*******************************************************************************/

void serial_print(char *fmt,...)
{
	va_list ap;
	unsigned char *s;
	//char chaine[8];

	va_start(ap, fmt);
	s = va_start(ap, fmt);

	switch (*s)
	{
		case DEC:
			serial_printf("%d",fmt);
			break;
		case HEX:
			serial_printf("%x",fmt);
			break;
		case BYTE:
			serial_printf("%d",fmt);
			break;
		case OCT:
			serial_printf("%o",fmt);
			break;
		case BIN:
			serial_printf("%b",fmt);
			break;
		default:
			serial_printf(fmt);
			break;
	}

/*
	switch (*s)
	{
		case DEC:
			serial_printf("%d",(int)fmt);
			break;
		case HEX:
			serial_printf("%x",(int)fmt);
			break;
		case BYTE:
			serial_printf("%d",(unsigned char)fmt);
			break;
		case OCT:
			uitoa((int)fmt, chaine, 8);
			serial_printf(chaine);
			break;
		case BIN:
			uitoa((int)fmt, chaine, 2);
			serial_printf(chaine);
			break;
		default:
			serial_printf(fmt);
			break;
	}
*/
	va_end(ap);
}

/*	----------------------------------------------------------------------------
	serial_println()
	rblanchot@gmail.com
	Prints data to the serial port as human-readable ASCII text followed by
	a carriage return character (ASCII 13, or '\r') and a newline character
	(ASCII 10, or '\n').
	--------------------------------------------------------------------------*/

void serial_println(char *fmt,...)
{
	serial_print(fmt);
	serial_printf("\n\r");
}

#endif
