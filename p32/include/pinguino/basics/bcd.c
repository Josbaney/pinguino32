/*	----------------------------------------------------------------------------
	FILE:				bcd.c
	PROJECT:			pinguino - http://www.pinguino.cc/
	PURPOSE:			various bcd conversion functions
	PROGRAMER:		regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	29 june 2011
	LAST RELEASE:	29 june 2011
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

#ifndef __BCD_C
#define __BCD_C

/* ---------------------------------------------------------------------
   bin2bcd()

   --------------------------------------------------------------------- */

u32 bin2bcd(u32 dec)
{
	return ((dec/10)<<4)+(dec%10);
}

/*
uint bin2bcd (uint const x)
{
	uint bcd = 0;	// valeur BCD initiale
	uint bin = x;	// valeur binaire initiale
	uint nibble;
	int n = 0;		// decalage initial

	// tant que le nombre n'est pas nul
	while (bin)
	{
		// extraire le quartet BCD du binaire (0-9)
		nibble = bin % 10;
		// ranger le quartet en commencant par le poids faible
		bcd |= nibble << n;
		// augmenter le decalage de 4 bits pour preparer l'emplacement du quartet suivant
		n += 4;
		// se debarasser de la dizaine traitee
		bin /= 10;
	}
	return bcd;
}
*/

/* ---------------------------------------------------------------------
   bcd2bin()
   --------------------------------------------------------------------- */

u32 bcd2bin(u32 bcd)
{
	return ((bcd>>4)*10)+bcd%16;
}

/*
uint bcd2bin (uint const x)
{
	uint bin = 0;	// valeur binaire initiale
	uint bcd = x;	// valeur BCD initiale
	uint n = 1;
	uint nibble;

	// tant que le nombre n'est pas nul,
	while (bcd)
	{
		// on extrait le quartet de poids faible
		nibble = bcd & 0x0F;
		// on ajoute le produit du quartet par la dizaine courante * (1, 10, 100 etc.)
		bin += (nibble * n);
		// on change de dizaine
		n *= 10;
		// on se debarasse qu qurtet traite
		bcd >>= 4;
	}
	return bin;
}
*/
#endif	/* __BCD_C */
