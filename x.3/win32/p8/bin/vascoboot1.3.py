#!/usr/bin/env python
# -*- coding: iso-8859-15 -*-

"""-------------------------------------------------------------------------
  vasco downloader

             (c) 2008 Jean-Pierre MANDON <jp.mandon@gmail.com> 

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

# $Id: vascoboot.py,v 1.1 2008/08/15 20:05:00 mandon
# $Id: vascoboot.py,v 1.3 2009/01/17 22:14:00 mandon found bug in uploadfile 

# based on the DOCKER software licensed by Pierre Gaufillet <pierre.gaufillet@magic.fr> 
# original project hosted on gforge
# http://gforge.enseeiht.fr/projects/vasco/

import wx
import sys
import os
import usb
import time



class VacoBoot(wx.Frame):
    filename=""
    SetGUI=1    
    # default Vendor_id and Product_id ( MICROCHIP JP.MANDON SUBLICENSE )
    
    vendor_id=0x04D8
    product_id=0xFEAA
    
    # USB endpoint
    
    BULK_IN_EP = 0x82
    BULK_OUT_EP = 0x01

    # Bootloader commands
    ERASE_FLASH_CMD=0
    WRITE_FLASH_CMD=1
    READ_FLASH_CMD=2
    VALID_APPLICATION_CMD=3
    RESET_CMD=4
    SECTION_DESCRIPTOR_CMD=5
        
    def __init__(self, *args, **kwds):
        if sys.platform=="win32":
            self.fileseparator="\\"
        else:
            self.fileseparator="/"
        if self.SetGUI==1:
            kwds["style"] = wx.CAPTION|wx.CLOSE_BOX|wx.SYSTEM_MENU
            wx.Frame.__init__(self, *args, **kwds)
            self.frame_1_statusbar = self.CreateStatusBar(1, 0)
            self.filefield = wx.TextCtrl(self, -1, sys.argv[1])
            self.filename=sys.argv[1]
            self.loadbutton = wx.Button(self, -1, "LoadFile...")
            self.log = wx.TextCtrl(self, -1, "", style=wx.TE_MULTILINE)
            self.WriteButton = wx.Button(self, -1, "Write")
            self.quitbutton = wx.Button(self, -1, "Quit")
            self.radio_btn_1 = wx.RadioButton(self, -1, "Microchip", style=wx.RB_GROUP)
            self.radio_btn_2 = wx.RadioButton(self, -1, "Vasco")
            self.radio_btn_3 = wx.RadioButton(self, -1, "Custom")
            self.label_1 = wx.StaticText(self, -1, "Vendor ID")
            self.vid = wx.TextCtrl(self, -1, "")
            self.label_2 = wx.StaticText(self, -1, "Product ID")
            self.pid = wx.TextCtrl(self, -1, "")

            self.__set_properties()
            self.__do_layout()

            self.Bind(wx.EVT_BUTTON, self.Load, self.loadbutton)
            self.Bind(wx.EVT_BUTTON, self.Write, self.WriteButton)
            self.Bind(wx.EVT_BUTTON, self.Quit, self.quitbutton)
            self.Bind(wx.EVT_RADIOBUTTON, self.SetMicrochip, self.radio_btn_1)
            self.Bind(wx.EVT_RADIOBUTTON, self.SetVasco, self.radio_btn_2)
            self.Bind(wx.EVT_RADIOBUTTON, self.SetCustom, self.radio_btn_3)
            self.vid.AppendText("04D8")
            self.pid.AppendText("FEAA")

    def __set_properties(self):
        self.SetTitle("VascoBootloader")
        _icon = wx.EmptyIcon()
        # this line is used for py2exe compilation
        #_icon.CopyFromBitmap(wx.Bitmap("connec9.ico", wx.BITMAP_TYPE_ANY))
        _icon.CopyFromBitmap(wx.Bitmap(sys.path[0]+self.fileseparator+"connec9.ico", wx.BITMAP_TYPE_ANY))
        self.SetIcon(_icon)        
        self.SetSize((428, 450))
        self.SetBackgroundColour(wx.Colour(216, 216, 191))
        self.frame_1_statusbar.SetStatusWidths([-1])
        frame_1_statusbar_fields = ["Vasco Bootloader version 1.3"]
        for i in range(len(frame_1_statusbar_fields)):
            self.frame_1_statusbar.SetStatusText(frame_1_statusbar_fields[i], i)
        self.filefield.SetMinSize((250, 21))
        self.log.SetMinSize((340,180))

    def __do_layout(self):
        sizer_1 = wx.BoxSizer(wx.VERTICAL)
        sizer_2 = wx.BoxSizer(wx.VERTICAL)
        sizer_5 = wx.BoxSizer(wx.HORIZONTAL)
        sizer_7 = wx.BoxSizer(wx.VERTICAL)
        sizer_9 = wx.BoxSizer(wx.HORIZONTAL)
        sizer_8 = wx.BoxSizer(wx.HORIZONTAL)
        sizer_6 = wx.BoxSizer(wx.VERTICAL)
        sizer_4 = wx.BoxSizer(wx.HORIZONTAL)
        sizer_3 = wx.BoxSizer(wx.HORIZONTAL)
        sizer_3.Add(self.filefield, 0, wx.LEFT|wx.ALIGN_CENTER_VERTICAL, 15)
        sizer_3.Add(self.loadbutton, 0, wx.LEFT|wx.RIGHT|wx.ALIGN_CENTER_VERTICAL, 40)
        sizer_2.Add(sizer_3, 1, wx.EXPAND, 0)
        sizer_2.Add(self.log, 0, wx.LEFT|wx.RIGHT|wx.EXPAND, 14)
        sizer_4.Add(self.WriteButton, 0, wx.LEFT|wx.RIGHT|wx.ALIGN_CENTER_VERTICAL, 69)
        sizer_4.Add(self.quitbutton, 0, wx.LEFT|wx.RIGHT|wx.ALIGN_CENTER_VERTICAL, 50)
        sizer_2.Add(sizer_4, 1, wx.EXPAND, 0)
        sizer_6.Add(self.radio_btn_1, 0, wx.LEFT|wx.ALIGN_CENTER_HORIZONTAL, 20)
        sizer_6.Add(self.radio_btn_2, 0, wx.LEFT|wx.TOP|wx.BOTTOM|wx.ALIGN_CENTER_HORIZONTAL, 5)
        sizer_6.Add(self.radio_btn_3, 0, wx.LEFT|wx.ALIGN_CENTER_HORIZONTAL, 13)
        sizer_5.Add(sizer_6, 1, wx.EXPAND, 0)
        sizer_8.Add(self.label_1, 0, wx.LEFT|wx.ALIGN_CENTER_HORIZONTAL|wx.ALIGN_CENTER_VERTICAL, 1)
        sizer_8.Add(self.vid, 0, wx.LEFT|wx.ALIGN_CENTER_VERTICAL, 5)
        sizer_7.Add(sizer_8, 1, wx.EXPAND, 0)
        sizer_9.Add(self.label_2, 0, wx.ALIGN_CENTER_HORIZONTAL|wx.ALIGN_CENTER_VERTICAL, 7)
        sizer_9.Add(self.pid, 0, wx.LEFT|wx.ALIGN_CENTER_VERTICAL, 4)
        sizer_7.Add(sizer_9, 1, wx.EXPAND, 0)
        sizer_5.Add(sizer_7, 1, wx.EXPAND, 0)
        sizer_2.Add(sizer_5, 1, wx.EXPAND, 0)
        sizer_1.Add(sizer_2, 1, wx.EXPAND, 0)
        self.SetSizer(sizer_1)
        self.Layout()
        self.Centre()

    def Load(self, event):
        opendlg = wx.FileDialog(
            self, message="Choose a file",
            defaultDir=os.getcwd(), 
            defaultFile="",
            wildcard="Hex file (*.hex)|*.hex",
            style=wx.OPEN  | wx.CHANGE_DIR
            )
        if opendlg.ShowModal() == wx.ID_OK:
            paths = opendlg.GetPaths()
            for path in paths:
                self.log.AppendText(os.path.basename(path)+' opened\n')
                self.filefield.Clear()
                self.filefield.AppendText(path)
            self.filename=path

    def Write(self, event):
        if self.SetGUI==1:
            try:
                vendor=int(self.vid.GetLineText(0),16)
                product=int(self.pid.GetLineText(0),16)
            except:
                self.log.AppendText("Vendor ID and Product ID must be Hexadecimal numers\n")
                return
        self.WriteFile(vendor,product,self.filename)
    
    def WriteFile(self,vendor,product,file):
        dh=self.getdevices(vendor,product)
        if dh==None:
            if self.SetGUI==1:
                self.log.AppendText("PIC not found !!\n")
            return -1
        if self.SetGUI==1:
            self.log.AppendText("PIC found\n")
        self.handle=self.init_device(dh)
        if file!='':
            self.uploadfile(file)
            self.Release(self.handle)
            if self.SetGUI==1:
                self.log.AppendText(os.path.basename(self.filename)+" uploaded\n")
            return 0
        else:
            if self.SetGUI==1:
                self.log.AppendText("No file to write !!\n")
            self.Release(self.handle)
            return -2        

    def Quit(self, event):
        self.Destroy()
        
    def SetMicrochip(self, event):
        self.vendor_id=0x04D8
        self.product_id=0x000B
        self.vid.Clear()
        self.pid.Clear()
        self.vid.AppendText("0x04D8")
        self.pid.AppendText("0xFEAA")

    def SetVasco(self, event):
        self.vendor_id=0xA5A5
        self.product_id=0x0001
        self.vid.Clear()
        self.pid.Clear()
        self.vid.AppendText("0xA5A5")
        self.pid.AppendText("0x0001")        

    def SetCustom(self, event):
        self.vid.Clear()
        self.pid.Clear()

    def getdevices(self,vendorid,productid):
        """ get list of USB devices and test for pinguino """
        buses=usb.busses()
        for bus in buses:
            for device in bus.devices:
                if device.idVendor==vendorid and device.idProduct==productid:
                    return device
        return None

    def init_device(self,device):
        """ init pinguino """
        handle=device.open()
        handle.setConfiguration(2)
        handle.claimInterface(0)
        return handle

    def Release(self,device):
        """ release USB interface with Pinguino """
        device.releaseInterface()
    
    def erase(self,adresse):
        """ erase 64 bytes of flash memory """
        readbyte0=self.ERASE_FLASH_CMD
        adresse="%06X"%adresse
        readbyte1=int(adresse[4:6],16)
        readbyte2=int(adresse[2:4],16)
        readbyte3=int(adresse[0:2],16)
        self.handle.bulkWrite(self.BULK_OUT_EP,chr(readbyte0)+chr(readbyte1)+chr(readbyte2)+chr(readbyte3),200)    

    def WriteUSB(self,adresse,bloc):
        """ write a 32 bytes block of code """
        readbyte0=self.WRITE_FLASH_CMD 
        adresse="%06X"%adresse
        readbyte1=int(adresse[4:6],16)
        readbyte2=int(adresse[2:4],16)
        readbyte3=int(adresse[0:2],16)
        frame=chr(readbyte0)+chr(readbyte1)+chr(readbyte2)+chr(readbyte3)
        for i in range(32):
            frame=frame+chr(bloc[i])
        self.handle.bulkWrite(self.BULK_OUT_EP,frame,200)
    
    def uploadfile(self,file):
        data=[]
        oldadd=0
        maxadd=0
        fichier=open(file,'r')
        lines=fichier.readlines()
        fichier.close()
        for line in lines:
            nb=int(line[1:3],16)
            add=int(line[3:7],16)
            if (add>oldadd) and (add<0x8000):
                maxadd=add+nb
                oldadd=add
        maxadd=maxadd+64-(maxadd%64)            
        for i in range(maxadd):
            data.append(0xFF)
        for line in lines:
            nb=int(line[1:3],16)
            add=int(line[3:7],16)
            if add>=0x2000 and add<0x8000:
                for i in range(0,nb):
                    data[add+i]=int(line[9+(2*i):11+(2*i)],16)
        index=0
        frame=[]
        for i in range(0x2000,maxadd):
            if i%64==0:
                self.erase(i)
            if i%32==0:
                index=0
                if frame!=[]:
                    self.WriteUSB(i-32,frame)
                frame=[]
            if data[i]!=[]:
                frame.append(data[i])
            index+=1 

if __name__ == "__main__":
    SetGUI=1
    app = wx.PySimpleApp(0)
    wx.InitAllImageHandlers()
    frame_1 = VacoBoot(None, -1, "")
    app.SetTopWindow(frame_1)
    frame_1.Show()
    app.MainLoop()
