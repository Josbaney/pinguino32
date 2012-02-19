#!/usr/bin/env python
# -*- coding: iso-8859-15 -*-

"""-------------------------------------------------------------------------
	Pinguino Boards List

	(c) 2011 Regis Blanchot <rblanchot@gmail.com> 

	This library is free software; you can redistribute it and/or
	modify it under the terms of the GNU Lesser General Public
	License as published by the Free Software Foundation; either
	version 2.1 of the License, or (at your option) any later version.

	This library is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
	Lesser General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with this library; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-------------------------------------------------------------------------"""

import wx	# wx.NewId()

# vendors id
MICROCHIP_ID = 0x04D8

# products id
PIC8_ID = 0xFEAA
PIC32_ID = 0x003C

class Generic_18F2550:
	name='Generic_18F2550'
	id=wx.NewId()
	arch=8
	proc='18f2550'
	board='PIC18F2550'
	vendor=MICROCHIP_ID
	product=PIC8_ID
	memstart=0x2000
	memend=0x7fff
	shortarg='-g'
	longarg='--generic2550'

class Generic_18F4550:
	name='Generic_18F4550'
	id=wx.NewId()
	arch=8
	proc='18f4550'
	board='PIC18F4550'
	vendor=MICROCHIP_ID
	product=PIC8_ID
	memstart=0x2000
	memend=0x7fff
	shortarg='-G'
	longarg='--generic4550'

class PICuno_Equo:
	name='PICuno_Equo'
	id=wx.NewId()
	arch=8
	proc='18f4550'
	board='PICUNO_EQUO'
	vendor=MICROCHIP_ID
	product=PIC8_ID
	memstart=0x2000
	memend=0x7fff
	shortarg='-p'
	longarg='--picunoequo'

class FreeJALduino:
	name='FreeJALduino'
	id=wx.NewId()
	arch=8
	proc='18f2550'
	board='FREEJALDUINO'
	vendor=MICROCHIP_ID
	product=PIC8_ID
	memstart=0x2000
	memend=0x7fff
	shortarg='-j'
	longarg='--freejalduino'

class PIC32_Pinguino:
	name='PIC32_Pinguino'
	id=wx.NewId()
	arch=32
	proc='32MX440F256H'
	board='PIC32_PINGUINO'
	vendor=MICROCHIP_ID
	product=PIC32_ID
	memstart=0x00000
	memend=0x40000
	shortarg='-o'
	longarg='--olimex440'

class PIC32_Pinguino_OTG:
	name='PIC32_Pinguino_OTG'
	id=wx.NewId()
	arch=32
	proc='32MX440F256H'
	board='PIC32_PINGUINO_OTG'
	vendor=MICROCHIP_ID
	product=PIC32_ID
	memstart=0x00000
	memend=0x40000
	shortarg='-O'
	longarg='--olimex440OTG'

class PIC32_Pinguino_Micro:
	name='PIC32 Pinguino Micro'
	id=wx.NewId()
	arch=32
	bldr='microchip'
	proc='32MX440F256H'
	board='PIC32_PINGUINO_MICRO'
	vendor=MICROCHIP_ID
	product=PIC32_ID
	memstart=0x00000
	memend=0x40000
	shortarg='-M'
	longarg='--olimex440Micro'

class PIC32_Pinguino_220:
	name='PIC32_Pinguino_220'
	id=wx.NewId()
	arch=32
	bldr='microchip'
	proc='32MX220F032D'
	board='PIC32_PINGUINO_220'
	vendor=MICROCHIP_ID
	product=PIC32_ID
	memstart=0x00000
	memend=0x04000
	shortarg='-m'
	longarg='--olimex220'
	
class Emperor_460:
	name='Emperor_460'
	id=wx.NewId()
	arch=32
	proc='32MX460F512L'
	board='EMPEROR460'
	vendor=MICROCHIP_ID
	product=PIC32_ID
	memstart=0x00000
	memend=0x80000
	shortarg='-e'
	longarg='--emperor460'

class Emperor_795:
	name='Emperor_795'
	id=wx.NewId()
	arch=32
	proc='32MX795F512L'
	board='EMPEROR795'
	vendor=MICROCHIP_ID
	product=PIC32_ID
	memstart=0x00000
	memend=0x80000
	shortarg='-E'
	longarg='--emperor795'

class UBW32_460:
	name='UBW32_460'
	id=wx.NewId()
	arch=32
	proc='32MX460F512L'
	board='UBW32_460'
	vendor=MICROCHIP_ID
	product=PIC32_ID
	memstart=0x00000
	memend=0x80000
	shortarg='-u'
	longarg='--ubw460'

class UBW32_795:
	name='UBW32_795'
	id=wx.NewId()
	arch=32
	proc='32MX795F512L'
	board='UBW32_795'
	vendor=MICROCHIP_ID
	product=PIC32_ID
	memstart=0x00000
	memend=0x80000
	shortarg='-U'
	longarg='--ubw795'

boardlist = [Generic_18F2550, Generic_18F4550, PICuno_Equo, FreeJALduino, PIC32_Pinguino, PIC32_Pinguino_OTG, PIC32_Pinguino_Micro, PIC32_Pinguino_220, Emperor_460, Emperor_795, UBW32_460, UBW32_795]

