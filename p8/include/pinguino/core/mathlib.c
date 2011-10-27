/**	----------------------------------------------------------------------------
	---------- mathlib.c
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
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

	----------------------------------------------------------------------------
	---------- Author			: R. Blanchot <rblanchot@gmail.com>
	---------- First release	:
	---------- Last  update 	: 31 mai 2010
	---------- Description  	: Routines mathématiques
	---------- Compilateur		: SDCC 2.8.0
	---------- Dev.Board		: Pinguino
	---------- Dev.Envt			: Code::Blocks
	---------- Bootloader		: bootloader.hex (cf. Pinguino beta5)
	---------- Programmer		: PUF/Docker
	---------- MCU				: PIC18F2550
	---------- Oscillator		: 20.0000 MHz
	---------- Configuration	: CONFIG.txt
	---------- Compilation 		: CODEBLOCKS.txt
	---------- Transfer			: docker -v04d8 write firmware.hex
	--------------------------------------------------------------------------*/

#ifndef __MATH
	#define __MATH

	#include "typedef.h"

	s8 min(s8, s8);
	s8 max(s8, s8);
	u8 abs(s8);
	u8 constrain(u8, u8, u8);
	s32 map(s32, s32, s32, s32, s32);

/**	----------------------------------------------------------------------------
	---------- Min
 	----------------------------------------------------------------------------
	Description	: Calculates the minimum of two numbers.
	Parameters	: a and b, the two numbers, any data type
	Returns		: The smaller of the two numbers.
	#define min(a,b) ((a<b)?(a):(b))
	--------------------------------------------------------------------------*/

s8 min(s8 a, s8 b)
{
	if (a <= b)
		return a;
	else
		return b;
}

/**	----------------------------------------------------------------------------
	---------- Max
 	----------------------------------------------------------------------------
	Description	: Calculates the maximum of two numbers.
	Parameters	: a and b, the two numbers, any data type
	Returns		: The larger of the two parameter values.
	#define max(a,b) ((a>b)?(a):(b))
 	--------------------------------------------------------------------------*/

s8 max(s8 a, s8 b)
{
	if (a >= b)
		return a;
	else
		return b;
}

/**	----------------------------------------------------------------------------
	---------- Abs
 	----------------------------------------------------------------------------
	Description	: Computes the absolute value of a number.
	Parameters	: x, the number
	Returns		: x if x is greater than or equal to 0.
				 -x if x is less than 0.
	#define abs(x) ((x>0)?(x):(-x))
 	--------------------------------------------------------------------------*/

u8 abs(s8 x)
{
	if (x < 0) x = -x;
	return x;
}

/**	----------------------------------------------------------------------------
	---------- Constrain
 	----------------------------------------------------------------------------
	Description	:
	Parameters	:
	Returns		:
	#define constrain(amt,low,high) ((amt<low)?(low):((amt>high)?(high):(amt)))
 	--------------------------------------------------------------------------*/

u8 constrain(u8 amt, u8 low, u8 high)
{
	if (amt < low)
	 	return low;
	else
	{
		if (amt > high)
			return high;
		else
			return amt;
	}
}

/**	----------------------------------------------------------------------------
	---------- Map
 	----------------------------------------------------------------------------
	Description	: map(value, fromLow, fromHigh, toLow, toHigh)
	Parameters	:
	Returns		:
 	--------------------------------------------------------------------------*/

s32 map(s32 x, s32 in_min, s32 in_max, s32 out_min, s32 out_max)
{
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

