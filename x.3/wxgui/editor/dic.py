#!/usr/bin/env python
#-*- coding: utf-8 -*-

"""-------------------------------------------------------------------------
    Dictionary of commands and snippets.

    author:		Yeison Cardona
    contact:		yeison.eng@gmail.com 
    first release:	03/February/2012
    last release:	08/July/2012
    
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

import os, time
date = time.ctime()

from wxgui._trad import _

Autocompleter = {
    
"directive": ["define", "include", "ifndef", "endif",],
"reserved" : ["TRUE", "FALSE", "HIGH", "LOW", "INPUT", "OUTPUT", "FOSC", "MIPS", "ON", "OFF",
              "LED1", "LED2", "LED3", "LED4", "REDLED", "GREENLED", "BLUELED", "WHITELED", "YELLOWLED",
              "PROGBUTTON", "USERBUTTON",
              "PORTA", "PORTB", "PORTC", "PORTD", "PORTE", "PORTF", "PORTG",
              "if", "switch", "for", "while", "do", "continue", "break", "else", "return", "case", "default",
              "void", "const", "bool", "BOOL", "char", "unsigned", "short", "int", "long", "float", "double", "byte", "word",
              "u8", "s8", "u16", "s16", "u32", "s32", "u64", "s64",
              "struct", "union", "typedef", "enum", "register",  "static", "extern", "volatile",
              "loop", "setup",],
}


Snippet = {}
#Snippet[name {snippet}]=[[cursorline, cursor position],"to insert"]
Snippet["void {snippet}"] = [[1, 5], "void (){\n\n\t}"]
Snippet["while( ) {snippet}"] = [[1, 7], "while (){\n\n\t}"]
Snippet["do {...} while  {snippet}"] = [[3, 8], "do {\n\t\n} while();"]
Snippet["for {snippet}"] = [[1, 5], "for (){\n\n\t}"]
Snippet["for (i=0;...{snippet}"] = [[1, 9], "for (i =  ;i< ;i++){\n\n\t}"]
Snippet["if...else {snippet}"] = [[1, 4], "if (){\n\n\t}\nelse {\n\n\t}"]
Snippet["if...else if...else {snippet}"] = [[1, 4], "if (){\n\n\t}\nelse if (){\n\n\t}\nelse {\n\n\t}"]
Snippet["switch( ) {snippet}"] = [[1, 8], "switch (){\n\tcase:\n\n\t\tbreak;\n\tdefault:\n\n\t}"]
Snippet[_("Bare Minimum")+" {snippet}"] = [[3, [1, 0]], "void setup() {\n\t//run once:\n\t\n\t}\n\nvoid loop() {\n\t//run repeatedly:\n\n\t}"]
Snippet[_("Insert Info")+" {snippet}"] = [[2, 1 + len(_("Author:"))],
"""/*----------------------------------------------------- 
%s:  --<>
%s: %s
%s:

-----------------------------------------------------*/
""" %(_("Author"), _("Date"), date, _("Description"))]
