#! /usr/bin/python
#-*- coding: utf-8 -*-

"""-------------------------------------------------------------------------
    Access the wiki, download and show the documentation of a function.

    author:		Yeison Cardona
    contact:		yeison.eng@gmail.com 
    first release:	18/February/2012
    last release:	31/March/2012
    
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

import wx, urllib2, re, threading, webbrowser

from wx.html import HtmlWindow
#from frame import keywordFrame
#from frameKeyWords import frameKeyWords
import sys, os
import locale

########################################################################
class functionsHelp():
    #----------------------------------------------------------------------
    def __initfunctionsHelp__(self, parent, keywordList=None, keyword=None):
        self.path = os.path.join(os.getcwd(),".temp","data.html")
        #self._init_ctrls(parent)
        self.richTextKeywords.Clear()
        self.checkListKeywords.Clear()
        
        self.Bind(wx.EVT_LISTBOX_DCLICK, self.getDoc, self.listBoxKeywords)
        self.Bind(wx.EVT_CHECKLISTBOX, self.sortFunctions, self.checkListKeywords)
        self.richTextKeywords.Bind(wx.EVT_TEXT_URL, self.OnURL)
        
        self.keywordList = keywordList
        self.DictKeywordList = self.sortKeywordList()
        self.startFunctionsHelp()
            
        self.urlStyle = wx.richtext.TextAttrEx()
        self.urlStyle.SetTextColour(wx.BLUE)
        self.urlStyle.SetFontUnderlined(True)        
            
        self.titleStyle = wx.richtext.TextAttrEx()
        self.titleStyle.SetFontWeight(wx.FONTWEIGHT_BOLD)
      
        self.exampleStyle = wx.richtext.TextAttrEx()
        font = self.richTextKeywords.Font
        font.SetFaceName("Monospace")
        self.exampleStyle.SetFont(font)
        
        #Importante!!, para pasar de html a texto plano
        self.htmlWindow1 = HtmlWindow(self)
        self.htmlWindow1.Hide()
        
        self.lang = locale.getdefaultlocale()[0][:2]
        #self.lang = "en"
        
        if self.lang == "es":
            self.wikiDoc = "http://www.pinguino.org.ve/wiki/index.php?title="
            self.wikiEdit = lambda keyword:"http://www.pinguino.org.ve/wiki/index.php?title="+keyword+"&action=edit"
            self.inicio = '<h2> <span class="mw-headline" id="Descripcion"> Descripcion </span></h2>\n'
            self.inicio2 = '<h2> <span class="mw-headline" id="Descripci.C3.B3n"> Descripción </span></h2>\n'
            self.fin = '<!--'
            self.re = '<h2> <span class="mw-headline" id="(.+)"> (.+) </span></h2>\n'
            self.see = "Ver Tambien"
            self.example = "Ejemplo"

        else:
            self.wikiDoc = "http://wiki.pinguino.cc/index.php/"
            self.wikiEdit = lambda keyword:"http://wiki.pinguino.cc/index.php?title="+keyword+"&action=edit"
            self.inicio = '<a name="Name" id="Name"></a><h2> <span class="mw-headline"> Name </span></h2>\n'
            self.inicio2 = "SinCoincidencia"
            self.fin = '<!--'
            self.re = '<a name="(.+)" id="(.+)"></a><h2> <span class="mw-headline"> (.+) </span></h2>'
            self.see = "See also"
            self.example = "Example"           
        
        if keyword != None:
            if "." in keyword:
                point = keyword.find(".")
                pref = keyword[:point]
                suf = keyword[point+1:]
            else:
                pref = "Others"
                suf = keyword
                
            self.default(pref, keyword)
        
    #----------------------------------------------------------------------
    def default(self, pref, keyword):
        index = self.checkListKeywords.GetItems().index(pref)
        self.checkListKeywords.SetChecked([index])
        self.sortFunctions()
        index = self.listBoxKeywords.GetItems().index(keyword)
        self.listBoxKeywords.SetSelection(index)
        self.getDoc(keyword=keyword)        
        
    #----------------------------------------------------------------------    
    def OnURL(self, evt):
        if evt.GetString() in self.keywordList:
            self.getDoc(evt)
        else: webbrowser.open_new_tab(evt.GetString())         
          
    #----------------------------------------------------------------------
    def startFunctionsHelp(self):
        self.gridSizer3 = wx.GridSizer(cols=1, hgap=0, rows=len(self.DictKeywordList.keys()), vgap=0)
        KeywordList = self.DictKeywordList.keys()
        KeywordList.sort()
        for word in KeywordList:
            if word != "Others":
                self.checkListKeywords.Append(word)
        self.checkListKeywords.Append("Others")
        
        #self.checkListKeywords.SetSize(self.sashWindow1.Size)
        #self.listBoxKeywords.SetSize(self.sashWindow2.Size)
        #self.richTextKeywords.SetSize(self.sashWindow3.Size)
        
        self.setNormalCursor()
        
    #----------------------------------------------------------------------
    def setWaitCursor(self, event=None):
        self.checkListKeywords.SetCursor(wx.StockCursor(wx.CURSOR_WAIT))
        self.listBoxKeywords.SetCursor(wx.StockCursor(wx.CURSOR_WAIT))
        self.richTextKeywords.SetCursor(wx.StockCursor(wx.CURSOR_WAIT))
        self.Update()
        
    #----------------------------------------------------------------------
    def setNormalCursor(self):
        self.checkListKeywords.SetCursor(wx.StockCursor(wx.CURSOR_HAND))
        self.listBoxKeywords.SetCursor(wx.StockCursor(wx.CURSOR_HAND))
        self.richTextKeywords.SetCursor(wx.StockCursor(wx.CURSOR_HAND))
        self.Update()
        
    #----------------------------------------------------------------------
    def rebildSTC(self):
        #I dislike but need
        self.richTextKeywords.Destroy()
        self.richTextKeywords = wx.richtext.RichTextCtrl(id=wx.NewId(),
              parent=self.sashWindow3, pos=wx.Point(0, 0), size=self.sashWindow3.Size, style=wx.HSCROLL | wx.VSCROLL | wx.richtext.RE_MULTILINE,
              value=u' ')
        self.richTextKeywords.SetMinSize(wx.Size(-1, -1))
        self.rtc = self.richTextKeywords
        self.richTextKeywords.SetEditable(False)
        self._init_sizers()
        self.Bind(wx.EVT_CHECKLISTBOX, self.sortFunctions, self.checkListKeywords)
        self.richTextKeywords.Bind(wx.EVT_TEXT_URL, self.OnURL)
     
    #----------------------------------------------------------------------
    def getDoc(self, event=None, keyword=None):
        self.setWaitCursor()
        if event != None: keyword = event.GetString()
        self.rtc = self.richTextKeywords
        #self.rebildSTC()
        self.rtc.Clear()
        self.rtc.Newline()
        self.rtc.BeginBold()
        self.rtc.WriteText(keyword+"\n")
        self.rtc.EndBold()
        if self.getHelp(self.wikiDoc+keyword, keyword):
            self.rtc.Clear()
            self.rtc.BeginBold()
            self.rtc.WriteText("Read directly from wiki.pinguino.cc ")
            self.rtc.BeginStyle(self.urlStyle)
            self.rtc.BeginURL("http://wiki.pinguino.cc/index.php/"+keyword)
            self.rtc.WriteText(keyword)
            self.rtc.EndURL()            
            self.rtc.EndStyle()
            self.rtc.EndBold()
            
            if self.lang == "es":
                self.rtc.Newline()
                self.rtc.BeginBold()
                self.rtc.WriteText("Leer directamente desde pinguino.org.ve ")
                self.rtc.BeginStyle(self.urlStyle)
                self.rtc.BeginURL(self.wikiDoc+keyword)
                self.rtc.WriteText(keyword)
                self.rtc.EndURL()            
                self.rtc.EndStyle()
                self.rtc.EndBold()
            
            self.rtc.Newline()
            self.rtc.Newline()
            self.writeHelp(*self.htmlPage())
            #self._init_sizers()
        self.setNormalCursor()

    #----------------------------------------------------------------------
    def lineWiki(self, url, keyword):
        try: wikiPage = urllib2.urlopen(url)
        except (urllib2.HTTPError):
            self.rtc.Clear()
            self.rtc.WriteText("No documentation found.\n")
            if self.lang == "es":
                self.rtc.BeginBold()
                self.rtc.WriteText("Search in wiki.pinguino.cc ")
                self.rtc.BeginStyle(self.urlStyle)
                self.rtc.BeginURL("http://wiki.pinguino.cc/index.php/"+keyword)
                self.rtc.WriteText(keyword)
                self.rtc.EndURL()            
                self.rtc.EndStyle()
                self.rtc.EndBold()
                
            #self.rtc.WriteText("This function has not been documented.\n")
            #self.rtc.WriteText("You can help with the documentation on the following link.\n")
            #self.rtc.BeginStyle(self.urlStyle)
            #self.rtc.BeginURL(self.wikiEdit(keyword))
            #self.rtc.WriteText(keyword)
            #self.rtc.EndURL()
            #self.rtc.EndStyle()   
            return False
            
        except:  #maybe without connection
            self.rtc.WriteText("Failed server connection...")
            self.rtc.Newline()
            return  False
        
        self.rtc.WriteText("Reading html...")
        linesWiki = wikiPage.readlines()
        wikiPage.close()
        data = open(self.path, mode='w')
        
        #cc = open(self.path+"2", mode='w')
        #cc.writelines(linesWiki)
        #cc.close()
        
        recept = False
        for line in linesWiki:
            if not recept:
                if line in [self.inicio, self.inicio2]: recept = True
            if recept:
                if line.startswith(self.fin):
                    data.close()
                    return True
                data.write(line)

    #----------------------------------------------------------------------
    def getHelp(self, url, keyword):
        self.rtc.BeginStyle(self.urlStyle)
        self.rtc.BeginURL(url+"\n")
        self.rtc.WriteText(url+"\n")
        self.rtc.EndURL();
        self.rtc.EndStyle();         
        self.rtc.WriteText("Connecting with server...\n")  
        return self.lineWiki(url, keyword)

    #----------------------------------------------------------------------
    def writeHelp(self, titles, text):
        self.rtc = self.richTextKeywords
        for title in titles:
            self.rtc.BeginStyle(self.titleStyle)
            self.rtc.WriteText(title)
            self.rtc.EndStyle();
            if title == self.example:
                self.rtc.Newline()
                self.rtc.BeginStyle(self.exampleStyle)
                self.rtc.WriteText(text[title])
                self.rtc.EndStyle()
   
            elif title == self.see:
                recomended = text[title].split("\n")
                for function in recomended:
                    self.rtc.BeginStyle(self.urlStyle)
                    self.rtc.BeginURL(function.replace(" ", "")) 
                    self.rtc.WriteText(function.replace(" ", ""))
                    self.rtc.EndURL()
                    self.rtc.EndStyle()
                    self.rtc.Newline()
                    
            else: self.rtc.WriteText(text[title])
            self.rtc.Newline()
            self.rtc.Newline()            
            
    #----------------------------------------------------------------------
    def sortKeywordList(self):
        DictKeywordList = {}
        for key in self.keywordList:
            mo = re.match("([^.]+)\.([^.]+)", key)
            try:
                try: DictKeywordList[mo.group(1)].append(key)
                except: DictKeywordList[mo.group(1)] = [key]
            except:
                try: DictKeywordList["Others"].append(key)
                except: DictKeywordList["Others"] = [key]
        return DictKeywordList
    
    #----------------------------------------------------------------------
    def sortFunctions(self, event=None):
        KeywordList = self.DictKeywordList.keys()
        KeywordList.sort()
        self.listBoxKeywords.Clear()
        for function in self.checkListKeywords.CheckedStrings:
            self.listBoxKeywords.AppendItems(self.DictKeywordList[function])
                
    #----------------------------------------------------------------------
    def htmlPage(self):
        data = open(self.path, mode='r')
        lines = data.readlines()
        data.close()
        text = {}
        titles = []
        cont = []
        allText = []
        for line in lines:
            match = re.match(self.re, line)
            try:
                titles.append(match.group(2))
                allText.append(cont)
                cont = []
            except: cont.append(line)
        allText.append(cont)

        i = 0
        allText.pop(0)
        x = len(titles)
        y = len(allText)
        for tit in titles:
            text[tit] = allText[i]
            i += 1

        for title in text.keys():
            self.htmlWindow1.SetPage(" ".join(text[title]))
            plain = self.htmlWindow1.ToText()
            text[title] = plain
        
        return titles, text