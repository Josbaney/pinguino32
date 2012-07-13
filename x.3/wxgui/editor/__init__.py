#!/usr/bin/env python
#-*- coding: utf-8 -*-

#from autocompleter import AutoCompleter
from debugger import Debugger
from editeur import editor
from lateral_tool_area import File, Documents, Search
from experimental import Testing
from menubar import Menubar
from general import General

from preferences import Preferences
from funtions_help import functionsHelp
from autocompleter import AutoCompleter

import locale, sys

########################################################################
class Editor(Documents, Debugger, File, Search, editor, Menubar, General, Testing):

    #----------------------------------------------------------------------
    def __initIDE__(self):
        """Constructor"""

        self.updateIDE()
        self.__initEditor__()
        #self.__initDocuments__()
        self.__initDebugger__()
        self.__initDockFile__()
        self.__initSearch__()
        self.__initTesting__()
        self.initTimers()
        
        self.lat.notebookLateral.SetSelection(0)   

        if locale.getdefaultlocale()[0][:2] == "es":
            self.wikiDoc = "http://www.pinguino.org.ve/wiki/index.php?title="
        else: self.wikiDoc = "http://wiki.pinguino.cc/index.php/"
        
        self.saveConfig()
             
      