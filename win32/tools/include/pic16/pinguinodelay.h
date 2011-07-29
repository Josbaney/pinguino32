
/*
 * pinguinodelay.h - delay functions header file
 *
 * Based on the file delay.h adopted for SDCC and pic16 
 * port by Vangelis Rokas, 2005 <vrokas AT otenet.gr>
 * created by Jesus Carmona, 2011.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

/*
** $Id: pinguinodelay.h xxxx 2011-04-02 13:13:53Z jcarmona $
*/


#ifndef __PINGUINODELAY_H__
#define __PINGUINODELAY_H__

#pragma library "pinguinodelay.lib"

/*
 * The delayusecs is a function adapted to generate microseconds
 * delays accurately using an integer as input parameter.
 * delayusecs expects a extern variable like this:
 * extern unsigned int microsecs;
 * to be declared in the pinguinodelay.c file.
 * 
 * The delayNNtcy family of functions performs a
 * delay of NN cycles. Possible values for NN are:
 *   12  12*n cycles delay
 *  120  120*n cycles delay
 * These family is derived from delay10XXtcy already written
 * in C.
 *
 * All these three functions are included in a library file
 * called pinguinodelay.lib.
 *
 */
 
void delayusecs();
void delay12tcy(unsigned char) __wparam;
void delay120tcy(unsigned char) __wparam;

#endif
