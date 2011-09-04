/*	----------------------------------------------------------------------------
	---------- debug.c
	----------------------------------------------------------------------------
	@author		Régis Blanchot <rblanchot@gmail.com>
	@descr		Enable Debug Mode
	--------------------------------------------------------------------------*/

#ifndef DEBUG
	#define DEBUG

	#include <serial.c>

	void debug(void)
	{
		serial_begin(9600);
		serial_printf("\n>>> DEBUG MODE ACTIVATED\n");
	}

#endif

