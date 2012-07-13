#!/usr/bin/env python
#-*- coding: utf-8 -*-

import wx, os, sys
#from wxgui.pinguino import getOptions, getVersion, Pinguino, setGui
from wxgui.pinguino import *
from wxgui._trad import _


########################################################################
class MySplashScreen(wx.SplashScreen):
    #----------------------------------------------------------------------
    def __init__(self):
        """"""
        #bmp = wx.Image(os.path.join("theme", "logoX3.png")).ConvertToBitmap()
        image = wx.Image(os.path.join("theme", "logoX3.png"), wx.BITMAP_TYPE_PNG)
        image = image.Scale(500, 375, wx.IMAGE_QUALITY_HIGH)
        bmp = wx.BitmapFromImage(image)
        memDC = wx.MemoryDC()
        memDC.SetFont(wx.Font(10, wx.SWISS, wx.ITALIC, wx.NORMAL))
        memDC.SetTextForeground(wx.BLACK)
        memDC.SelectObject(bmp)
        memDC.DrawText(_("loading..."), 10, 355)
        memDC.SelectObject(wx.NullBitmap)
        # TODO : replace wx.BORDER_SIMPLE (windows only)		
        wx.SplashScreen.__init__(self, bmp,
                                 wx.SPLASH_CENTRE_ON_SCREEN | wx.SPLASH_TIMEOUT,
                                 5000, None, -1, style=wx.BORDER_SIMPLE)
        self.Bind(wx.EVT_CLOSE, self.OnClose)
        self.fc = wx.FutureCall(2000, self.ShowMain)

    #----------------------------------------------------------------------
    def OnClose(self, evt):
        evt.Skip()
        self.Hide()
        if self.fc.IsRunning():
            self.fc.Stop()
            self.ShowMain()

    #----------------------------------------------------------------------
    def ShowMain(self):
        setGui(True)
        frame = Pinguino(None)
        frame.__initPinguino__(None)
        app.SetTopWindow(frame)
        #app.cent
        frame.Show()
        if self.fc.IsRunning(): self.Raise()

########################################################################
class MyApp(wx.App):
    def OnInit(self):
        if sys.platform=='darwin':
            setGui(True)
            frame = Pinguino(None)
            frame.__initPinguino__(None)
            app.SetTopWindow(frame)
            #app.cent
            frame.Show()
        else:			
            splash = MySplashScreen()
            splash.Show()
        return True


#----------------------------------------------------------------------
def main():
    app = MyApp(False)
    #app.SetTopWindow(frame)
    app.MainLoop()



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
        print "current version is " + getVersion() #pinguino_version
        sys.exit(1)

    if options.author == True:
        print "jean-pierre mandon"
        print "regis blanchot"
        sys.exit(1)

    if options.board != False or type(options.board) == type(1):  # False = 0
        curBoard = boardlist[options.board]

        if options.filename == False:
            print "missing filename"
            sys.exit(1)
        filename = options.filename[0]
        fname, extension = os.path.splitext(filename)
        if extension != ".pde":
            print "bad file extension, it should be .pde"
            sys.exit(1)

        pobject=Pinguino(None)
        pobject.setOSvariables()
        
        print "board " + curBoard.name
        print "mcu   " + curBoard.proc

        print "preprocessing ..."
        retour=pobject.preprocess(fname, curBoard)
        if retour == "error":
            print "error while preprocessing " + filename
            sys.exit(1)

        print "compiling ..."
        retour = pobject.compile(filename, curBoard)
        if retour != 0:
            print "error while compiling file " + filename
            sys.exit(1)

        print "linking ..."
        retour=pobject.link(filename, curBoard)

        if curBoard.arch == 8:
            MAIN_FILE="main.hex"
        else:
            MAIN_FILE="main32.hex"

        if os.path.exists(os.path.join(SOURCE_DIR, MAIN_FILE))!=True:
            print "error while linking "
            sys.exit(1)

        shutil.copy(os.path.join(SOURCE_DIR, MAIN_FILE), fname + ".hex")
        print "compilation done"
        print pobject.getCodeSize(fname, curBoard)
        os.remove(os.path.join(SOURCE_DIR, MAIN_FILE))
        #os.remove(fname + ".c")	   
        sys.exit(0)


# ------------------------------------------------------------------------------
# ---Graphic User Interface-----------------------------------------------------
# ------------------------------------------------------------------------------

    main()