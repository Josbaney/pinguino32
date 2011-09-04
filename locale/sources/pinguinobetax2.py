#!/usr/bin/env python
#  -*- coding: UTF-8 -*-

"""-------------------------------------------------------------------------
	pinguino

	(c) 2008-2009-2010-2011 Jean-Pierre MANDON <jp.mandon@gmail.com> 

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
	-------------------------------------------------------------------------"""

# $Id: pinguino.py,v beta 2008/09/05 21:36:00 mandon
# ------------------------------------------------------------------------------
# $Id: pinguino.py,v beta 1 2008/09/06 15:03:00 mandon
# replaced splittext by split on save in module editeur
# bug 02 replaced sys.path[0] by sys.path[0].replace(" ","\\ ") for path with spaces only for the linker !!
# jean-pierre mandon / guillaume stagnaro
# ------------------------------------------------------------------------------
# $Id: pinguino.py,v beta 2 2008/09/19 22:45:00 mandon
# added support of analogRead instruction in ReplaceWord
# ------------------------------------------------------------------------------
# $Id: pinguino.py,v beta 3 2008/10/12 22:45:00 mandon
# added support of USB
# modified digitalWrite, digitalRead and pinMode for better compatibility
# ------------------------------------------------------------------------------
# $Id: pinguino.py,v beta 3.1 2008/10/17 22:45:00 mandon
# coorected a bug on analogRead for MAC OS X
# ------------------------------------------------------------------------------
# $Id: pinguino.py,v beta 4 2008/11/02 21:40:00 mandon
# full support of USB Bulk
# modified buffer for USB up to 2 MBytes/second
# ------------------------------------------------------------------------------
# $Id: pinguino.py,v beta 5 2009/03/08 19:41:00 mandon
# full support of User Interrupt
# About dialog modified
# possibility to include libraries #include "mylib.c" work now
# implementation of millis() instruction
# implementation of fast analogWrite on output 11 and 12 ( 3khz PWM ) with 10 bits resolution ( 0..1023 )
# variable initialisation is now possible in the head of the program
# ------------------------------------------------------------------------------
# $Id: pinguino.py,v beta 6 2009/08/12 19:41:00 mandon
# full support of UTF8
# I2C functions
# eeprom write and read function
# support of 4800 bauds for serial
# added CTRL-ESC for inline help in editor
# ------------------------------------------------------------------------------
# $Id: pinguino.py,v beta 7 2009/08/22 17:01:00 mandon
# full support of 18F4550 with #define PIC18F4550 in source
# ------------------------------------------------------------------------------
# pinguino.py,v beta 8 mandon
# #define fixed
# pop up menu can be used in the editor with right click
# added line number to the editor
# Unlimited baud rate for function Serial.begin
# serial rx buffer length can be chosen with directive #RXBUFFERLENGTH, default 128 bytes
# ------------------------------------------------------------------------------
# pinguino.py,v beta 9 mandon
# modified GUI for logo, colors and windows (switched to wx.aui)
# fixed and improved the prepocessor, now use regex ( preprocessor function )
# added readlib function for external libraries
# changed the help shortkey in editor to CTRL space
# ------------------------------------------------------------------------------
# pinguino.py,v beta 9.5 blanchot
# theme
# config. file
# new menus
# size code
# ------------------------------------------------------------------------------
# beta x blanchot
# 8 and 32-bit support
# different board support
# multi-platform support
# debug stream

  
# ------------------------------------------------------------------------------
# import
# ------------------------------------------------------------------------------

import wx
import wx.aui
import editeur
import os
import re
import shutil				# to use cp function
from subprocess import Popen,PIPE,STDOUT
import threading			# thread functions
import sys
import time					# to benchmark algorithms
import gettext				# to activate multi-language support
import locale				# to access system localization functionalities
import webbrowser			# to launch website from the IDE
import argparse			# to write user-friendly command-line interfaces
import serial				# adds the PySerial library (http://sourceforge.net/projects/pyserial/files/pyserial/2.5/pyserial-2.5.win32.exe/download)

# ------------------------------------------------------------------------------
# current version
# ------------------------------------------------------------------------------

pinguino_version="x.2"

# ------------------------------------------------------------------------------
# pathes
# ------------------------------------------------------------------------------

HOME_DIR		= sys.path[0].replace(" ","\\ ")					# for path with spaces
THEME_DIR	= os.path.join(HOME_DIR, 'theme')
TEMP_DIR		= os.path.join(HOME_DIR, 'source')
SOURCE_DIR	= os.path.join(HOME_DIR, 'source')
LOCALE_DIR	= os.path.join(HOME_DIR, 'locale')
P32_DIR		= os.path.join(HOME_DIR, 'p32')
P8_DIR		= os.path.join(HOME_DIR, 'p8')
APP_CONFIG	= os.path.join(HOME_DIR, '.config')

# ------------------------------------------------------------------------------
# boards
# ------------------------------------------------------------------------------

# id board menu
ID_GENERIC2550 = wx.NewId()	# MUST ALWAYS BE IN FIRST POSITION
ID_GENERIC4550 = wx.NewId()
ID_OLIMEX440 = wx.NewId()
ID_EMPEROR460 = wx.NewId()
ID_EMPEROR795 = wx.NewId()
ID_UBW460 = wx.NewId()
ID_UBW795 = wx.NewId()

board1 =	{ 'arch':8,		'proc':'18f2550',			'board':'PIC18F2550',		'totalspace':0x7fff - 0x2000,	'shortarg':'-g', 'longarg':'--generic2550' }
board2 =	{ 'arch':8,		'proc':'18f4550',			'board':'PIC18F4550',		'totalspace':0x7fff - 0x2000,	'shortarg':'-G', 'longarg':'--generic4550' }
board3 =	{ 'arch':32,	'proc':'32MX440F256H',	'board':'PIC32_PINGUINO',	'totalspace':0x40000,			'shortarg':'-o', 'longarg':'--olimex440' }
board4 =	{ 'arch':32,	'proc':'32MX460F512L',	'board':'EMPEROR460',		'totalspace':0x80000,			'shortarg':'-e', 'longarg':'--emperor460' }
board5 =	{ 'arch':32,	'proc':'32MX795F512L',	'board':'EMPEROR795',		'totalspace':0x80000,			'shortarg':'-E', 'longarg':'--emperor795' }
board6 =	{ 'arch':32,	'proc':'32MX460F512L',	'board':'UBW32_460',			'totalspace':0x80000,			'shortarg':'-u', 'longarg':'--ubw460' }
board7 =	{ 'arch':32,	'proc':'32MX795F512L',	'board':'UBW32_795',			'totalspace':0x80000,			'shortarg':'-U', 'longarg':'--ubw795' }

boardlist = {	ID_GENERIC2550:board1,
					ID_GENERIC4550:board2,
					ID_OLIMEX440:board3,
					ID_EMPEROR460:board4,
					ID_EMPEROR795:board5,
					ID_UBW460:board6,
					ID_UBW795:board7		}

# ------------------------------------------------------------------------------
# default
# ------------------------------------------------------------------------------

THEME_DEFAULT = "miniregino"
BOARD_DEFAULT = ID_GENERIC2550
gui=False

# ------------------------------------------------------------------------------
# Pinguino Class
# ------------------------------------------------------------------------------

class Pinguino(wx.Frame):
	
	global lang
	global gui
	
	osdir=""
	sdcc=""
	#gcc=""
	debug_output=0
	debug_handle=False
	debug_thread=False
	debug_flag=False
	noname=0
	proc=""
	arch=8
	keywordList=[]
	reservedword=[]
	libinstructions=[]
	regobject=[]
	rw=[]
	THEME=[]
	KEYWORD=[]
		
# ------------------------------------------------------------------------------
# id
# ------------------------------------------------------------------------------

	# id pref menu
	ID_DEBUG = wx.NewId()
	ID_BOARD = wx.NewId()
	ID_THEME = wx.NewId()

	# id theme menu
	ID_THEME1 = 1000

	# id debug menu
	ID_DEBUG = wx.NewId()
	#ID_NODEBUG = wx.NewId()
	#ID_CDC = wx.NewId()
	#ID_USBBULK = wx.NewId()
	#ID_USBHID = wx.NewId()
	#ID_USBOTG = wx.NewId()
	
	# id help menu
	ID_KEYWORD = wx.NewId()
	ID_WEBSITE = wx.NewId()
	ID_BLOG = wx.NewId()
	ID_FORUM = wx.NewId()
	ID_GROUP = wx.NewId()
	ID_WIKI = wx.NewId()
	ID_TUTORIAL = wx.NewId()
	ID_SHOP = wx.NewId()
	ID_ABOUT = wx.NewId()
	
	# id keywords menu
	ID_KEYWORD1 = 2000

	# other id
	ID_VERIFY = wx.NewId()
	ID_UPLOAD = wx.NewId()		
					   
	def __init__(self, parent, id=-1, title='Pinguino IDE',
				 pos=wx.DefaultPosition ,size=(400, 400),
				 style=wx.DEFAULT_FRAME_STYLE):

		# ----------------------------------------------------------------------
		# get OS name and define some OS dependant variable
		# ----------------------------------------------------------------------

		if sys.platform == 'darwin':
			self.osdir = 'macosx'
			self.debug_port = '/dev/tty.usbmodem1912'
			self.c8 = 'sdcc'
			self.u32 = 'ubw32'
			self.make = 'make'
		elif sys.platform == 'win32':
			self.osdir = 'win32'
			self.debug_port = 15
			self.c8 = 'sdcc.exe'
			self.u32 = 'mphidflash.exe'
			self.make = os.path.join(HOME_DIR, self.osdir, 'p32', 'bin', 'make.exe')
		else:
			self.osdir = 'linux'
			self.debug_port = '/dev/ttyACM0'
			self.c8 = 'sdcc'
			self.u32 = 'ubw32'
			self.make = 'make'

		# ----------------------------------------------------------------------
		# load settings from config file
		# ----------------------------------------------------------------------

		self.config = wx.FileConfig(localFilename = APP_CONFIG, style = wx.CONFIG_USE_LOCAL_FILE)
		self.filehistory = wx.FileHistory()
		self.filehistory.Load(self.config)
		framesize = (  self.config.ReadInt('Window/Width', -1),
					   self.config.ReadInt('Window/Height', -1))
		if framesize == (0, 0):
			framesize = (400, 400)
		framepos = (   self.config.ReadInt('Window/Posx', -1),
					   self.config.ReadInt('Window/Posy', -1))
		outputsize = ( self.config.ReadInt('Output/Width', -1),
					   self.config.ReadInt('Output/Height', -1))
		if outputsize == (0, 0):
			outputsize = (400, 250)
		self.theme =   self.config.Read('Theme/name')
		if self.theme == '':
			self.theme = THEME_DEFAULT
		self.board =   self.config.ReadInt('Board', -1)
		if self.board == '':
			self.board = BOARD_DEFAULT
		
		# ----------------------------------------------------------------------
		# window
		# ----------------------------------------------------------------------

		wx.Frame.__init__(self, parent, id, title, framepos, framesize, style)
		if framepos == ("",""):
			self.Centre()

		loc = locale.getdefaultlocale()[0][0:2]
		self.lang = gettext.translation('pinguino', LOCALE_DIR, languages=[loc], fallback=True)
		_=self.lang.ugettext
		
		self.SetTitle('Pinguino IDE ' + pinguino_version)
		_icon = wx.EmptyIcon()
		_icon.CopyFromBitmap(wx.Bitmap(os.path.join(THEME_DIR, 'logoX.png'), wx.BITMAP_TYPE_ANY))
		self.SetIcon(_icon)		   

		self._mgr = wx.aui.AuiManager(self)	  
		
		self.menu = wx.MenuBar()
		
		# ----------------------------------------------------------------------
		# Menus
		# ----------------------------------------------------------------------

		# file menu
		self.file_menu = wx.Menu()
		self.NEW = wx.MenuItem(self.file_menu, wx.ID_NEW, _("New"), "", wx.ITEM_NORMAL)
		self.file_menu.AppendItem(self.NEW)
		self.OPEN = wx.MenuItem(self.file_menu, wx.ID_OPEN, _("Open"), "", wx.ITEM_NORMAL)
		self.file_menu.AppendItem(self.OPEN)
		self.SAVE = wx.MenuItem(self.file_menu, wx.ID_SAVE, _("Save"), "", wx.ITEM_NORMAL)
		self.file_menu.AppendItem(self.SAVE)
		self.SAVEAS = wx.MenuItem(self.file_menu, wx.ID_SAVEAS, _("Save as"), "", wx.ITEM_NORMAL)
		self.file_menu.AppendItem(self.SAVEAS)
		self.CLOSE = wx.MenuItem(self.file_menu, wx.ID_CLOSE, _("Close"), "", wx.ITEM_NORMAL)
		self.file_menu.AppendItem(self.CLOSE)
		self.EXIT = wx.MenuItem(self.file_menu, wx.ID_EXIT, _("Exit"), "", wx.ITEM_NORMAL)
		self.file_menu.AppendItem(self.EXIT)
		# ---file history-------------------------------------------------------
		self.filehistory.UseMenu(self.file_menu)
		self.filehistory.AddFilesToMenu()		
		self.menu.Append(self.file_menu, _("File"))

		# edit menu
		self.edit_menu = wx.Menu()
		self.UNDO = wx.MenuItem(self.edit_menu, wx.ID_UNDO, _("Undo"), "", wx.ITEM_NORMAL)
		self.edit_menu.AppendItem(self.UNDO)
		self.REDO = wx.MenuItem(self.edit_menu, wx.ID_REDO, _("Redo"), "", wx.ITEM_NORMAL)
		self.edit_menu.AppendItem(self.REDO)
		self.edit_menu.AppendSeparator()
		self.FIND = wx.MenuItem(self.edit_menu, wx.ID_FIND, _("Find"), "", wx.ITEM_NORMAL)
		self.edit_menu.AppendItem(self.FIND)		
		self.REPLACE = wx.MenuItem(self.edit_menu, wx.ID_REPLACE, _("Replace"), "", wx.ITEM_NORMAL)
		self.edit_menu.AppendItem(self.REPLACE)
		self.REPLACE.Enable(False)
		self.edit_menu.AppendSeparator()		
		self.CUT = wx.MenuItem(self.edit_menu, wx.ID_CUT, _("Cut"), "", wx.ITEM_NORMAL)
		self.edit_menu.AppendItem(self.CUT)
		self.COPY = wx.MenuItem(self.edit_menu, wx.ID_COPY, _("Copy"), "", wx.ITEM_NORMAL)
		self.edit_menu.AppendItem(self.COPY)
		self.PASTE = wx.MenuItem(self.edit_menu, wx.ID_PASTE, _("Paste"), "", wx.ITEM_NORMAL)
		self.edit_menu.AppendItem(self.PASTE)  
		self.CLEAR = wx.MenuItem(self.edit_menu, wx.ID_CLEAR, _("Clear"), "", wx.ITEM_NORMAL)
		self.edit_menu.AppendItem(self.CLEAR)
		self.SELECTALL = wx.MenuItem(self.edit_menu, wx.ID_SELECTALL, _("Select all"), "", wx.ITEM_NORMAL)
		self.edit_menu.AppendItem(self.SELECTALL)						
		self.menu.Append(self.edit_menu, _("Edit"))
		
		# preferences menu
		self.pref_menu = wx.Menu()

		# ---debug submenu
		self.DEBUG = wx.MenuItem(self.pref_menu, self.ID_DEBUG, _("Debug"), "", wx.ITEM_CHECK)
		self.pref_menu.AppendItem(self.DEBUG)
		self.DEBUG.Enable(False)
		#if self.config.ReadInt('debug',-1)==True:
		#	self.pref_menu.Check(self.ID_DEBUG,True)
		#	self.OnDebug(wx.Event)

		#self.debug_menu = wx.Menu()
		#self.NODEBUG = wx.MenuItem(self.debug_menu, self.ID_NODEBUG, _("No"), "", wx.ITEM_CHECK)
		#self.debug_menu.AppendItem(self.NODEBUG)
		#self.NODEBUG.Enable(False)
		#self.USBBULK = wx.MenuItem(self.debug_menu, self.ID_USBBULK, _("USB Bulk"), "", wx.ITEM_CHECK)
		#self.debug_menu.AppendItem(self.USBBULK)
		#self.USBBULK.Enable(False)
		#self.CDC = wx.MenuItem(self.debug_menu, self.ID_CDC, _("CDC (Serial Emulation)"), "", wx.ITEM_CHECK)
		#self.debug_menu.AppendItem(self.CDC)
		#self.CDC.Enable(False)
		#self.pref_menu.AppendMenu(self.ID_DEBUG, _("Debug"), self.debug_menu)
		self.menu.Append(self.pref_menu, _("Preferences"))

		# --- board submenu
		self.board_menu=wx.Menu()
		self.board_menu.AppendRadioItem(ID_GENERIC2550,"Generic 18F2550",_("your board"))
		self.board_menu.AppendRadioItem(ID_GENERIC4550,"Generic 18F4550",_("your board"))
		self.board_menu.AppendRadioItem(ID_OLIMEX440,"OLIMEX 440",_("your board"))
		self.board_menu.AppendRadioItem(ID_EMPEROR460,"EMPEROR 460",_("your board"))
		self.board_menu.AppendRadioItem(ID_EMPEROR795,"EMPEROR 795",_("your board"))
		self.board_menu.AppendRadioItem(ID_UBW460,"UBW32 460",_("your board"))
		self.board_menu.AppendRadioItem(ID_UBW795,"UBW32 795",_("your board"))
		self.pref_menu.AppendMenu(self.ID_BOARD,_("Board"),self.board_menu)
		# mark current board
		bid = self.config.ReadInt('board',-1)
		self.board_menu.Check(bid, True)
		#if self.config.ReadInt('board',-1)==ID_GENERIC2550:
		#	self.board_menu.Check(ID_GENERIC2550,True)
		#if self.config.ReadInt('board',-1)==ID_GENERIC4550:
		#	self.board_menu.Check(ID_GENERIC4550,True)
		#if self.config.ReadInt('board',-1)==ID_OLIMEX440:
		#	self.board_menu.Check(ID_OLIMEX440,True)
		#if self.config.ReadInt('board',-1)==ID_EMPEROR460:
		#	self.board_menu.Check(ID_EMPEROR460,True)
		#if self.config.ReadInt('board',-1)==ID_EMPEROR795:
		#	self.board_menu.Check(ID_EMPEROR795,True)
		#if self.config.ReadInt('board',-1)==ID_UBW460:
		#	self.board_menu.Check(ID_UBW460,True)
		#if self.config.ReadInt('board',-1)==ID_UBW795:
		#	self.board_menu.Check(ID_UBW795,True)
		self.OnBoard(wx.Event)
										   
		# ---theme submenu
		self.theme_menu = wx.Menu()
		self.GetTheme()
		i = 0
		for th in self.themeList:
			self.THEME.append(wx.MenuItem(self.theme_menu, self.ID_THEME1 + i, th, "", wx.ITEM_CHECK))
			self.theme_menu.AppendItem(self.THEME[i])
			i = i + 1
		self.pref_menu.AppendMenu(self.ID_THEME, _("Themes"), self.theme_menu)

		# help menu
		self.help_menu = wx.Menu()

		# ---keywords submenu
		# TODO: all keywords on more rows
		self.keyword_menu = wx.Menu()
		i = 0
		for k in self.keywordList:
			self.KEYWORD.append(wx.MenuItem(self.keyword_menu, self.ID_KEYWORD1 + i, k, "", wx.ITEM_NORMAL))
			self.keyword_menu.AppendItem(self.KEYWORD[i])
			i = i + 1
		self.help_menu.AppendMenu(self.ID_KEYWORD, _("Keywords"), self.keyword_menu)
		#self.KEYWORD = wx.MenuItem(self.help_menu, self.ID_KEYWORD, _("Keywords"), "", wx.ITEM_NORMAL)
		#self.help_menu.AppendItem(self.KEYWORD)

		self.WEBSITE = wx.MenuItem(self.help_menu, self.ID_WEBSITE, _("Website"), "", wx.ITEM_NORMAL)
		self.help_menu.AppendItem(self.WEBSITE)
		self.WIKI = wx.MenuItem(self.help_menu, self.ID_WIKI, _("Wiki"), "", wx.ITEM_NORMAL)
		self.help_menu.AppendItem(self.WIKI)
		self.FORUM = wx.MenuItem(self.help_menu, self.ID_FORUM, _("Forum"), "", wx.ITEM_NORMAL)
		self.help_menu.AppendItem(self.FORUM)
		self.BLOG = wx.MenuItem(self.help_menu, self.ID_BLOG, _("Blog"), "", wx.ITEM_NORMAL)
		self.help_menu.AppendItem(self.BLOG)									  
		self.GROUP = wx.MenuItem(self.help_menu, self.ID_GROUP, _("Group"), "", wx.ITEM_NORMAL)
		self.help_menu.AppendItem(self.GROUP) 
		self.SHOP = wx.MenuItem(self.help_menu, self.ID_SHOP, _("Shop"), "", wx.ITEM_NORMAL)
		self.help_menu.AppendItem(self.SHOP)
		self.ABOUT = wx.MenuItem(self.help_menu, self.ID_ABOUT, _("About..."), "", wx.ITEM_NORMAL)
		self.help_menu.AppendItem(self.ABOUT)												
		self.menu.Append(self.help_menu, _("Help"))
		
# ------------------------------------------------------------------------------
# Menu + Icons
# ------------------------------------------------------------------------------

		# append all menus to the menu bar
		self.SetMenuBar(self.menu)

		# load toolbar icons
		self.DrawToolbar()

# ------------------------------------------------------------------------------
# Output
# ------------------------------------------------------------------------------
		
		# create a text control
		self.logwindow = wx.TextCtrl(self, wx.ID_ANY, "", wx.DefaultPosition, outputsize,\
			style = wx.NO_BORDER|wx.TE_MULTILINE|wx.TE_READONLY )
		self.logwindow.SetBackgroundColour(wx.Colour(0, 0, 0))
		self.logwindow.SetForegroundColour(wx.Colour(255, 255, 255))
				
		# create a PaneInfo structure for output window
		self.PaneOutputInfo=wx.aui.AuiPaneInfo()
		self.PaneOutputInfo.CloseButton(False)
		self.PaneOutputInfo.MaximizeButton(True)
		self.PaneOutputInfo.MinimizeButton(True)
		self.PaneOutputInfo.Caption("Output")
		self.PaneOutputInfo.Bottom()

# ------------------------------------------------------------------------------
# Editor
# ------------------------------------------------------------------------------
		
		# create editor panel
		editorsize = (outputsize[0], framesize[1] - outputsize[1])
		self.EditorPanel = wx.Panel(self, wx.ID_ANY, wx.DefaultPosition, editorsize)
		# background with pinguino.cc colour and pinguino logo
		self.EditorPanel.SetBackgroundColour(wx.Colour(175, 200, 225))
		background = wx.Bitmap(os.path.join(THEME_DIR, 'logoX.png'), wx.BITMAP_TYPE_ANY)
		if sys.platform == 'win32':
			background.SetSize(editorsize)
		self.background = wx.StaticBitmap(self.EditorPanel, wx.ID_ANY, background)
		self.background.CentreOnParent(wx.BOTH) 
				
		# create a PaneInfo structure for editor window 
		# this Paneinfo will be switched when loading a file
		self.PaneEditorInfo=wx.aui.AuiPaneInfo()
		self.PaneEditorInfo.CloseButton(False)
		self.PaneEditorInfo.MaximizeButton(True)
		self.PaneEditorInfo.Caption(_("Editor"))
		self.PaneEditorInfo.Top()
		
# ------------------------------------------------------------------------------
# add the panes to the manager
# ------------------------------------------------------------------------------

		self._mgr.AddPane(self.toolbar, wx.aui.AuiPaneInfo().
						  Name("toolbar").Caption("Toolbar").
						  ToolbarPane().Top().Row(1).
						  LeftDockable(False).RightDockable(False))		
		self._mgr.AddPane(self.logwindow, self.PaneOutputInfo, '')
		self._mgr.AddPane(self.EditorPanel, wx.CENTER , '')
		
		self.editor = editeur.editeur(self.EditorPanel, wx.ID_ANY, self.EditorPanel.GetSize())
 
		# tell the manager to 'commit' all the changes just made
		self._mgr.Update()		
		
# ------------------------------------------------------------------------------
# Event Management
# ------------------------------------------------------------------------------

		self.Bind(wx.EVT_CLOSE, self.OnExit)
		self.Bind(wx.EVT_SIZE, self.OnResize)	 
		self.Bind(wx.aui.EVT_AUI_RENDER, self.OnRender)
		
		# file menu
		self.Bind(wx.EVT_MENU, self.OnNew, self.NEW)
		self.Bind(wx.EVT_MENU, self.OnOpen, self.OPEN)
		self.Bind(wx.EVT_MENU_RANGE, self.OnFileHistory, id=wx.ID_FILE1, id2=wx.ID_FILE9) 
		self.Bind(wx.EVT_MENU, self.OnSave, self.SAVE)
		self.Bind(wx.EVT_MENU, self.OnSaveAs, self.SAVEAS)
		self.Bind(wx.EVT_MENU, self.OnClose, self.CLOSE)
		self.Bind(wx.EVT_MENU, self.OnExit, self.EXIT)
		
		# edit menu
		self.Bind(wx.EVT_MENU, self.editor.copy, self.COPY)
		self.Bind(wx.EVT_MENU, self.editor.paste, self.PASTE)
		self.Bind(wx.EVT_MENU, self.editor.cut, self.CUT)
		self.Bind(wx.EVT_MENU, self.editor.clear, self.CLEAR)	   
		self.Bind(wx.EVT_MENU, self.editor.undo, self.UNDO)	   
		self.Bind(wx.EVT_MENU, self.editor.redo, self.REDO)
		self.Bind(wx.EVT_MENU, self.OnFind, self.FIND)			   
		self.Bind(wx.EVT_MENU, self.editor.selectall, self.SELECTALL)	 

		# pref menu
		self.Bind(wx.EVT_MENU_RANGE, self.OnTheme, id=self.ID_THEME1, id2=self.ID_THEME1 + self.themeNum)
		self.Bind(wx.EVT_MENU, self.OnDebug, id=self.ID_DEBUG)
		self.Bind(wx.EVT_MENU, self.OnBoard, id=ID_GENERIC2550)
		self.Bind(wx.EVT_MENU, self.OnBoard, id=ID_GENERIC4550)
		self.Bind(wx.EVT_MENU, self.OnBoard, id=ID_OLIMEX440)
		self.Bind(wx.EVT_MENU, self.OnBoard, id=ID_EMPEROR460)
		self.Bind(wx.EVT_MENU, self.OnBoard, id=ID_EMPEROR795)
		self.Bind(wx.EVT_MENU, self.OnBoard, id=ID_UBW460)
		self.Bind(wx.EVT_MENU, self.OnBoard, id=ID_UBW795)
		 
		# icons bar
		self.Bind(wx.EVT_TOOL, self.OnVerify, id=self.ID_VERIFY)
		self.Bind(wx.EVT_TOOL, self.OnClose, id=wx.ID_CLOSE)
		self.Bind(wx.EVT_TOOL, self.OnNew, id=wx.ID_NEW)
		self.Bind(wx.EVT_TOOL, self.OnSave, id=wx.ID_SAVE)
		self.Bind(wx.EVT_TOOL, self.OnOpen, id=wx.ID_OPEN)
		self.Bind(wx.EVT_TOOL, self.OnUpload, id=self.ID_UPLOAD)
		self.Bind(wx.EVT_TOOL, self.OnFind, id=wx.ID_FIND)
		self.Bind(wx.EVT_TOOL, self.OnExit, id=wx.ID_EXIT)
		self.Bind(wx.EVT_TOOL, self.editor.undo, id=wx.ID_UNDO)
		self.Bind(wx.EVT_TOOL, self.editor.redo, id=wx.ID_REDO)
		self.Bind(wx.EVT_TOOL, self.editor.cut, id=wx.ID_CUT)
		self.Bind(wx.EVT_TOOL, self.editor.copy, id=wx.ID_COPY)
		self.Bind(wx.EVT_TOOL, self.editor.paste, id=wx.ID_PASTE)
		self.Bind(wx.EVT_TOOL, self.editor.clear, id=wx.ID_CLEAR)
		self.Bind(wx.EVT_TOOL, self.editor.selectall, id=wx.ID_SELECTALL)

		# help menu
		self.Bind(wx.EVT_TOOL, self.OnKeyword, id=self.ID_KEYWORD1, id2=self.ID_KEYWORD1 + self.keywordNum)# keywords
		self.Bind(wx.EVT_TOOL, self.OnWeb, id=self.ID_WEBSITE)	# website
		self.Bind(wx.EVT_TOOL, self.OnWeb, id=self.ID_BLOG)		# blog   
		self.Bind(wx.EVT_TOOL, self.OnWeb, id=self.ID_FORUM)	   # forum
		self.Bind(wx.EVT_TOOL, self.OnWeb, id=self.ID_GROUP)	   # group		
		self.Bind(wx.EVT_TOOL, self.OnWeb, id=self.ID_WIKI)		# wiki
		self.Bind(wx.EVT_TOOL, self.OnWeb, id=self.ID_SHOP)		# shop
		self.Bind(wx.EVT_MENU, self.OnAbout, id=self.ID_ABOUT)	# about
			   
		# initialize all the lib pdl in /lib folder
		# self.readlib() allready called by OnBoard
	
		self.displaymsg(self.translate("Welcome to Pinguino IDE ") + pinguino_version + "\n", 0);

		# check current theme in menu
		id = self.theme_menu.FindItem(self.theme)
		self.menu.Check(id, True)

# ------------------------------------------------------------------------------
# Thread
# ------------------------------------------------------------------------------

	def dthread(self):
		while self.debug_flag is True:
			if self.debug_handle:
				print ">>>debug:"	
				print self.debug_handle.readline()
			time.sleep(0.01)

	# create the debug thread			
	debug_thread = threading.Thread(target=dthread)

# ------------------------------------------------------------------------------
# OnDebug
# ------------------------------------------------------------------------------

	def OnDebug(self, event):
		# mode Debug ?
		if self.pref_menu.IsChecked(self.ID_DEBUG):
			# try to open serial port
			try:
				self.debug_handle = serial.Serial(self.debug_port)
			except:
				pass
			# is a device connected ?
			if self.debug_handle:
				# let's start our thread
				self.debug_flag = True
				self.debug_thread.start()
		else:
			# stop the thread
			self.debug_flag = False
			if self.debug_thread:
				self.debug_thread.join()
			if self.debug_handle:
				self.debug_handle.close()

# ------------------------------------------------------------------------------
# OnKeyword
# ------------------------------------------------------------------------------

	def OnKeyword(self, event):
		# get selected only
		kid = event.GetId() - self.ID_KEYWORD1
		webbrowser.open("http://wiki.pinguino.cc/index.php/"+str(self.keywordList[kid]))

# ------------------------------------------------------------------------------
# OnNew
# ------------------------------------------------------------------------------

	def OnNew(self, event):
		try:
			self.background.Destroy()
		except:
			pass 
		self.editor.New("NoName" + str(self.noname), self.reservedword, self.rw)
		self.noname+=1

# ------------------------------------------------------------------------------
# OnOpen
# ------------------------------------------------------------------------------

	def OnOpen(self, event):
		try:
			self.background.Destroy()
		except:
			pass 
		self.editor.OpenDialog("Pde Files",\
								"pde",\
								self.reservedword,\
								self.rw,\
								self.filehistory,\
								self.config)
		
# ------------------------------------------------------------------------------
# OnFileHistory : open selected history file
# ------------------------------------------------------------------------------

	def OnFileHistory(self, event):
		try:
			self.background.Destroy()
		except:
			pass 
		fileNum = event.GetId() - wx.ID_FILE1
		path = self.filehistory.GetHistoryFile(fileNum)
		self.filehistory.AddFileToHistory(path)				  # move up the list
		self.editor.Open(path,self.reservedword,self.rw, self.filehistory, self.config)
		# refresh file menu (doesn't seem to work)
		self.file_menu.UpdateUI()

# ------------------------------------------------------------------------------
# OnSave : Save current file
# ------------------------------------------------------------------------------

	def OnSave(self, event): 
		self.editor.SaveDirect()

# ------------------------------------------------------------------------------
# OnSaveAs : Save current File as ...
# ------------------------------------------------------------------------------

	def OnSaveAs(self, event): 
		self.editor.Save("Pde Files","pde")

# ------------------------------------------------------------------------------
# OnClose : Close Editor Window
# ------------------------------------------------------------------------------

	def OnClose(self, event): 
		self.editor.Close()
		
# ------------------------------------------------------------------------------
# OnExit : Save Settings and Exit Program
# ------------------------------------------------------------------------------

	def OnExit(self, event):
		try:
			self.pinguino.close()
			fclose(self.debug_handle)
		except:
			pass		
		# ---save settings-----------------------------------------------
		#if not self.IsIconized() and not self.IsMaximized():
		w, h = self.GetSize()
		self.config.WriteInt('Window/Width', w)
		self.config.WriteInt('Window/Height', h)
		x, y = self.GetPosition()
		self.config.WriteInt('Window/Posx', x)
		self.config.WriteInt('Window/Posy', y)

		w, h = self.logwindow.GetSize()
		self.config.WriteInt('Output/Width', w)
		self.config.WriteInt('Output/Height', h)

		self.config.Write('Theme/name', self.theme)

		if self.board_menu.IsChecked(ID_GENERIC2550):
			self.config.WriteInt('board', ID_GENERIC2550)
		if self.board_menu.IsChecked(ID_GENERIC4550):
			self.config.WriteInt('board', ID_GENERIC4550)
		if self.board_menu.IsChecked(ID_OLIMEX440):
			self.config.WriteInt('board', ID_OLIMEX440)
		if self.board_menu.IsChecked(ID_EMPEROR460):
			self.config.WriteInt('board', ID_EMPEROR460)
		if self.board_menu.IsChecked(ID_UBW460):
			self.config.WriteInt('board', ID_UBW460)
		if self.board_menu.IsChecked(ID_UBW795):
			self.config.WriteInt('board', ID_UBW795)
		if self.board_menu.IsChecked(ID_EMPEROR795):
			self.config.WriteInt('board', ID_EMPEROR795)

		if self.pref_menu.IsChecked(self.ID_DEBUG):
			self.config.WriteInt('debug', True)
		else:
			self.config.WriteInt('debug', False)

		self.config.Flush()

		# ----------------------------------------------------------------------
		# deinitialize the frame manager
		self._mgr.UnInit()
		# delete the frame
		self.Destroy()
		sys.exit(0)
		
# ------------------------------------------------------------------------------
# GetTheme : get all the theme (directory) name
# ------------------------------------------------------------------------------

	def GetTheme(self):
		self.themeList = [f for f in os.listdir(THEME_DIR)
			if os.path.isdir(os.path.join(THEME_DIR, f))]
		self.themeNum = len(self.themeList)

# ------------------------------------------------------------------------------
# OnTheme : delete current theme and load a new one
# ------------------------------------------------------------------------------

	def OnTheme(self, event):
		# uncheck all
		for f in self.themeList:
			id = self.theme_menu.FindItem(f)
			self.menu.Check(id, False)
		# check selected only
		curid = event.GetId()
		themeNum = curid - self.ID_THEME1
		self.menu.Check(curid, True)
		self.theme = self.themeList[themeNum]
		self.DrawToolbar()

# ------------------------------------------------------------------------------
# OnBoard : load boards specificities
# ------------------------------------------------------------------------------

	def OnBoard(self,event):
		for b in range(len(boardlist)):
			clef = ID_GENERIC2550 + b
			if self.board_menu.IsChecked(clef):
				self.arch			= boardlist[clef]['arch']
				self.proc			= boardlist[clef]['proc']
				self.board			= boardlist[clef]['board']
				self.totalspace	= boardlist[clef]['totalspace']
		# clear all the lists before rebuild them
		del self.rw[:]
		del self.regobject[:]
		del self.keywordList[:]
		del self.reservedword[:]
		del self.libinstructions[:]
		self.readlib()

# ------------------------------------------------------------------------------
# OnRender:
# ------------------------------------------------------------------------------

	def OnRender(self,event):
		self.OnResize(event)
		event.Skip()
		
# ------------------------------------------------------------------------------
# OnResize:
# ------------------------------------------------------------------------------

	def OnResize(self,event):
		try:
			self.background.CentreOnParent(wx.BOTH)
		except:
			pass		
		self.editor.Resize()
		self._mgr.Update	   
		event.Skip()

# ------------------------------------------------------------------------------
# OnAbout:
# ------------------------------------------------------------------------------

	def OnAbout(self,event):
		description = """Pinguino is an Open Software and Open Hardware Arduino-like project. Boards are based on 8 or 32-bit USB built-in Microchip microcontrollers. The main goal is to build a real USB system without USB to serial converter.
		"""

		licence = """Pinguino is free software; you can redistribute it and/or modify it 
		under the terms of the GNU General Public License as published by the Free Software Foundation; 
		either version 2 of the License, or (at your option) any later version.

		Pinguino is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
		See the GNU General Public License for more details. You should have received a copy of 
		the GNU General Public License along with File Hunter; if not, write to 
		the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA"""


		info = wx.AboutDialogInfo()

		info.SetIcon(wx.Icon(os.path.join(THEME_DIR, 'logoX.png'), wx.BITMAP_TYPE_PNG))
		info.SetName('Pinguino')
		info.SetVersion(pinguino_version)
		info.SetDescription(description)
		info.SetCopyright('2008, 2009, 2010, 2011 jean-pierre mandon')
		info.SetWebSite('http://www.pinguino.cc')
		info.SetLicence(licence)

		info.AddDeveloper('Jean-Pierre Mandon')
		info.AddDeveloper('Régis Blanchot')
		info.AddDeveloper('Marcus Fazzi')
		info.AddDeveloper('Jesús Carmona Esteban')		
		info.AddDeveloper('Ivan Ricondo')
		info.AddDeveloper('Joan Espinoza')

		info.AddDocWriter('Benoit Espinola')
		info.AddDocWriter('Sebastien Koechlin')
		info.AddDocWriter('Ivan Ricondo')
		info.AddDocWriter('Jesús Carmona Esteban')
		info.AddDocWriter('Marcus Fazzi')
		info.AddDocWriter('Régis Blanchot')

		info.AddArtist('France Cadet')
		info.AddArtist('Laurent Costes')

		info.AddTranslator('Joan Espinoza Spanish, Portuguese')
		info.AddTranslator('Marin Purgar Croatian')
		info.AddTranslator('Wim Heirman Dutch')
		info.AddTranslator('Vasile Guta Ciucur Romanian')

		wx.AboutBox(info)  
			
# ------------------------------------------------------------------------------
# OnVerify:
# ------------------------------------------------------------------------------

	def OnVerify(self, event):
		global lang
		t0 = time.time()
		if self.editor.GetPath()==-1:
			dlg = wx.MessageDialog(self,
				self.translate('Open file first !!'),
				self.translate('Warning'),
				wx.OK | wx.ICON_WARNING)
			result=dlg.ShowModal()
			dlg.Destroy()		   
			return
		self.displaymsg("Board:\t" + self.board + "\n", 1)
		self.displaymsg("Proc: \t" + self.proc  + "\n", 0)
		self.editor.SaveDirect()
		filename=self.editor.GetPath()
		filename,extension=os.path.splitext(filename)
		if os.path.exists(filename+".hex"):
			os.remove(filename+".hex")
		if os.path.exists(os.path.join(SOURCE_DIR, "user.c")):
			os.remove(os.path.join(SOURCE_DIR, "user.c"))
		retour=self.preprocess(filename, self.proc)
		if retour=="error":
			return
		# compilation
		if self.arch==8:
			MAIN_FILE="main.hex"
		else:
			MAIN_FILE="main32.hex"
		retour=self.compile(filename, self.proc, self.arch)
		if retour!=0:
			self.displaymsg(self.translate("error while compiling file ")+filename,0)
		else:
			retour=self.link(filename, self.board, self.proc, self.arch)
			if os.path.exists(os.path.join(SOURCE_DIR, MAIN_FILE))!=True:
				self.displaymsg(self.translate("error while linking")+" "+filename+".o",0)
			else:
				#self.cp(SOURCE_DIR + MAIN_FILE,filename+".hex")
				shutil.copy(os.path.join(SOURCE_DIR, MAIN_FILE), filename+".hex")
				self.displaymsg(self.translate("compilation done")+"\n",0)
				self.displaymsg(self.getCodeSize(filename, self.arch, self.totalspace)+"\n",0)
				self.displaymsg(str(time.time() - t0) + " seconds process time\n",0)
				os.remove(os.path.join(SOURCE_DIR, MAIN_FILE))
				os.remove(filename+".c")
							   
# ------------------------------------------------------------------------------
# OnUpload:
# ------------------------------------------------------------------------------

	def OnUpload(self, event):
		if self.editor.GetPath()!=-1:
			filename=self.editor.GetPath()
			filename,extension=os.path.splitext(filename)
			if os.path.exists(filename+".hex"):
				self.displaymsg("",1)
				fichier = open(os.path.join(TEMP_DIR, 'stdout'), 'w+')
				if self.arch == 8:
					if sys.platform == 'win32':
						sys.argv = ["vascoboot1.3.py",filename+".hex"]
						execfile(os.path.join(HOME_DIR, self.osdir, 'p8', 'bin', 'vascoboot1.3.py'))
					else:
						sortie=Popen([os.path.join(HOME_DIR, self.osdir, 'p8', 'bin', 'docker'),
									"-v",
									"04d8",
									"write",
									filename+".hex"],
									stdout=fichier,stderr=STDOUT)
				else:
					sortie=Popen([os.path.join(HOME_DIR, self.osdir, 'p32', 'bin', self.u32),
								"-w",
								filename+".hex",
								"-r",
								"-n"],
								stdout=fichier, stderr=STDOUT)
				sortie.communicate()
				fichier.seek(0)
				self.displaymsg(fichier.read(),0)
				fichier.close()									  
			else:
				dlg = wx.MessageDialog(self,
						self.translate('File must be verified before upload'),
						self.translate('Warning!'),
						wx.OK | wx.ICON_WARNING)
				result=dlg.ShowModal()
				dlg.Destroy()					 
		else:
			dlg = wx.MessageDialog(self,
					self.translate('File must be saved before upload'),
					self.translate('Warning!'),
					wx.OK | wx.ICON_WARNING)
			result=dlg.ShowModal()
			dlg.Destroy()		   
		event.Skip()

# ------------------------------------------------------------------------------
# OnFind:
# ------------------------------------------------------------------------------

	def OnFind(self,event):
		self.PaneFindInfo=wx.aui.AuiPaneInfo()
		self.PaneFindInfo.CloseButton(False)
		self.PaneFindInfo.MaximizeButton(False)
		self.PaneFindInfo.Caption(self.translate("Find"))
		self.PaneFindInfo.CaptionVisible(False)
		self.PaneFindInfo.Dockable(False)
		self.PaneFindInfo.Resizable(False)
		self.PaneFindInfo.Movable(False)
		self.PaneFindInfo.RightDockable(False)
		self.PaneFindInfo.LeftDockable(False)
		self.PaneFindInfo.Top()	   
		findpanelsize=(self.GetSize()[0],35)
		self.FindPanel = wx.Panel(self,size=findpanelsize)
		self._mgr.AddPane(self.FindPanel,self.PaneFindInfo)
		self._mgr.Update()
		self.FindText=wx.TextCtrl(self.FindPanel,size=(160,25),pos=(20,4))
		self.FindPrevious=wx.Button(self.FindPanel,size=(90,25),label="Previous",pos=(210,5))
		self.FindNext=wx.Button(self.FindPanel,size=(90,25),label="Next",pos=(320,5))
		self.Bind(wx.EVT_BUTTON, self.findnext, self.FindNext)  
		self.Bind(wx.EVT_BUTTON, self.findprev, self.FindPrevious)			   
		self.FindText.SetFocus()	   
		self._mgr.Update()		
		event.Skip()

	def findprev(self,event):
		chaine=self.FindText.GetString(0,self.FindText.GetLastPosition())
		trouve=self.editor.find(chaine,0)
		if trouve!=-1:
			self.editor.highlightline(trouve,'yellow')
			self.editor.focus()
		event.Skip()	
		
	def findnext(self,event):
		chaine=self.FindText.GetString(0,self.FindText.GetLastPosition())
		trouve=self.editor.find(chaine,1)
		if trouve!=-1:
			self.editor.highlightline(trouve,'yellow')
			self.editor.focus()
		event.Skip() 
		
# ------------------------------------------------------------------------------
# TODO : OnReplace:
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OnWeb: Open Web page
# ------------------------------------------------------------------------------

	def OnWeb(self,event):
		id=event.GetId()
		if id==self.ID_WEBSITE:
			webbrowser.open("http://www.pinguino.cc")
		if id==self.ID_WIKI:
			webbrowser.open("http://wiki.pinguino.cc")
		if id==self.ID_FORUM:
			webbrowser.open("http://forum.pinguino.cc")
		if id==self.ID_BLOG:
			webbrowser.open("http://blog.pinguino.cc")
		if id==self.ID_SHOP:
			webbrowser.open("http://shop.pinguino.cc")
		if id==self.ID_GROUP:
			webbrowser.open("http://groups.google.fr/group/pinguinocard?pli=1")
		
# ------------------------------------------------------------------------------
# Draw toolbar icons
# ------------------------------------------------------------------------------

	def DrawToolbar(self):
		try:
			# Deletes all the tools in the current toolbar
			self.toolbar.ClearTools()
		except:
			# Create toolbar
			self.toolbar = wx.ToolBar(self, -1, wx.DefaultPosition, wx.DefaultSize, wx.TB_FLAT | wx.TB_NODIVIDER)
			pass 
		# Get size of new theme's icons
		icon = wx.Bitmap(os.path.join(THEME_DIR, self.theme, "new.png"), wx.BITMAP_TYPE_ANY)
		iconSize = icon.GetSize()
		# Update Bitmap size to fit new icons (not sure that it works !)
		self.toolbar.SetToolBitmapSize(iconSize)
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "new.png"))!=False):
			self.toolbar.AddLabelTool(wx.ID_NEW, "&New", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "new.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "New File", "")
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "open.png"))!=False):			
			self.toolbar.AddLabelTool(wx.ID_OPEN, "&Open", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "open.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Open File", "")
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "save.png"))!=False):			
			self.toolbar.AddLabelTool(wx.ID_SAVE, "&Save", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "save.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Save File", "")
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "stop.png"))!=False):			
			self.toolbar.AddLabelTool(wx.ID_CLOSE, "&Close", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "stop.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Close File", "")
		self.toolbar.AddSeparator()
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "undo.png"))!=False):		
			self.toolbar.AddLabelTool(wx.ID_UNDO, "&Undo", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "undo.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Undo", "")
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "redo.png"))!=False):
			self.toolbar.AddLabelTool(wx.ID_REDO, "&Redo", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "redo.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Redo", "")
		self.toolbar.AddSeparator()
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "cut.png"))!=False):		
			self.toolbar.AddLabelTool(wx.ID_CUT, "&Cut", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "cut.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Cut", "")
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "copy.png"))!=False):
			self.toolbar.AddLabelTool(wx.ID_COPY, "&Copy", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "copy.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Copy", "")
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "paste.png"))!=False):		
			self.toolbar.AddLabelTool(wx.ID_PASTE, "&Paste", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "paste.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Paste", "")
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "clear.png"))!=False):
			self.toolbar.AddLabelTool(wx.ID_CLEAR, "&Clear", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "clear.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Clear", "")
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "select.png"))!=False):
			self.toolbar.AddLabelTool(wx.ID_SELECTALL, "&Select all", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "select.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Select all", "")
		self.toolbar.AddSeparator()
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "find.png"))!=False):
			self.toolbar.AddLabelTool(wx.ID_FIND, "&Find", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "find.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Search in File", "")
		self.toolbar.AddSeparator()
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "runw.png"))!=False):
			self.toolbar.AddLabelTool(self.ID_VERIFY, "&Verify", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "runw.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Compile", "")
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "dwn.png"))!=False):
			self.toolbar.AddLabelTool(self.ID_UPLOAD, "&Upload", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "dwn.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Upload to Pinguino", "")				   
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "debug.png"))!=False):
			self.toolbar.AddLabelTool(self.ID_DEBUG, "&Debug On/Off", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "debug.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_CHECK, "USB Connexion with Pinguino", "")				   
		self.toolbar.AddSeparator()
		if (os.path.exists(os.path.join(THEME_DIR, self.theme, "exit.png"))!=False):		
			self.toolbar.AddLabelTool(wx.ID_EXIT, "&Exit", wx.Bitmap(os.path.join(THEME_DIR, self.theme, "exit.png"), wx.BITMAP_TYPE_ANY), wx.NullBitmap, wx.ITEM_NORMAL, "Exit Pinguino IDE", "")

		self.toolbar.Realize()		 
							  
# ------------------------------------------------------------------------------
# readlib:
# ------------------------------------------------------------------------------

	def readlib(self):
		# trying to find PDL files to store reserved words
		if self.arch == 8:
			libext='.pdl'
			libdir=P8_DIR
		else:
			libext='.pdl32'		
			libdir=P32_DIR
		for i in os.listdir(os.path.join(libdir, 'lib')):
			filename,extension=os.path.splitext(i)
			if extension==libext:
				# check content of the PDL file
				libfile=open(os.path.join(libdir, 'lib', i),'r')
				for line in libfile:
					if line!="\n":
						# arduino's instruction
						instruction=line[0:line.find(" ")]
						self.keywordList.append(instruction)
						# library's instruction
						cnvinstruction=line[line.find(" ")+1:line.find("#")]
						# path to library
						libpath=line[line.find("#")+1:len(line)]
						# append to the list	
						self.libinstructions.append([instruction,cnvinstruction,libpath])
						#regex = re.compile(r"(^|[' ']|['=']|['{']|[',']|[\t]|['(']|['!'])"+str(instruction))+"[ ]*\(")
						#regex = re.compile(r"(^|[' ']|['=']|['{']|[',']|[\t]|['(']|['!'])"+str(instruction)+r"([' ']|['=']|['}']|[',']|[';']|[\t]|[')'].*)")
						#regex = re.compile(r"(^|[' ']|['=']|['{']|[',']|[\t]|['(']|['!'])"+str(instruction)+".*")
						#regex = re.compile(r'\W%s\W' % re.escape(str(instruction)))
						regex = re.compile(r"(^|[' ']|['=']|['{']|[',']|[\t]|['(']|['!'])%s\W" % re.escape(str(instruction)))
						self.regobject.append(regex)
				libfile.close()
		# clean up the keyword list
		self.keywordList.sort()
		self.keywordList = self.ClearRedundancy(self.keywordList)
		self.keywordNum = len(self.keywordList)
		# make reserved words list
		if len(self.libinstructions)!=0:	
			for i in range(len(self.libinstructions)):
				chaine=self.libinstructions[i][0]
				self.rw.append(chaine)
				pos = chaine.find(".")
				if pos != -1:
					self.reservedword.append(chaine[0:pos])
					self.reservedword.append(chaine[pos+1:len(chaine)])
				else:
					self.reservedword.append(chaine)
			# sort keywords for short key help
			self.rw.sort(key=lambda x: x.lower())
		# adding fixed reserved word
		fixed_rw=("setup","loop","HIGH","LOW","INPUT","OUTPUT","void","FOSC","MIPS","ON","OFF","TRUE","FALSE")
		for i in range(len(fixed_rw)):
			self.reservedword.append(fixed_rw[i])

# ------------------------------------------------------------------------------
# ClearRedundancy:
# ------------------------------------------------------------------------------

	def ClearRedundancy(self, myList):
		seen = set()
		out = []
		for item in myList:
			if item not in seen:
				seen.add(item)
				out.append(item)
		return out

# ------------------------------------------------------------------------------
# displaymsg
# ------------------------------------------------------------------------------

	def displaymsg(self, message, clearpanel):
		""" display message in the log window """
		if gui==True:
			if clearpanel==1:
				self.logwindow.Clear()
			self.logwindow.WriteText(message)
		else:
			if message!="":
				print message
		return  

# ------------------------------------------------------------------------------
# translate
# ------------------------------------------------------------------------------

	def translate(self, message):
		""" translate message using gettext according current OS """
		# Checking if the host platform is a mac
		if sys.platform == 'darwin':
			return message
		else:
			# assume it's a posix or win32 platform
			return self.lang.ugettext(message)

# ------------------------------------------------------------------------------
# preprocess
# ------------------------------------------------------------------------------

	def preprocess(self, filename, proc):
		defineword={}
		index=0
		fileline={}

		# delete old define.h and create a new one
		if os.path.exists(os.path.join(TEMP_DIR, 'define.h')):
			os.remove(os.path.join(TEMP_DIR, 'define.h'))
		fichier=open(os.path.join(TEMP_DIR, 'define.h'), 'a')
		fichier.close()

		# prepare file	  
		path,name = os.path.split(filename)
		shutil.copy(filename + '.pde', os.path.join(TEMP_DIR, 'temp.c'))
		fichier = open(os.path.join(TEMP_DIR, 'temp.c'), 'a')
		#fichier.writelines("\n")
		fichier.close()
		
		# check some processors
		if proc=="18f4550":
			self.adddefine("#define PIC18F4550")

		# check include
		fichier = open(os.path.join(TEMP_DIR, 'temp.c'), 'r')
		i=0
		for line in fichier:
			if line.find("#include")!=-1:
				self.adddefine(line)
				fileline[i]="\r\n";		
				i=i+1
			else:
				fileline[i]=line
				i=i+1
		fichier.close()
		
		# rewrite file
		fichier = open(os.path.join(TEMP_DIR, 'temp.c'), 'w')
		for cpt in range(i):
			fichier.write(fileline[cpt])
		fichier.close()
		
		#--------------------------------------------------------------

		# research and replace arduino keywords in file
	
		fichier = open(os.path.join(TEMP_DIR, 'temp.c'), 'r')
		nblines = 0
		for line in fichier:
			resultline = self.replaceword(line)
			if resultline.find("error")==1:
				line = resultline
				print "error " + resultline
				self.displaymsg("error "+resultline,1)
				return "error"
			fileline[nblines] = resultline
			nblines += 1	  
		fichier.close()
		# save new tmp file
		fichier = open(os.path.join(TEMP_DIR, 'temp.c'), 'w')
		for i in range(0,nblines):
			fichier.writelines(fileline[i])
		fichier.writelines("\r\n")
		fichier.close()

		#--------------------------------------------------------------
		
		# sort define.h
		fichier = open(os.path.join(TEMP_DIR, 'define.h'), "r")
		lignes = fichier.readlines()
		#lignes.remove('\n')
		#lignes.remove('#\n')
		lignes.sort()
		#print lignes
		fichier.close()
		# save sorted lines
		fichier = open(os.path.join(TEMP_DIR, 'define.h'), "w")
		fichier.writelines(lignes)
		fichier.close()

		#copy tmp file to file directory
		shutil.copy(os.path.join(TEMP_DIR, 'temp.c'), filename + '.c')
		shutil.copy(os.path.join(TEMP_DIR, 'temp.c'), os.path.join(SOURCE_DIR, 'user.c'))

		return
		
# ------------------------------------------------------------------------------
# adddefine
# ------------------------------------------------------------------------------

	def adddefine(self,chaine):
		""" add #define in define.h file """
		fichier = open(os.path.join(TEMP_DIR, 'define.h'), 'a')
		fichier.writelines(chaine+"\n")
		fichier.close()

# ------------------------------------------------------------------------------
# notindefine
# ------------------------------------------------------------------------------

	def notindefine(self,chaine):
		""" verify if #define exists in define.h file """
		fichier = open(os.path.join(TEMP_DIR, 'define.h'), 'r') 
		for line in fichier:
			if line.find(chaine)!=-1:
				fichier.close()
				return(0)
		fichier.close()
		return(1)		 

# ------------------------------------------------------------------------------
# replaceword
# ------------------------------------------------------------------------------

	def replaceword(self,ligne):
		""" convert pinguino language in C language """
		#instruction = ""
		line = ligne

		# search comment line 'cause there's no need to process it
		ligne = ligne.replace(" ","")			# delete space
		ligne = ligne.replace(chr(9),"")		# delete tab
		if ligne[0:2] == "//":
			ligne = "//\r\n"
			return ligne

		# remove end line comment
		if line.find("//")!=-1:
			line = line[0:line.find("/")]
			line = line + "\r\n"

		# replace pinguino language
		for i in range(len(self.libinstructions)):
			if re.search(self.regobject[i], line):
				line = line.replace(str(self.libinstructions[i][0]), str(self.libinstructions[i][1]))
				if self.notindefine("#"+str(self.libinstructions[i][2])) == 1:
					self.adddefine("#"+str(self.libinstructions[i][2]))
		return line
		
# ------------------------------------------------------------------------------
# compile
# ------------------------------------------------------------------------------

	def compile(self, filename, proc, arch):
		if (self.debug_output == 1):
			print("compile " + proc)
		else:
			if arch==8:
				fichier = open(os.path.join(SOURCE_DIR, 'stdout'), 'w+')
				sortie = Popen([os.path.join(HOME_DIR, self.osdir, 'p8', 'bin', self.c8),\
						"-mpic16",\
						"--denable-peeps",\
						"--obanksel=9",\
						"--opt-code-size",\
						"--optimize-cmp",\
						"--optimize-df",\
						"-p" + proc,\
						"-I" + os.path.join(P8_DIR, 'include'),\
						"-I" + os.path.join(P8_DIR, 'share', 'sdcc', 'include', 'pic16'),\
						"-I" + os.path.dirname(filename),\
						"--compile-only",\
						"-o" + os.path.join(SOURCE_DIR, 'main.o'),\
						os.path.join(SOURCE_DIR, 'main.c')],\
						stdout=fichier, stderr=STDOUT)
				sortie.communicate()
				if sortie.poll()!=0:
					fichier.seek(0)
					self.displaymsg(fichier.read(), 0)
				fichier.seek(0)
				line=fichier.readline()
				if line.find("error")!=-1:
					number=line[line.find(":")+1:line.find("error")-2]
					#self.editor.highlightline(int(number)-1,'pink')
					self.displaymsg("error line " + number + "\n", 1)
					self.displaymsg(line[line.find("error")+7:len(line)],0)
				fichier.close()
				return sortie.poll()
			else:
				return 0

# ------------------------------------------------------------------------------
# link
# ------------------------------------------------------------------------------

	def link(self, filename, board, proc, arch):
		if (self.debug_output==1):
			print("link " + proc)
		else:
			fichier = open(os.path.join(SOURCE_DIR, 'stdout'), 'w+')
			if arch==8:
				sortie=Popen([os.path.join(HOME_DIR, self.osdir, 'p8', 'bin', self.c8),\
						"-o" + os.path.join(SOURCE_DIR, 'main.hex'),\
						"--denable-peeps",\
						"--obanksel=9",\
						"--opt-code-size",\
						"--optimize-cmp",\
						"--optimize-df",\
						"--no-crt",\
						"-Wl-s" + os.path.join(P8_DIR, 'lkr', proc + '.lkr') + ",-m",\
						"-mpic16",\
						"-p" + proc,\
						"-L" + os.path.join(P8_DIR, 'share', 'sdcc', 'lib', 'pic16'),\
						"-I" + os.path.join(P8_DIR, 'share', 'sdcc', 'include', 'pic16'),\
						"-l" + os.path.join(P8_DIR, 'lib', 'libpuf.lib'),\
						'-llibio' + proc + '.lib',\
						"-l" + os.path.join(P8_DIR, 'share', 'sdcc', 'lib', 'pic16', 'libc18f.lib'),\
						"-l" + os.path.join(P8_DIR, 'share', 'sdcc', 'lib', 'pic16', 'libm18f.lib'),\
						"-l" + os.path.join(P8_DIR, 'share', 'sdcc', 'lib', 'pic16', 'libsdcc.lib'),\
						os.path.join(P8_DIR, 'obj', 'application_iface.o'),\
						os.path.join(P8_DIR, 'obj', 'usb_descriptors.o'),\
						os.path.join(P8_DIR, 'obj', 'crt0ipinguino.o'),\
						os.path.join(SOURCE_DIR, 'main.o')],\
						stdout=fichier, stderr=STDOUT)
			else:
				# "PDEDIR=" + os.path.dirname(self.editor.GetPath()),\
				# can't be used with Command Line version since editor isn't used
				sortie=Popen([self.make,\
						"--makefile=" + os.path.join(SOURCE_DIR, 'Makefile.'+self.osdir),\
						"HOME=" + HOME_DIR,\
						"PDEDIR=" + os.path.dirname(filename),\
						"PROC=" + proc,\
						"BOARD=" + board],\
						stdout=fichier, stderr=STDOUT)
			sortie.communicate()
			fichier.seek(0)
			# Check if child process has terminated
			if sortie.poll()!=0:
				print fichier.read()
				self.displaymsg(fichier.read(), 0)
			fichier.close()	 
			return sortie.poll()

# ------------------------------------------------------------------------------
# getCodeSize
# ------------------------------------------------------------------------------

	def getCodeSize(self, filename, arch, totalspace):
		codesize = 0
		fichier = open(filename + ".hex", 'r')
		lines = fichier.readlines()
		for line in lines:
			# count only data record
			if line[7:9:1] == "00":
				if arch==8:
					# filter records below 0x2000 (by RASM)
					if int(line[3:7:1],16) >= int("2000", 16): 
						codesize = codesize + int(line[1:3:1], 16)
				else:
					codesize = codesize + int(line[1:3:1], 16)
		fichier.close()
		#self.displaymsg("\n" + self.translate("code size: ") + str(codesize) + " / " + str(totalspace) + " " + self.translate("bytes") + " (" + str(100*codesize/totalspace) + "% " + self.translate("used") + ")", 0)
		return "code size: " + str(codesize) + " / " + str(totalspace) + " bytes" + " (" + str(100*codesize/totalspace) + "% used)"

# ------------------------------------------------------------------------------
# getOptions
# ------------------------------------------------------------------------------

def getOptions():
	parser = argparse.ArgumentParser(description='*** Pinguino IDE ***')
	parser.add_argument('-v', '--version', dest='version', action='store_true', default=False, help='show Pinguino IDE version and exit')
	parser.add_argument('-a', '--author', dest='author', action='store_true', default=False, help='show authors of this Pinguino IDE version and exit')
	parser.add_argument('-f', '--filename', dest='filename', nargs=1, default=False, help='filename to process')
	for b in range(len(boardlist)):
		clef = ID_GENERIC2550 + b
		parser.add_argument(	boardlist[clef]['shortarg'],
									boardlist[clef]['longarg'],
									dest='board',
									const=clef,
									action='store_const',
									default=False,
									help='compile code for ' + boardlist[clef]['board'] + ' board')
	return parser.parse_args()

# ------------------------------------------------------------------------------
# MAIN
# ------------------------------------------------------------------------------

if __name__ == "__main__":
	app = wx.PySimpleApp(0)

# ------------------------------------------------------------------------------
# ---Command Line---------------------------------------------------------------
# ------------------------------------------------------------------------------

	options = getOptions()

	if options.version == True:
		print "current version is " + pinguino_version
		sys.exit(1)

	if options.author == True:
		print "jean-pierre mandon"
		print "regis blanchot"
		sys.exit(1)

	if options.board != False:
		board = boardlist[options.board]['board']
		proc =  boardlist[options.board]['proc']
		arch =  boardlist[options.board]['arch']
		memo =  boardlist[options.board]['totalspace']

		if options.filename == False:
			print "missing filename"
			sys.exit(1)
		filename=options.filename[0]
		name,extension=os.path.splitext(filename)
		if extension != ".pde":
			print "bad file extension, it should be .pde"
			sys.exit(1)

		pobject=Pinguino(None, -1, "")
		print "your board is " + board
		print "the mcu is " + proc

		print "preprocessing ..."
		retour=pobject.preprocess(name, proc)
		if retour == "error":
			print "error while preprocessing " + filename
			sys.exit(1)

		print "compiling ..."
		retour = pobject.compile(filename, proc, arch)
		if retour != 0:
			print "error while compiling file " + filename
			sys.exit(1)

		print "linking ..."
		retour=pobject.link(filename, board, proc, arch)

		if arch==8:
			MAIN_FILE="main.hex"
		else:
			MAIN_FILE="main32.hex"

		if os.path.exists(os.path.join(SOURCE_DIR, MAIN_FILE))!=True:
			print "error while linking "
			sys.exit(1)

		shutil.copy(os.path.join(SOURCE_DIR, MAIN_FILE), name + ".hex")
		print "compilation done"
		print pobject.getCodeSize(name, arch, memo)
		os.remove(os.path.join(SOURCE_DIR, MAIN_FILE))
		os.remove(name + ".c")	   
		sys.exit(0)

# ------------------------------------------------------------------------------
# ---Graphic User Interface-----------------------------------------------------
# ------------------------------------------------------------------------------

	wx.InitAllImageHandlers()
	gui=True
	frame_1 = Pinguino(None, -1, "")
	app.SetTopWindow(frame_1)
	frame_1.Show()
	app.MainLoop()
