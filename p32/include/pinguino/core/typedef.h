/*	----------------------------------------------------------------------------
	typedef.c
	Régis Blanchot
	--------------------------------------------------------------------------*/

#ifndef __TYPEDEF_H
#define __TYPEDEF_H

/*	----------------------------------------------------------------------------
	pinguino types
	--------------------------------------------------------------------------*/

	typedef signed char				s8;
	typedef signed short			s16;
	typedef signed long				s32;
	typedef signed long long 		s64;

	typedef unsigned char			u8;
	typedef unsigned short			u16;
	typedef unsigned long			u32;
	typedef unsigned long long 		u64;
	
/*	----------------------------------------------------------------------------
	avr-gcc types
	--------------------------------------------------------------------------*/

	typedef unsigned char			byte;

	typedef unsigned char			BOOL;//bool;					// not compatible with c++
	typedef unsigned char			boolean;	

	typedef signed char 			int8_t;
	typedef int 					int16_t;
	typedef long 					int32_t;
	typedef long long 				int64_t;

	typedef unsigned char 			uint8_t;
	typedef unsigned int 			uint16_t;
	typedef unsigned long 			uint32_t;
	typedef unsigned long long 		uint64_t;

	/* 8 bits */
	typedef unsigned char			uchar;
	typedef signed char				schar;
	typedef unsigned char			UCHAR;
	typedef signed char				CHAR;

	/* 16 bits */
	typedef int						INT;
	typedef unsigned int			UINT;
	typedef unsigned int			uint;
	typedef signed int				sint;
	typedef unsigned int			word;
	typedef int						SHORT;
	typedef unsigned int			USHORT;
	typedef unsigned int			WORD;
	typedef unsigned int			WCHAR;

	/* 32 bits */
	typedef unsigned long			ulong;
	typedef unsigned long			ULONG;
	typedef signed long				slong;
	typedef unsigned long			dword; 
	typedef unsigned long			DWORD;
	typedef long					LONG;

#endif	/* __TYPEDEF_H */
