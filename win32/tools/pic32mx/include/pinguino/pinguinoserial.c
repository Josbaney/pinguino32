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

#ifndef __PINGUINOSERIAL_C
	#define __PINGUINOSERIAL_C

#include <stdarg.h>
#include <stdio.c>
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

u8 serial1getkey(void)
{
	return SerialGetKey(UART1);
}

u8 * serial1getstring(void)
{
	return SerialGetString(UART1);
}

u8 serial1available(void)
{
	return SerialAvailable(UART1);
}

u8 serial1read(void)
{
	return SerialRead(UART1);
}

void serial1flush(void)
{
	SerialFlush(UART1);
}

#endif
