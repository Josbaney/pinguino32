/*	----------------------------------------------------------------------------
	---------- debug.c
	----------------------------------------------------------------------------
	@author		Régis Blanchot <rblanchot@gmail.com>
	@descr		Enable Debug Mode on USB Serial port (CDC)
	--------------------------------------------------------------------------*/

#ifndef __DEBUG_C
#define __DEBUG_C

#include <__cdc.c>
#include <stdarg.h>

void debug(const char *format, ...)
{
	#if defined(DEBUG)
		va_list args;
		va_start(args, format);
		CDCprintf("debug: ");
		CDCprintf(format, args);
		CDCprintf("\r\n");
		va_end(args);
	#endif
}

#endif	/* __DEBUG_C */

