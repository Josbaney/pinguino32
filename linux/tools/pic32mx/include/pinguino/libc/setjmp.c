/*	----------------------------------------------------------------------------
	FILE:			setjmp.c
	PROJECT:		pinguino32X
	PURPOSE:		alternative port of libc
	PROGRAMER:		regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	14 feb. 2011
	LAST RELEASE:	14 feb. 2011
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

#ifndef __SETJMP_C
#define __SETJMP_C

#define SP_SIZE		1

#ifdef SDCC_STACK_AUTO
#define BP_SIZE		SP_SIZE
#else
#define BP_SIZE		0
#endif

#ifdef SDCC_USE_XSTACK
#define SPX_SIZE	1
#else
#define SPX_SIZE	0
#endif

#define BPX_SIZE	SPX_SIZE

#define RET_SIZE	2

typedef unsigned char jmp_buf[RET_SIZE + SP_SIZE + BP_SIZE + SPX_SIZE + BPX_SIZE];

int setjmp (jmp_buf);
int longjmp(jmp_buf, int);

#undef RET_SIZE
#undef SP_SIZE
#undef BP_SIZE
#undef SPX_SIZE
#undef BPX_SIZE

#endif
