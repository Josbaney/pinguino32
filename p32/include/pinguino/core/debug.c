/*	----------------------------------------------------------------------------
	---------- debug.c
	----------------------------------------------------------------------------
	@author		Régis Blanchot <rblanchot@gmail.com>
	@descr		Enable Debug Mode
	--------------------------------------------------------------------------*/

#ifndef __DEBUG_C
#define __DEBUG_C

#include <stdarg.h>

void debug(const char *format, ...)
{
	va_list args;
	va_start(args, format);

	#if defined(NODEBUG)
	#endif

	#if defined(USBCDCDEBUG)
		#include <__cdc.c>
		CDCprintf("debug: ");
		CDCprintf(format, args);
		CDCprintf("\r\n");
	#endif

	#if defined(USBBULKDEBUG)
	#endif

	#if defined(USBHIDDEBUG)
	#endif

	#if defined(USBOTGDEBUG)
	#endif

	#if defined(UART1DEBUG)
		#include <serial.c>
		serial1init(9600);
		serial1printf("debug: ");
		serial1printf(format, args);
		serial1printf("\r\n");
	#endif

	#if defined(UART2DEBUG)
		#include <serial.c>
		serial2init(9600);
		serial2printf("debug: ");
		serial2printf(format, args);
		serial2printf("\r\n");
	#endif

	va_end(args);
}

#endif	/* __DEBUG_C */

