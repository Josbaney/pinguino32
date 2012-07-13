#!/usr/bin/env python
#-*- coding: utf-8 -*-

"""-------------------------------------------------------------------------
    Recursive wx.TreeCtrl for *.pde files.

    author:		Yeison Cardona
    contact:		yeison.eng@gmail.com 
    first release:	31/March/2012
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

import wx
import sys, os

from wxgui._trad import _

########################################################################
class Search():
    #----------------------------------------------------------------------
    def __initSearch__(self):
        self.FindText = self.lat.searchCtrlSearch
        self.ReplaceText = self.lat.searchCtrlReplace
        self.ReplaceText.SetDescriptiveText("Replace")
        self.findIndex = -1
        self.OnFind()
        
        self.Bind(wx.EVT_BUTTON, self.findnext, self.lat.buttonNext)  
        self.Bind(wx.EVT_BUTTON, self.findprev, self.lat.buttonPrev)
        self.Bind(wx.EVT_BUTTON, self.findnext, self.lat.buttonNext)  
        self.Bind(wx.EVT_BUTTON, self.findprev, self.lat.buttonPrev)
        self.Bind(wx.EVT_BUTTON, self.replacetext, self.lat.buttonReplace)  
        self.Bind(wx.EVT_BUTTON, self.replacealltext, self.lat.buttonReplaceAll)   
        self.Bind(wx.EVT_TEXT, self.updateFinds, self.FindText)
        
    #----------------------------------------------------------------------
    def updateFinds(self, event):
        print "buscandp..."
        word = self.FindText.GetValue()
        if word != "": self.highLine(word, 0, False)
        
    #---------------------------------------------------------------------- 
    def OnFind(self,event=None):
        if len(self.stcpage) > 0:
            textEdit = self.stcpage[self.notebookEditor.GetSelection()]
            sel = textEdit.GetSelectedText()
            if len(sel) > 0: self.FindText.SetValue(sel)
                
        self.lat.notebookLateral.SetSelection(2)
        self.lat.panelReplace.Hide()
        self.lat.m_staticText4.Hide()
        self.lat.searchCtrlReplace.Hide()			   
        self.FindText.SetFocus()
        self.updateIDE()		

    #----------------------------------------------------------------------
    def findprev(self,event):
        word = str(self.FindText.GetValue())
        result = self.findWord(word)
        
        if word == "" or result["count"] == 0: return False
        
        textEdit = self.stcpage[self.notebookEditor.GetSelection()]
        self.findIndex -= 1
        if self.findIndex < 0: self.findIndex = result["count"] - 1
        self.highLine(word, self.findIndex)
        
        self.lat.buttonReplace.Enable()
        self.lat.buttonReplaceAll.Enable()
        
        return True
		

    #----------------------------------------------------------------------
    def findnext(self,event):
        word = str(self.FindText.GetValue())
        result = self.findWord(word)
        
        if word == "" or result["count"] == 0: return False
        
        textEdit = self.stcpage[self.notebookEditor.GetSelection()]
        self.findIndex += 1
        if self.findIndex >= result["count"]: self.findIndex = -1
        self.highLine(word, self.findIndex)
        
        self.lat.buttonReplace.Enable()
        self.lat.buttonReplaceAll.Enable()
        
        return True

    #----------------------------------------------------------------------
    def OnReplace(self,event):
        if len(self.stcpage) > 0:
            textEdit = self.stcpage[self.notebookEditor.GetSelection()]
            sel = textEdit.GetSelectedText()
            if len(sel) > 0: self.FindText.SetValue(sel)
        self.lat.notebookLateral.SetSelection(2)        
        self.lat.panelReplace.Show()
        self.lat.m_staticText4.Show()
        self.lat.searchCtrlReplace.Show()        
        self.FindText.SetFocus()
        self.lat.buttonReplace.Disable()
        self.lat.buttonReplaceAll.Disable()
        self.updateIDE()

    #----------------------------------------------------------------------
    def replacetext(self, event=None):
        word = str(self.FindText.GetValue())
        wordReplace = str(self.ReplaceText.GetValue())
        if word == "": return False
        textEdit = self.stcpage[self.notebookEditor.GetSelection()]
        textEdit.Clear()
        textEdit.InsertText(textEdit.CurrentPos, wordReplace)
        #self.findIndex -= 1
        self.findnext(event)
        if not self.findnext(event):
            self.lat.buttonReplace.Disable()
            self.lat.buttonReplaceAll.Disable()
            return False
        return True

    #----------------------------------------------------------------------
    def replacealltext(self, event):
        textEdit = self.stcpage[self.notebookEditor.GetSelection()]
        word = str(self.FindText.GetValue())
        wordReplace = str(self.ReplaceText.GetValue())
        result = self.findWord(word)
        count = result["count"]
        
        plain = str(textEdit.GetTextUTF8())
        plain = plain.replace(word, wordReplace)
        
        pos = textEdit.CurrentPos
        
        textEdit.ClearAll()
        textEdit.AddText(plain)
        textEdit.GotoPos(pos)
        
        self.lat.searchReplaceInfo.SetLabel(_("Replaced %d matches in the file.") %count)


    #----------------------------------------------------------------------
    def findWord(self, word):
        if word == "": return 
        
        textEdit = self.stcpage[self.notebookEditor.GetSelection()]
        if self.lat.checkBox_sensitive.IsChecked():
            plain = str(textEdit.GetTextUTF8())
            word = str(word)
        else:
            plain = str(textEdit.GetTextUTF8()).lower()
            word = str(word).lower()
    
        count = plain.count(word)
        finds = [plain.find(word)]
        while finds[-1] != -1: finds.append(plain.find(word, finds[-1]+1))
        finds.pop(-1)
        
        
        result = {"word": word,
                  "count": len(finds),
                  "finds": finds,}
        
        self.lat.searchReplaceInfo.SetLabel(_("Finded %d matches in the file.") %len(finds))
        
        return result
    
    
    #----------------------------------------------------------------------
    def highLine(self, word, findIndex, focus=True):
        textEdit = self.stcpage[self.notebookEditor.GetSelection()]
        result = self.findWord(word)
        if result["count"] > 0:
            line = textEdit.LineFromPosition(result["finds"][findIndex])
            color = self.getColorConfig("Highligh", "searchreplace", [255, 250, 70])   
            self.highlightline(line, color)
            if focus: self.focus()
            textEdit.SetSelection(result["finds"][findIndex], result["finds"][findIndex]+len(word))