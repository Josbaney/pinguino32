#!/usr/bin/env python
#-*- coding: utf-8 -*-


"""File to test features"""

#from autoCompleter import autoCompleter
##from keywords import functionsHelp
#from debugger import Debugger
#from lateral_dock import File, Documents, Search

#import sys, os, re, wx

#import  wx.lib.mixins.listctrl  as  listmix
#from ConfigParser import RawConfigParser



########################################################################
class Testing():
    """"""
    
    #----------------------------------------------------------------------
    def __initTesting__(self):
        """"""
    
    #----------------------------------------------------------------------
    def addArguments(self, funcionName):
        for func in self.allFunc:
            if func[0] in [funcionName, "*"+funcionName]:
                arg = func[3]
                self.HideNextAutoComplete()
                textEdit = self.stcpage[self.notebookEditor.GetSelection()]
                textEdit.InsertText(textEdit.CurrentPos, "("+arg+")")
                textEdit.SetSelection(textEdit.CurrentPos+1, textEdit.CurrentPos+len(arg)+1)
                return True
                break
        return False
        
    #----------------------------------------------------------------------
    def HideNextAutoComplete(self):
        self.autocompleteHide = True
        
    #----------------------------------------------------------------------
    def OnShowCompleter(self, event=None):
        word = self.wordUnderCursor(True)
        if word == " ": word = None
        self.AutoCompleter.ShowCompleter(word, -1)     
        
        
        

   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


    #----------------------------------------------------------------------
    def getPOT(self):
        main = os.path.join(os.getcwd(), "wxgui")
        PythonFiles = [os.path.join(os.getcwd(), "pinguino.py")]
        exceptions = ["argparse.py"]
        
        def getData(path):
            yy = os.listdir(path)
            for i in yy:
                if os.path.isfile(os.path.join(path, i)) and (i.endswith(".py") or i.endswith(".pyw") and not i.startswith(".")) and not i in exceptions:
                    PythonFiles.append(os.path.join(path, i))
                elif os.path.isdir(os.path.join(path, i)):
                    getData(os.path.join(path, i))
        getData(main)
        
        path = os.getcwd()
        files = " ".join(PythonFiles)
        os.system("xgettext -k_ -kN_ -o pinguino.pot %s" %files)

            
    
        #elif evt.GetMargin() in [1, 2]:
            #textEdit = self.stcpage[self.notebookEditor.GetSelection()]
            #line = textEdit.LineFromPosition(evt.Position)
            #if textEdit.MarkerGet(line) == 0:
                ##textEdit.MarkerDefine (2, wx.stc.STC_MARK_SHORTARROW, "white", "white")
                #textEdit.MarkerAdd(line, 2)
            #if textEdit.MarkerGet(line) == 4:
                ##textEdit.MarkerDefine (2, wx.stc.STC_MARK_SHORTARROW, "white", "white")
                #textEdit.MarkerAdd(line, 0)    
            
            ##print margin
            
        
        
        
        
        
        
        
        
        
        
        
        
#plug-ins ¿?
########################################################################
##                            Plug-Ins                                ##
########################################################################
    ##----------------------------------------------------------------------
    #def OnPlugIn(self, event):
        #self.notebookPlugins.Show()
        #self.notebookEditor.Reparent(self.panelEditorPlug)
        #self.moveNotebookEditor2Plugins()
        ##self.importPlugin()
        
    ##----------------------------------------------------------------------
    #def NoPlugIn(self, event):
        #self.notebookPlugins.Hide()
        #self.notebookEditor.Reparent(self.panelEditor)
        #self.moveNotebookEditor2Normal()
   
    ##----------------------------------------------------------------------
    #def moveNotebookEditor2Normal(self):
        #bSizer3 = wx.BoxSizer( wx.VERTICAL )
        #bSizer3.Add( self.notebookEditor, 1, wx.EXPAND, 5 )
        #self.panelEditor.SetSizer( bSizer3 )
        #bSizer3.Fit( self.panelEditor )
        #self.panelEditor.Fit()
        #self.updateIDE()
        
    ##----------------------------------------------------------------------
    #def moveNotebookEditor2Plugins(self):
        #bSizer2 = wx.BoxSizer( wx.VERTICAL )
        #bSizer2.Add( self.notebookPlugins, 1, wx.EXPAND, 5 )
        #self.panelEditor.SetSizer( bSizer2 )
        #bSizer2.Fit( self.panelEditor )
        #bSizer3 = wx.BoxSizer( wx.VERTICAL )
        #bSizer3.Add( self.notebookEditor, 1, wx.EXPAND, 5 )
        #self.panelEditorPlug.SetSizer( bSizer3 )
        #bSizer3.Fit( self.panelEditorPlug )        
        #self.panelEditorPlug.Fit()
        #self.panelEditor.Fit()
        #self.updateIDE()
        
    ##----------------------------------------------------------------------
    #def importPlugin(self):
        #plugins = self.get_all_modules()
        #for plugin in plugins:
            #page = plugin.PlugIN(self.notebookPlugins)
            #page.__initPlugin__()
            #self.notebookPlugins.AddPage(page, plugin.PlugIN.PluginName)
        
    ##----------------------------------------------------------------------
    #def get_all_modules(self):
        #path= os.path.join(os.getcwd(), "plugins")
        #ficheros=os.listdir(path)
        #all_modules=[]
        #for file in ficheros:
            #if file.endswith(".zip"):
                #sys.path.append(os.path.join(path, file))
                #mod = __import__(file[:-4])        
                #all_modules.append(mod)
            
            #elif os.path.isdir(os.path.join(path, file)):
                #sys.path.append(path)
                #mod = __import__(file)
                #all_modules.append(mod)
        #return all_modules     
