#!/usr/bin/env python
#-*- coding: utf-8 -*-

"""-------------------------------------------------------------------------
    General methos to Pinguino IDE.

    author:		Yeison Cardona
    contact:		yeison.eng@gmail.com
    first release:	02/April/2012
    last release:	09/July/2012

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

import codecs, sys, os, re
from wxgui._trad import _


HOME_DIR    = os.getcwd()
TEMP_DIR = os.path.join(HOME_DIR, '.temp')

########################################################################
class Menubar:

    #----------------------------------------------------------------------
    def OnNew(self, event):
        self.background.Hide()
        
        #print self.filename
        
        
        file = os.path.join(TEMP_DIR, _("Newfile%d") %self.noname)
        while file + ".pde" in self.filename:
            self.noname += 1
            file = os.path.join(TEMP_DIR, _("Newfile%d") %self.noname)
            
        #self.addFile2Recent(file)
        #print file              
            
        self.New(file)
        self.noname+=1
        self.updatenotebook()

    #----------------------------------------------------------------------
    def OnOpen(self, event):
        self.background.Hide()
        wildcard = "Pde files (*.pde)|*.pde|"     \
                   "C files (*.c)|*.c|" \
                   "C Header files (*.h)|*.h|"    \
                   "All files (*.*)|*.*"
        self.OpenDialog(wildcard)
        self.updatenotebook()
        self.update_dockFiles()


    #----------------------------------------------------------------------
    def OnSave(self, event=None):
        """ Save file without dialog box """
        if len(self.onglet)>0:
            path=self.filename[self.notebookEditor.GetSelection()]
            fichier=codecs.open(path,'w','utf8')
            for i in range(0,self.stcpage[self.notebookEditor.GetSelection()].GetLineCount()):
                fichier.writelines(self.stcpage[self.notebookEditor.GetSelection()].GetLine(i))
            fichier.close()
            
            if self.notebookEditor.GetPageText(self.notebookEditor.GetSelection())[0]=="*":
                chaine=self.notebookEditor.GetPageText(self.notebookEditor.GetSelection())
                chaine=chaine[1:len(chaine)]
                self.notebookEditor.SetPageText(self.notebookEditor.GetSelection(),chaine)
            self.stcpage[self.notebookEditor.GetSelection()].SetSavePoint()
           
            self.addFile2Recent(path)
            
            
    #----------------------------------------------------------------------
    def OnSaveAll(self, event=None):
        if len(self.onglet) <= 0: return
        for i in range(len(self.filename)):
            path = self.filename[i]
            fichier=codecs.open(path,'w','utf8')
            for j in range(0,self.stcpage[i].GetLineCount()):
                fichier.writelines(self.stcpage[i].GetLine(j))
            fichier.close()
            if self.notebookEditor.GetPageText(i)[0]=="*":
                chaine=self.notebookEditor.GetPageText(i)
                chaine=chaine[1:len(chaine)]
                self.notebookEditor.SetPageText(i,chaine)
            self.stcpage[i].SetSavePoint()
            self.addFile2Recent(path)
            
        i = 0
        self.setConfig("Last", "Last_count", len(self.filename))
        for file in self.filename:
            try: file = unicode(file).encode("utf-8")
            except: pass          
            self.setConfig("Last", "Last_%d" %i, file)
            i += 1
            
        self.saveConfig()

    #----------------------------------------------------------------------
    def OnSaveAs(self, event):
        wildcard = "Pde files (*.pde)|*.pde|"     
                   #"C files (*.c)|*.c|" \
                   #"C Header files (*.h)|*.h|"    \
                   #"All files (*.*)|*.*"        
        self.Save(wildcard)

    #----------------------------------------------------------------------
    def OnClose(self, event):
        self.CloseTab()
        self.updatenotebook()
        self.update_dockFiles()
        
    #----------------------------------------------------------------------
    def OnCloseAll(self, event=None):
        while self.CloseTab():
            self.updatenotebook()
            self.update_dockFiles()

    #----------------------------------------------------------------------
    def OnCopy(self, event):
        self.stcpage[self.notebookEditor.GetSelection()].Copy()

    #----------------------------------------------------------------------
    def OnPaste(self, event):
        self.stcpage[self.notebookEditor.GetSelection()].Paste()

    #----------------------------------------------------------------------
    def OnCut(self, event):
        self.stcpage[self.notebookEditor.GetSelection()].Cut()

    #----------------------------------------------------------------------
    def OnClear(self, event):
        self.stcpage[self.notebookEditor.GetSelection()].Clear()

    #----------------------------------------------------------------------
    def OnUndo(self, event):
        self.stcpage[self.notebookEditor.GetSelection()].Undo()

    #----------------------------------------------------------------------
    def OnRedo(self, event):
        self.stcpage[self.notebookEditor.GetSelection()].Redo()

    #----------------------------------------------------------------------
    def OnSelectall(self, event):
        self.stcpage[self.notebookEditor.GetSelection()].SelectAll()

    #----------------------------------------------------------------------
    def OnComment(self, event=None):
        textEdit = self.stcpage[self.notebookEditor.GetSelection()]
        lineStart, lineEnd = map(textEdit.LineFromPosition,textEdit.GetSelection())
        countLines = lineEnd - lineStart
        posLineStart, posLineEnd = map(textEdit.PositionFromLine, [lineStart, lineEnd+1])
        textEdit.SetSelection(posLineStart, posLineEnd)
        selected = textEdit.GetSelectedText()
        selected = selected.split("\n")
        
        def getCharPos(cadena):
            pos = 0
            for i in cadena:
                if i.isspace(): pos += 1
                else: break
            return pos
        
        forComent = False
        for linea in selected:
            if not linea.isspace() and linea != "":
                pos = getCharPos(linea)
                if linea[pos:pos+2] != "//": forComent = True
            
        comented = []
        if forComent:
            for linea in selected:
                if not linea.isspace() and linea != "":
                    pos = getCharPos(linea)
                    comented.append(linea[:pos]+"//"+linea[pos:])
                else: comented.append(linea)
        else:    
            for linea in selected:
                if not linea.isspace() and linea != "":
                    pos = getCharPos(linea)
                    comented.append(linea[:pos]+linea[pos+2:])
                else: comented.append(linea)
                    
        comented = "\n".join(comented)
        textEdit.Clear()
        textEdit.InsertText(textEdit.CurrentPos, comented)
        textEdit.SetSelection(*map(textEdit.PositionFromLine, [lineStart, lineEnd]))
        
        
    #----------------------------------------------------------------------
    def OnIndent(self, event=None):
        textEdit = self.stcpage[self.notebookEditor.GetSelection()]
        lineStart, lineEnd = map(textEdit.LineFromPosition,textEdit.GetSelection())
        countLines = lineEnd - lineStart
        posLineStart, posLineEnd = map(textEdit.PositionFromLine, [lineStart, lineEnd+1])
        textEdit.SetSelection(posLineStart, posLineEnd)
        selected = textEdit.GetSelectedText()
        indentSpace = self.getIndent()
        indent = indentSpace + selected.replace("\n","\n"+indentSpace, countLines)
        textEdit.Clear()
        textEdit.InsertText(textEdit.CurrentPos, indent)
        textEdit.SetSelection(*map(textEdit.PositionFromLine, [lineStart, lineEnd]))
        
    #----------------------------------------------------------------------
    def OnUnIndent(self, event=None):
        textEdit = self.stcpage[self.notebookEditor.GetSelection()]
        lineStart, lineEnd = map(textEdit.LineFromPosition,textEdit.GetSelection())
        countLines = lineEnd - lineStart
        posLineStart, posLineEnd = map(textEdit.PositionFromLine, [lineStart, lineEnd+1])
        textEdit.SetSelection(posLineStart, posLineEnd-1)
        selected = textEdit.GetSelectedText()
        indentSpace = self.getIndent()
        if str(selected.split("\n")[0]).startswith(indentSpace):
            indent = selected.replace(indentSpace, "", 1).replace("\n"+indentSpace, "\n", countLines)
            textEdit.Clear()
            textEdit.InsertText(textEdit.CurrentPos, indent)
            textEdit.SetSelection(*map(textEdit.PositionFromLine, [lineStart, lineEnd]))
        

    #----------------------------------------------------------------------
    def OnExit(self, event):
        self.stopTimers()
        self.closing = True  #Signal for Threads

        try:
            self.pinguino.close()
            fclose(self.debug_handle)
        except: pass
        
        w, h = self.GetSize()
        self.setConfig("IDE", "Window/Width", w)
        self.setConfig("IDE", "Window/Height", h)
        
        x, y = self.GetPosition()
        self.setConfig("IDE", "Window/Xpos", x)
        self.setConfig("IDE", "Window/Ypos", y)
        
        w, h = self.logwindow.GetSize()
        self.setConfig("IDE", "Output/Width", w)
        self.setConfig("IDE", "Output/Height", h)
        
        maxim = self.IsMaximized()
        self.setConfig("IDE", "Maximized", maxim)
        
        i = 0
        self.setConfig("Recents", "Recents_count", len(self.recentsFiles))
        for file in self.recentsFiles:
            try: file = unicode(file).encode("utf-8")
            except: pass
            self.setConfig("Recents", "Recents_%d" %i, file)
            i += 1
            
        i = 0
        self.setConfig("Last", "Last_count", len(self.filename))
        for file in self.filename:
            try: file = unicode(file).encode("utf-8")
            except: pass          
            self.setConfig("Last", "Last_%d" %i, file)
            i += 1
        if self.filename != []:
            name = self.filename[self.notebookEditor.GetSelection()]
            self.setConfig("Last", "Last_Focus", name)
            
        
        self.setConfig("IDE", "Theme", self.theme)
        
        
        self.setConfig("IDE","Board", self.curBoard.name)
        
        panelOutput = "[\S]*dock_size\(3,0,0\)=([\d]*)[\S]*"
        panelLateral = "[\S]*dock_size\(2,0,0\)=([\d]*)[\S]*"
        perspectiva = self._mgr.SavePerspective()
        try: self.setConfig("IDE", "PerspectiveOutput", re.match(panelOutput, perspectiva).group(1))
        except: self.setConfig("IDE", "PerspectiveOutput", "119")
        try: self.setConfig("IDE", "PerspectiveLateral", re.match(panelLateral, perspectiva).group(1))
        except: self.setConfig("IDE", "PerspectiveLateral", "286")
        
        dir = unicode(self.parentDir).encode("utf-8")
        self.setConfig("IDE", "LateralPath", dir)
            
        self.saveConfig()

        # ----------------------------------------------------------------------
        # deinitialize the frame manager
        self._mgr.UnInit()
        # delete the frame
        self.Destroy()
        sys.exit(0)

    #----------------------------------------------------------------------
    def OnViewTools(self, event):
        pane = self._mgr.GetPane(self.lat)  # wxAuiPaneInfo
        if self.menu.menuItemTools.IsChecked():
            pane.Show()
        else:
            pane.Hide()
        self.updateIDE()

    #----------------------------------------------------------------------
    def OnViewOutput(self, event):
        pane = self._mgr.GetPane(self.panelOutput)  # wxAuiPaneInfo
        if self.menu.menuItemOutput.IsChecked():
            pane.Show()
        else:
            pane.Hide()
        self.updateIDE()

    #----------------------------------------------------------------------
    def OnViewToolbar(self, event):
        if self.menu.menuItemToolbar.IsChecked():
            self.DrawToolbar()
        else:
            self.toolbar.Destroy()
        self.updateIDE()