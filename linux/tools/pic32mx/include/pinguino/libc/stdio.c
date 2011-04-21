/*	----------------------------------------------------------------------------
	FILE:			stdio.c
	PROJECT:		pinguino32X
	PURPOSE:		alternative printf and sprintf functions
	PROGRAMER:		Copyright (C) 2004,2008  Kustaa Nyholm
	ADAPTED BY:		regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	10 nov. 2010
	LAST RELEASE:	13 janv. 2011
	----------------------------------------------------------------------------
	TODO :
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

#ifndef __STDIO_C
	#define __STDIO_C

	//#include <libc/stdarg.h>
	#include <stdarg.h>

	typedef void (*stdout) (int);	// type of :	void foo(int x)
	static stdout pputchar;			// then : 		void pputchar(int x)

	static void pprintchar(char **str, int c)
	{
		if (str)
		{
			**str = c;
			++(*str);
		}
		else
		{
			//(void)pputchar(c);
			pputchar(c);
		}
	}

	#define PAD_RIGHT 1
	#define PAD_ZERO 2

	static int pprints(char **out, const char *string, int width, int pad)
	{
		register int pc = 0;
		int padchar = ' ';
		int len = 0;
		const char *ptr;

		if (width > 0)
		{
			for (ptr = string; *ptr; ++ptr)
				++len;
			if (len >= width)
				width = 0;
			else
				width -= len;
			if (pad & PAD_ZERO) padchar = '0';
		}
		if (!(pad & PAD_RIGHT))
		{
			for ( ; width > 0; --width)
			{
				pprintchar(out, padchar);
				++pc;
			}
		}
		for ( ; *string ; ++string)
		{
			pprintchar(out, *string);
			++pc;
		}
		for ( ; width > 0; --width)
		{
			pprintchar(out, padchar);
			++pc;
		}

		return pc;
	}

	/* the following should be enough for 32 bit int */
	#define PRINT_BUF_LEN 12

	static int pprinti(char **out, int i, int b, int sg, int width, int pad, int letbase)
	{
		char print_buf[PRINT_BUF_LEN];
		char *s;
		int t, neg = 0, pc = 0;
		unsigned int u = i;

		if (i == 0)
		{
			print_buf[0] = '0';
			print_buf[1] = '\0';
			return pprints(out, print_buf, width, pad);
		}

		if (sg && b == 10 && i < 0)
		{
			neg = 1;
			u = -i;
		}

		s = print_buf + PRINT_BUF_LEN-1;
		*s = '\0';

		while (u)
		{
			t = u % b;
			if( t >= 10 )
				t += letbase - '0' - 10;
			*--s = t + '0';
			u /= b;
		}

		if (neg)
		{
			if (width && (pad & PAD_ZERO))
			{
				pprintchar(out, '-');
				++pc;
				--width;
			}
			else
			{
				*--s = '-';
			}
		}

		return pc + pprints(out, s, width, pad);
	}

	static int pprint(char **out, const char *format, va_list args)
	{
		int width, pad;
		register int pc = 0;
		char scr[2];

		for (; *format != 0; ++format)
		{
			if (*format == '%')
			{
				++format;
				width = pad = 0;
				if (*format == '\0')
					break;
				if (*format == '%')
					goto abort;
				if (*format == '-')
				{
					++format;
					pad = PAD_RIGHT;
				}
				while (*format == '0')
				{
					++format;
					pad |= PAD_ZERO;
				}
				for ( ; *format >= '0' && *format <= '9'; ++format)
				{
					width *= 10;
					width += *format - '0';
				}
				if (*format == 's')
				{
					//char *s = (char *)va_arg(args, int);
					char *s = va_arg(args, char*);
					//s = va_arg(args, char*);
					pc += pprints(out, s?s:"(null)", width, pad);
					continue;
				}
				if (*format == 'd')
				{
					pc += pprinti(out, va_arg(args, int), 10, 1, width, pad, 'a');
					continue;
				}
				if (*format == 'x')
				{
					pc += pprinti(out, va_arg(args, int), 16, 0, width, pad, 'a');
					continue;
				}
				if (*format == 'X')
				{
					pc += pprinti(out, va_arg(args, int), 16, 0, width, pad, 'A');
					continue;
				}
				if (*format == 'b')
				{
					pc += pprinti(out, va_arg(args, int), 2, 0, width, pad, 'a');
					continue;
				}
				if (*format == 'o')
				{
					pc += pprinti(out, va_arg(args, int), 8, 0, width, pad, 'a');
					continue;
				}
				if (*format == 'u')
				{
					pc += pprinti(out, va_arg(args, int), 10, 0, width, pad, 'a');
					continue;
				}
				if (*format == 'c')
				{
					/* char are converted to int then pushed on the stack */
					scr[0] = (char)va_arg(args, int);
					//scr[0] = va_arg(args, char);
					scr[1] = '\0';
					pc += pprints(out, scr, width, pad);
					continue;
				}
				if (*format == 'f')
				{
					pc += pprints(out, "not yet implemented\0", width, pad);
					continue;
				}
			}
			else
			{
			abort:
				pprintchar(out, *format);
				++pc;
			}
		}
		if (out) **out = '\0';
		//va_end( args );
		return pc;
	}

	//int pprintf(stdout func, const char *format, ...)
	int pprintf(stdout func, const char *format, va_list args)
	{
		//va_list args;
		
		pputchar = func;
		//va_start( args, format );
		return pprint(0, format, args);
	}

	//int psprintf(char *out, const char *format, va_list args)
	int sprintf(char *out, const char *format, ...)
	{
		va_list args;

		va_start(args, format);
		return pprint(&out, format, args);
	}

#endif
