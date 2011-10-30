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

#ifndef __PINGUINOSERIAL2_C
#define __PINGUINOSERIAL2_C

#include <stdarg.h>
#include <printf.c>
#include <serial.c>
#include <typedef.h>

void serial2init(u32 speed)
{
	SerialConfigure(UART2, UART_ENABLE,	UART_RX_TX_ENABLED,	speed);
}

void serial2printf(char *fmt, ...)		
{
	va_list args;

	va_start(args, fmt);
	pprintf(SerialUART2WriteChar, fmt, args);
	va_end(args);
}

/*******************************************************************************
	And For Compatibility Reasons ....
	16-08-2011: fixed bug in print - Régis Blanchot & Tiew Weng Khai
	29-10-2011: fixed uncompatible arg. *s / serial2printf - Régis Blanchot
*******************************************************************************/

void serial2print(char *fmt,...)
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
			serial2printf("%d",fmt);
			break;
		case HEX:
			serial2printf("%x",fmt);
			break;
		case BYTE:
			serial2printf("%d",fmt);
			break;
		case OCT:
			serial2printf("%o",fmt);
			break;
		case BIN:
			serial2printf("%b",fmt);
			break;           
		default:
			serial2printf(fmt);
			break;
	}
}

/*
void serial2print(char *fmt,...)
{
	va_list args;
	va_start(args, fmt);

	switch (*args)
	{
		case DEC:
			serial2printf("%d",(int)fmt);
			break;
		case HEX:
			serial2printf("%x",(int)fmt);
			break;
		case BYTE:
			serial2printf("%d",(unsigned char)fmt);
			break;
		case OCT:
			serial2printf("%o",(int)fmt);
			break;
		case BIN:
			serial2printf("%b",(int)fmt);
			break;           
		default:
			serial2printf(fmt);
			break;
	}

	va_end(ap);
}
*/

void serial2println(char *fmt,...)
{
	serial2printf(fmt);
	serial2printf("\r\n");
}

void serial2write(char c)
{
	SerialUART2WriteChar(c);
}

char serial2getkey(void)
{
	return SerialGetKey(UART2);
}

char * serial2getstring(void)
{
	return SerialGetString(UART2);
}

char serial2available(void)
{
	return SerialAvailable(UART2);
}

char serial2read(void)
{
	return SerialRead(UART2);
}

void serial2flush(void)
{
	SerialFlush(UART2);
}

#endif /* __PINGUINOSERIAL2_C */

