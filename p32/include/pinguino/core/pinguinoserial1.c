/*	----------------------------------------------------------------------------
	FILE:			pinguinoserial.c
	PROJECT:		pinguinoX
	PURPOSE:		
	PROGRAMER:		jean-pierre mandon <jp.mandon@gmail.com>
	FIRST RELEASE:	01 jan. 2011
	LAST RELEASE:	
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

#ifndef __PINGUINOSERIAL1_C
#define __PINGUINOSERIAL1_C

#include <stdarg.h>
#include <printf.c>
#include <serial.c>
#include <typedef.h>

void serial1init(u32 speed)
{
	SerialConfigure(UART1, UART_ENABLE,	UART_RX_TX_ENABLED,	speed);
}

void serial1printf(char *fmt, ...)		
{
	va_list args;

	va_start(args, fmt);
	pprintf(SerialUART1WriteChar, fmt, args);
	va_end(args);
}

/*******************************************************************************
	And For Compatibility Reasons ....
	16-08-2011: fixed bug in print - Régis Blanchot & Tiew Weng Khai
	29-10-2011: fixed uncompatible arg. *s - Régis Blanchot
*******************************************************************************/

void serial1print(char *fmt,...)
{
	//	unsigned char *s;
	unsigned char s;
	va_list args;					// list of arguments

	va_start(args, fmt);			// initialize the list
	// s = va_start(args, fmt);
	s = (unsigned char) va_arg(args, int);		// get the first variable arg.

	//switch (*s)
	switch (s)
	{
		case DEC:
			serial1printf("%d",fmt);
			break;
		case HEX:
			serial1printf("%x",fmt);
			break;
		case BYTE:
			serial1printf("%d",fmt);
			break;
		case OCT:
			serial1printf("%o",fmt);
			break;
		case BIN:
			serial1printf("%b",fmt);
			break;           
		default:
			serial1printf(fmt);
			break;
	}
}

/*
void serial1print(char *fmt,...)
{
	va_list args;
	va_start(args, fmt);

	switch (*args)
	{
		case DEC:
			serial1printf("%d",(int)fmt);
			break;
		case HEX:
			serial1printf("%x",(int)fmt);
			break;
		case BYTE:
			serial1printf("%d",(unsigned char)fmt);
			break;
		case OCT:
			serial1printf("%o",(int)fmt);
			break;
		case BIN:
			serial1printf("%b",(int)fmt);
			break;           
		default:
			serial1printf(fmt);
			break;
	}
	va_end(args);
}
*/

void serial1println(char *fmt,...)
{
	serial1printf(fmt);
	serial1printf("\r\n");
}

void serial1write(char c)
{
	SerialUART1WriteChar(c);
}

char serial1getkey(void)
{
	return SerialGetKey(UART1);
}

char * serial1getstring(void)
{
	return SerialGetString(UART1);
}

char serial1available(void)
{
	return SerialAvailable(UART1);
}

char serial1read(void)
{
	return SerialRead(UART1);
}

void serial1flush(void)
{
	SerialFlush(UART1);
}

#endif /* __PINGUINOSERIAL1_C */

