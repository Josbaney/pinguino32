#!/usr/bin/env python
# -*- coding: iso-8859-15 -*-

"""-------------------------------------------------------------------------
	Pinguino Check List

	(c) 2011 Jean-Pierre Mandon <jp.mandon@gmail.com>
				Regis Blanchot <rblanchot@gmail.com> 

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

import sys
import os
import time

""" check pinguino dependencies """

# ------------------------------------------------------------------------------
# turn development version off
# !!! use True at your own risc as it could erase your bootloader !!!
# ------------------------------------------------------------------------------

DEV = False

HOME_DIR	= os.getcwd()
fichier = open(os.path.join(HOME_DIR, 'pinguino.log'), 'w+') # works with paths with spaces
fichier.writelines('Pinguino started at ' + str(time.asctime(time.localtime(time.time())) + '\n\n' ))

def perror():
	print "fatal error, see pinguino.log for more details\n"
	sys.exit()

# ------------------------------------------------------------------------------
# check python's version 
# ------------------------------------------------------------------------------

if sys.version_info[0:2] < (2,5):
	fichier.writelines('Pinguino IDE requires version python 2.5 or greater\n')
	fichier.close()
	perror()
else:
	fichier.writelines('Python version is good (>=2.5)\n')

# ------------------------------------------------------------------------------
# check OS and compilers
# ------------------------------------------------------------------------------
if sys.platform == 'darwin':
	fichier.writelines('System host is Mac OS X\n')
	if os.path.exists(os.path.join(HOME_DIR, 'macosx', 'p8', 'bin')):
		fichier.writelines('8-bit compiler OK.\n')
	else:
		fichier.writelines('No 8-bit compiler for this system.\n')
		fichier.writelines('Download it at http://www.pinguino.cc/download/testing/macosx.tar.bz2\n')
	if os.path.exists(os.path.join(HOME_DIR, 'macosx', 'p32', 'bin')):
		fichier.writelines('32-bit compiler OK.\n')
	else:
		fichier.writelines('No 32-bit compiler for this system.\n')
		fichier.writelines('Download it at http://www.pinguino.cc/download/testing/macosx.tar.bz2\n')
elif sys.platform == 'win32':
	fichier.writelines('System host is Windows\n')
	if os.path.exists(os.path.join(HOME_DIR, 'win32', 'p8', 'bin')):
		fichier.writelines('8-bit compiler OK.\n')
	else:
		fichier.writelines('No 8-bit compiler for this system.\n')
		fichier.writelines('Download it at http://www.pinguino.cc/download/testing/win32.tar.bz2\n')
	if os.path.exists(os.path.join(HOME_DIR, 'win32', 'p32', 'bin')):
		fichier.writelines('32-bit compiler OK.\n')
	else:
		fichier.writelines('No 32-bit compiler for this system.\n')
		fichier.writelines('Download it at http://www.pinguino.cc/download/testing/win32.tar.bz2\n')
else:
	fichier.writelines('System host is GNU/Linux\n')
	if os.path.exists(os.path.join(HOME_DIR, 'linux', 'p8', 'bin')):
		fichier.writelines('8-bit compiler OK.\n')
	else:
		fichier.writelines('No 8-bit compiler for this system.\n')
		fichier.writelines('Download it at http://www.pinguino.cc/download/testing/linux.tar.bz2\n')
	if os.path.exists(os.path.join(HOME_DIR, 'linux', 'p32', 'bin')):
		fichier.writelines('32-bit compiler OK.\n')
	else:
		fichier.writelines('No 32-bit compiler for this system.\n')
		fichier.writelines('Download it at http://www.pinguino.cc/download/testing/linux.tar.bz2\n')

# ------------------------------------------------------------------------------
# check python modules
# ------------------------------------------------------------------------------

try:
	import wx
	fichier.writelines('wx.python successfully loaded\n')
except:
	fichier.writelines('wx.python failed\n')
	fichier.writelines('Try to re-install WXPython 2.8\n')
	fichier.close()
	perror()

try:
	import wx.aui
	fichier.writelines('wx.aui successfully loaded\n')
except:
	fichier.writelines('wx.aui failed\n')
	fichier.writelines('Try to re-install WXPython 2.8\n')
	fichier.close()
	perror()

try:	
	import re
	fichier.writelines('Regex successfully loaded\n')
except:
	fichier.writelines('Regex failed\n')
	fichier.writelines('Try to re-install PyReg\n')
	fichier.close()
	perror()

try:
	import shutil				# to use cp function
	fichier.writelines('Shutil successfully loaded\n')
except:
	fichier.writelines('Shutil failed\n')
	fichier.writelines('Try to re-install PyShutil\n')
	fichier.close()
	perror()

try:	
	from subprocess import Popen,PIPE,STDOUT
	fichier.writelines('Subprocess successfully loaded\n')
except:
	fichier.writelines('Subprocess failed\n')
	fichier.writelines('Try to re-install Python\n')
	fichier.close()
	perror()

try:
	import gettext				# to activate multi-language support
	fichier.writelines('GetText successfully loaded\n')
except:
	fichier.writelines('GetText failed\n')
	fichier.writelines('Try to re-install Python\n')
	fichier.close()
	perror()

try:	
	import locale				# to access system localization functionalities
	fichier.writelines('Locale successfully loaded\n')
except:
	fichier.writelines('locale failed\n')
	fichier.writelines('Try to re-install Python\n')
	fichier.close()
	perror()

try:
	import webbrowser			# to launch website from the IDE
	fichier.writelines('WebBrowser successfully loaded\n')
except:
	fichier.writelines('Webbrowser failed\n')
	fichier.writelines('Try to re-install Python\n')
	fichier.close()
	perror()

if DEV:
	try:	
		import usb			# USB interface for Python
		fichier.writelines('USB successfully loaded\n')
	except:
		fichier.writelines('USB python failed to be loaded\n')
		fichier.writelines('Try to re-install PyUSB\n')
		fichier.close()
		perror()

	try:	
		import serial			# adds the PySerial library (http://sourceforge.net/projects/pyserial/files/pyserial/2.5/pyserial-2.5.win32.exe/download)
		fichier.writelines('Serial successfully loaded\n')
	except:
		fichier.writelines('Serial python failed to be loaded\n')
		fichier.writelines('Try to re-install PySerial\n')
		fichier.close()
		perror()

	try:	
		import threading			# thread functions
		fichier.writelines('Threading successfully loaded\n')
	except:
		fichier.writelines('Threading failed\n')
		fichier.writelines('Try to re-install Python\n')
		fichier.close()
		perror()

# ------------------------------------------------------------------------------
# check pinguino modules
# ------------------------------------------------------------------------------

try:	
	import editeur				# pinguino editor class
	fichier.writelines('Editeur successfully loaded\n')
except:
	fichier.writelines('Editeur failed\n')
	fichier.writelines('You should have editeur.py at the root\n')
	fichier.close()
	perror()

try:
	import argparse			# to write user-friendly command-line interfaces
	fichier.writelines('ArgParse successfully loaded\n')
except:
	fichier.writelines('Argparse python failed to be loaded\n')
	fichier.writelines('Try to re-install python argparse\n')
	fichier.close()
	perror()

try:
	from boards import *
	fichier.writelines('Pinguino Boards List successfully loaded\n')
except:
	fichier.writelines('Pinguino Boards List failed\n')
	fichier.writelines('You should have boards.py at the root\n')
	fichier.close()
	perror()

if DEV:
	try:
		from uploader import uploader	# pinguino uploader class
		#import puu					# pinguino uploader class
		fichier.writelines('Pinguino Uploader successfully loaded\n')
	except:
		fichier.writelines('Pinguino Uploader failed\n')
		fichier.writelines('You should have uploader.py at the root\n')
		fichier.close()
		perror()

	try:
		import pysvn
		fichier.writelines('pySVN successfully loaded\n')
	except:
		fichier.writelines('pySVN failed, try to install pySVN\n')
		if sys.platform == 'linux2':
			fichier.writelines('You will need to install an SVN Client on your distro.\n')
		fichier.writelines('Enable to check new version of Pinguino IDE\n')
		perror()

	try:
		from version import SubversionWorkingCopy, SubversionRepository
		fichier.writelines('Pinguino Version Control successfully loaded\n')
	except:
		fichier.writelines('Pinguino Version Control failed\n')
		fichier.writelines('You should have version.py at the root\n')
		fichier.close()
		perror()

# ------------------------------------------------------------------------------
# end of check 
# ------------------------------------------------------------------------------

fichier.writelines('\nEverything is OK.\n')
fichier.close()

