/*
  ITDB02_Touch.cpp - Arduino library support for ITDB02 Touch function
  Copyright (C)2010 Henning Karlsen. All right reserved
  
  Basic functionality of this library are based on the demo-code provided by
  ITead studio. You can find the latest version of the library at
  http://www.henningkarlsen.com/electronics

  This library has been made for the 2.4" TFT LCD Screen Module: ITDB02-2.4, 
  the 3.2" TFT LCD Screen Module: ITDB02-3.2 and the 3.2" Wide-screen module 
  ITDB02-3.2WC by ITead studio.

  If you make any modifications or improvements to the code, I would appreciate
  that you share the code with me so that I might include it in the next release.
  I can be contacted through http://www.henningkarlsen.com/electronics/contact.php

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
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

  Version:   1.0  - Sep  13 2010  - initial release
			 1.01 - Sep  18 2010  - Added example: ITDB02_Touch_ButtonTest
			 1.1  - Oct   7 2010  - Fixed incompatibility with ITDB02-3.2
			 1.2  - Oct  12 2010  - Added support for ITDB02-3.2WC
			 1.2.1- Mar  11 2011  - Port to Pinguino32X (PIC32) by Marcus Fazzi

*/

#ifndef ITDB02_Touch_c
#define ITDB02_Touch_c

#define PixSizeX	14.44
#define PixOffsX	302
#define PixSizeY	11.07
#define PixOffsY	360

#include <digitalw.c>
#include "itdb02_touch.h"

void ITDB02_Touch(unsigned char tclk, unsigned char tcs, unsigned char din, unsigned char dout, unsigned char irq)
{
    T_CLK = tclk;
    T_CS  = tcs;
    T_DIN = din;
    T_DOUT= dout;
    T_IRQ = irq;
}

void InitTouch(unsigned char orient_tation)
{
	orient_t = orient_tation;

    pinmode(T_CLK,  OUTPUT);
    pinmode(T_CS,   OUTPUT);
    pinmode(T_DIN,  OUTPUT);
    pinmode(T_DOUT, INPUT);
    pinmode(T_IRQ,  INPUT);

	digitalwrite(T_CS,  HIGH);
	digitalwrite(T_CLK, HIGH);
	digitalwrite(T_DIN, HIGH);
	digitalwrite(T_CLK, HIGH);
}

void touch_WriteData(unsigned char data)
{
	unsigned char temp;
	unsigned char nop;
	unsigned char count;

	temp=data;
	digitalwrite(T_CLK,LOW);

	for(count=0; count<8; count++)
	{
		if(temp & 0x80)
			digitalwrite(T_DIN, HIGH);
		else
			digitalwrite(T_DIN, LOW);
		temp = temp << 1; 
		digitalwrite(T_CLK, LOW);                
		nop++;
		digitalwrite(T_CLK, HIGH);
		nop++;
	}
}

unsigned int touch_ReadData()
{
	unsigned char nop;
	unsigned int data = 0;
	unsigned char count;
	
	for(count=0; count<12; count++)
	{
		data <<= 1;
		digitalwrite(T_CLK, HIGH);               
		nop++;
		digitalwrite(T_CLK, LOW);
		nop++;
		if (digitalread(T_DOUT))
			data++;
	}
	return(data);
}

void read()
{
	unsigned long tx=0;
	unsigned long ty=0;
	int i;
	
	digitalwrite(T_CS,LOW);                    

	for (i=0; i<prec; i++)
	{
		touch_WriteData(0x90);        
		digitalwrite(T_CLK,HIGH);
		digitalwrite(T_CLK,LOW); 
		ty+=touch_ReadData();

		touch_WriteData(0xD0);      
		digitalwrite(T_CLK,HIGH);
		digitalwrite(T_CLK,LOW);
		tx+=touch_ReadData();
	}

	digitalwrite(T_CS,HIGH);

	TP_X=tx/prec;
	TP_Y=ty/prec;
}

unsigned char dataAvailable()
{
  unsigned char avail;
  avail = !digitalread(T_IRQ);
  return avail;
}

int getX()
{
	int value;

	if (orient_t == PORTRAIT)
	{
		if (PixSizeX>=0)
		{
			value = 240-((TP_X-PixOffsX)/PixSizeX);
		}
		else
		{
			value = (TP_X-PixOffsX)/-(PixSizeX);
		}
	}
	else
	{
		if (PixSizeY<0)
			value = 400-((TP_Y-PixOffsY)/-PixSizeY);
		else
			value = ((TP_Y-PixOffsY)/PixSizeY);
	}

	if (value < 0)
		value = 0;
	return value;
}

int getY()
{
	int value;

	if (orient_t == PORTRAIT)
	{
		if (PixSizeY<0)
			value = ((TP_Y-PixOffsY)/-PixSizeY);
		else
			value = 320-((TP_Y-PixOffsY)/PixSizeY);
	}
	else
	{
		if (PixSizeX>=0)
		{
			value = 240-((TP_X-PixOffsX)/PixSizeX);
		}
		else
		{
			value = (TP_X-PixOffsX)/-(PixSizeX);
		}
	}

	if (value < 0)
		value = 0;
	return value;  
}

void setPrecision(unsigned char precision)
{
	switch (precision)
	{
		case PREC_LOW:
			prec=1;
			break;
		case PREC_MEDIUM:
			prec=10;
			break;
		case PREC_HI:
			prec=25;
			break;
		case PREC_EXTREME:
			prec=100;
			break;
		default:
			prec=10;
			break;
	}
}

#endif
