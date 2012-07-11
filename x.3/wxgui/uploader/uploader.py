#!/usr/bin/env python
#-*- coding: utf-8 -*-

import usb

########################################################################
class baseUploader:
    
# Hex format record types
# --------------------------------------------------------------------------

    Data_Record = 00
    End_Of_File_Record = 01
    Extended_Segment_Address_Record = 02
    Start_Segment_Address_Record = 03
    Extended_Linear_Address_Record = 04
    Start_Linear_Address_Record = 05    
    
    
# Error codes returned by various functions
# --------------------------------------------------------------------------

    ERR_NONE = 0
    ERR_CMD_ARG = 1
    ERR_CMD_UNKNOWN = 2
    ERR_DEVICE_NOT_FOUND = 3
    ERR_USB_INIT1 = 4
    ERR_USB_INIT2 = 5
    ERR_USB_OPEN = 6
    ERR_USB_WRITE = 7
    ERR_USB_READ = 8
    ERR_HEX_OPEN = 9
    ERR_HEX_STAT = 10
    ERR_HEX_MMAP = 11
    ERR_HEX_SYNTAX = 12
    ERR_HEX_CHECKSUM = 13
    ERR_HEX_RECORD = 14
    ERR_VERIFY = 15
    ERR_EOL = 16
    ERR_USB_ERASE = 17

# ------------------------------------------------------------------------------
    def __init__(self, output, filename, board):
        self.output = output
        self.filename = filename
        self.board = board

# ------------------------------------------------------------------------------
    def txtWrite(self, message):
        """ display message in the log window """
        self.output.WriteText(message)

# ------------------------------------------------------------------------------
    def getDevice(self):
        """ get list of USB devices and search for pinguino """
        busses = usb.busses()
        for bus in busses:
            for device in bus.devices:
                if device.idVendor == self.board.vendor and device.idProduct == self.board.product:
                    return device
        return self.ERR_DEVICE_NOT_FOUND

# ------------------------------------------------------------------------------
    def closeDevice(self):
        """ Close currently-open USB device """
        self.handle.releaseInterface()

########################################################################
class Uploader:
    """Universal uploder class"""

    #need to be imported HERE!!
    from uploaderVSC import uploaderVSC
    from uploaderDLN import uploaderDLN
    from uploader8   import uploader8
    #from uploaderMCC import uploaderMCC

    #----------------------------------------------------------------------
    def __init__(self, logwindow, filename, Board):
        self.logwindow = logwindow
        self.filename = filename
        if type(Board) == type([]):
            self.curBoard = self.getBoard(Board)
        else:
            self.curBoard = Board

        parameters = (self.logwindow, filename + '.hex', self.curBoard)

        if self.curBoard.bldr == 'boot2':
            curUploader = self.uploaderVSC(*parameters)
        elif self.curBoard.bldr == 'boot3':
            curUploader = self.uploaderDLN(*parameters)
        elif self.curBoard.bldr == 'boot4':
            curUploader = self.uploader8(*parameters)
        elif self.curBoard.bldr == 'microchip':
            curUploader = self.uploaderMCC(*parameters)

        curUploader.writeHex()


    #----------------------------------------------------------------------
    def getBoard(self, boardlist):
        """"""
        #Code to get and return board parameters
        #return a board from boardlist

