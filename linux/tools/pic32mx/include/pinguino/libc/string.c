/*	----------------------------------------------------------------------------
	FILE:			string.c
	PROJECT:		pinguino32X
	PURPOSE:		alternative port of libc
	PROGRAMER:		regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	7 feb. 2011
	LAST RELEASE:	7 feb. 2011
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

#ifndef __STRING_C
	#define __STRING_C

int strlen (const char *str)
{
	const char *start = str;
	while (*str++ != '\0');
	return str - start - 1;
}

int strcmp(const char *s1, const char *s2)
{ 
	while (*s1 != '\0' && *s1 == *s2)
	{
		s1++;
		s2++;
	}
	return (*(unsigned char *) s1) - (*(unsigned char *) s2);
}

char * strcat(char *s1, const char *s2)
{
	char *s = s1;
	while (*s1)
		s1++;
	while (*s1++ = *s2++)
		;
	return s;
}

char * strchr(const char *s1, int i)
{
	const unsigned char *s = (const unsigned char *)s1;
	unsigned char c = i;

	while (*s && *s != c)
		s++;
	if (*s == c)
		return (char *)s;
	return NULL;
}

char * strcpy(char *dst0, const char *src0)
{
	char *s = dst0;

	while (*dst0++ = *src0++)
		;

	return s;
}

char * strncpy(char *dest, const char *src, u8 n)
{
	u8 i;

	for (i = 0 ; i < n && src[i] != '\0' ; i++)
		dest[i] = src[i];
	for ( ; i < n ; i++)
		dest[i] = '\0';

	return dest;
}

#endif

