#!/usr/bin/env python
#-*- coding: utf-8 -*-

"""-------------------------------------------------------------------------
    Recursive wx.TreeCtrl for *.pde files.

    author:		Yeison Cardona
    contact:		yeison.eng@gmail.com 
    first release:	31/March/2012
    last release:	03/July/2012
    
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

import wx, re
import sys, os

########################################################################
class Documents():
    #----------------------------------------------------------------------
    def __initDocuments__(self):
        self.lateralDir = self.lat.listCtrlDir
        self.lateralFiles = self.lat.listCtrlFiles
        self.recentPathsDir = []
        #self.currentLateralDir = os.path.join(os.getcwd(),"examples")
        self.parentDir = self.currentLateralDir
        #print self.parentDir
        
        self.lateralDir.InsertColumn(col=0, format=wx.LIST_FORMAT_LEFT, heading='Columns0', width=-1)  
        self.lateralFiles.InsertColumn(col=0, format=wx.LIST_FORMAT_LEFT, heading='Columns0', width=-1)
       
        self.icons()        
        
        #self.buildLateralDir(self.currentLateralDir)
        
        self.Bind(wx.EVT_LIST_ITEM_ACTIVATED, self.OnSelChanged, self.lateralDir)
        self.Bind(wx.EVT_LIST_ITEM_SELECTED, self.OnDirSelected, self.lateralDir)
        self.Bind(wx.EVT_LIST_ITEM_ACTIVATED, self.OnOpenFile, self.lateralFiles)
        self.Bind(wx.EVT_DIRPICKER_CHANGED, self.setDirPicker, self.lat.dirPicker)
        self.Bind(wx.EVT_CHOICE, lambda x:self.buildLateralFiles(self.parentDir), self.lat.choiceFile)

        
    #----------------------------------------------------------------------
    def icons(self):
        isz = (16,16)
        self.il = wx.ImageList(*isz)
        self.fldridx     = self.il.Add(wx.ArtProvider_GetBitmap(wx.ART_FOLDER,      wx.ART_OTHER, isz))
        self.fldropenidx = self.il.Add(wx.ArtProvider_GetBitmap(wx.ART_FILE_OPEN,   wx.ART_OTHER, isz))
        self.fileidx     = self.il.Add(wx.ArtProvider_GetBitmap(wx.ART_NORMAL_FILE, wx.ART_OTHER, isz))   
        self.lateralDir.SetImageList(self.il, wx.IMAGE_LIST_SMALL)
        self.lateralFiles.SetImageList(self.il, wx.IMAGE_LIST_SMALL)
        
    #----------------------------------------------------------------------
    def fixSizeDock(self):
        self.lateralDir.SetColumnWidth(0, self.lat.m_panel5.Size[0])
        self.lateralFiles.SetColumnWidth(0, self.lat.m_panel6.Size[0])
        
    #----------------------------------------------------------------------
    def buildLateralDir(self, path):
        self.fixSizeDock()
        self.lat.dirPicker.SetPath(path)
        dirs = os.listdir(path)
        dirs.sort()
        self.lateralDir.DeleteAllItems()
        self.addItemDock(self.lateralDir, "..", self.fldridx)
        for dir in dirs:
            if os.path.isdir(os.path.join(path, dir)) and not dir.startswith("."):
                self.addItemDock(self.lateralDir, dir, self.fldridx)
        self.lateralDir.Select(0)       
                
    #----------------------------------------------------------------------
    def addItemDock(self, listDir, name, icon):   
        listDir.InsertImageStringItem(sys.maxint, name, icon)
        listDir.SetItemData(0, 0)
     
    #----------------------------------------------------------------------
    def setDirPicker(self, event):
        self.fixSizeDock()
        path =  event.Path
        self.buildLateralDir(path)
        
    #----------------------------------------------------------------------
    def buildLateralFiles(self, path):
        self.parentDir = path
        self.fixSizeDock()
        files = os.listdir(path)
        files.sort()
        pattern = self.lat.choiceFile.GetString(self.lat.choiceFile.GetSelection()).replace("*", "")
        if self.lat.choiceFile.GetString(self.lat.choiceFile.GetSelection()) == "*.*": pattern = ""
        self.lateralFiles.DeleteAllItems()
        for file in files:
            if os.path.isfile(os.path.join(path, file)) and not file.startswith(".") and file.endswith(pattern):
                self.addItemDock(self.lateralFiles, file, self.fileidx)
            
    #--------------------------------------------------------------------------
    def OnSelChanged(self, event):
        self.fixSizeDock()
        path = self.lat.dirPicker.GetPath()
        sel = event.GetLabel()
        if sel == "..":
            self.currentLateralDir = os.path.split(path)[0]
            self.buildLateralDir(self.currentLateralDir)
        else:
            allFiles = os.listdir(os.path.join(path, sel))
            allFiles = (file for file in allFiles if not file.startswith("."))
            for file in allFiles:
                if os.path.isdir(os.path.join(path, sel, file)):
                    self.currentLateralDir = os.path.join(path, sel)
                    self.buildLateralDir(self.currentLateralDir)
                    return
                
    #----------------------------------------------------------------------
    def OnDirSelected(self, event):
        self.fixSizeDock()
        path = self.lat.dirPicker.GetPath()
        sel = event.GetLabel()
        if sel == "..": self.buildLateralFiles(path)
        else: self.buildLateralFiles(os.path.join(path, sel))
        
    #--------------------------------------------------------------------------
    def OnOpenFile(self, event):
        sel = event.GetLabel()
        path = os.path.join(self.currentLateralDir, self.parentDir, sel)
        try: self.background.Hide()
        except: pass  #self.background not exist
        self.Open(path)
        event.Skip()
        
        

    