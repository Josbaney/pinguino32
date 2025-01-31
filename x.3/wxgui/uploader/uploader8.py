#!/usr/bin/env python
#-*- coding: iso-8859-15 -*-

"""-------------------------------------------------------------------------
    Pinguino Universal Uploader

    Author:            Regis Blanchot <rblanchot@gmail.com> 
    Last release:    2012-04-20
    
    This library is free software you can redistribute it and/or
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

# This class is based on :
# - Diolan USB bootloader licenced (LGPL) by Diolan <http://www.diolan.com>
# - jallib USB bootloader licenced (BSD) by Albert Faber
# See also PyUSB Doc. http://wiki.erazor-zone.de/wiki:projects:python:pyusb:pydoc
# Pinguino Device Descriptors : lsusb -v -d 04d8:feaa

import sys
import os
import usb            # checked in check.py

from uploader import baseUploader

class uploader8(baseUploader):
    """ upload .hex into pinguino device """

    # General Data Packet Structure (usbBuf)
    # --------------------------------------------------------------------------
    #    __________________
    #    |    COMMAND     |   0       [CMD]
    #    |      LEN       |   1       [LEN]
    #    |     ADDRL      |   2       [        ]  [addrl]
    #    |     ADDRH      |   3       [ADR.pAdr]: [addrh]
    #    |     ADDRU      |   4       [        ]  [addru]
    #    |                |   5       [DATA]
    #    |                |
    #    .      DATA      .
    #    .                .
    #    |                |   62
    #    |________________|   63
    #
    # --------------------------------------------------------------------------
    BOOT_CMD                        =    0
    BOOT_CMD_LEN                    =    1
    BOOT_ADDR_LO                    =    2
    BOOT_ADDR_HI                    =    3
    BOOT_ADDR_UP                    =    4
    BOOT_DATA_START                 =    5

    BOOT_DEV1                       =    5
    BOOT_DEV2                       =    6
    BOOT_VER_MINOR                  =    2
    BOOT_VER_MAJOR                  =    3

    BOOT_SIZE                       =    1

    # Bootloader commands
    # --------------------------------------------------------------------------
    READ_VERSION_CMD                =    0x00
    READ_FLASH_CMD                  =    0x01
    WRITE_FLASH_CMD                 =    0x02
    ERASE_FLASH_CMD                 =    0x03
    #READ_EEDATA_CMD                =    0x04
    #WRITE_EEDATA_CMD               =    0x05
    #READ_CONFIG_CMD                =    0x06
    #WRITE_CONFIG_CMD               =    0x07
    RESET_CMD                       =    0xFF

    # Block's size to write
    # --------------------------------------------------------------------------
    BLOCKSIZE                       =    32

    # bulk endpoints
    # --------------------------------------------------------------------------
    IN_EP                           =    0x81    # endpoint for Bulk reads
    OUT_EP                          =    0x01    # endpoint for Bulk writes

    # configuration
    # --------------------------------------------------------------------------
    ACTIVE_CONFIG                   =    0x01
    INTERFACE_ID                    =    0x00
    TIMEOUT                         =    1200

    # Table with Microchip 8-bit USB devices
    # device_id:[PIC name] 
    # --------------------------------------------------------------------------

    devices_table = \
    {  
        0x4740: ['18f13k50'],
        0x4700: ['18lf13k50'],

        0x4760: ['18f14k50'],
        0x4720: ['18f14k50'],

        0x2420: ['18f2450'],
        0x1260: ['18f2455'],
        0x2A60: ['18f2458'],

        0x4C00: ['18f24j50'],
        0x4CC0: ['18lf24j50'],
        
        0x1240: ['18f2550'],
        0x2A40: ['18f2553'],

        0x4C20: ['18f25j50'],
        0x4CE0: ['18lf25j50'],
        
        0x4C40: ['18f26j50'],
        0x4D00: ['18lf26j50'],
        
        0x1200: ['18f4450'],
        0x1220: ['18f4455'],
        0x2A20: ['18f4458'],
        
        0x4C60: ['18f44j50'],
        0x4D20: ['18lf44j50'],
        
        0x1200: ['18f4550'],
        0x2A00: ['18f4553'],
        
        0x4C80: ['18f45j50'],
        0x4D40: ['18lf45j50'],
        
        0x4CA0: ['18f46j50'],
        0x4D60: ['18f46j50'],
        
        0x4100: ['18f65j50'],
        0x1560: ['18f66j50'],
        0x4160: ['18f66j55'],
        0x4180: ['18f67j50'],
        0x41A0: ['18f85j50'],
        0x41E0: ['18f86j50'],
        0x1F40: ['18f86j55'],
        0x4220: ['18f87j50']
    }

# ------------------------------------------------------------------------------
    def initDevice(self):
# ------------------------------------------------------------------------------
#   TODO: to move in uploader.py ?
# ------------------------------------------------------------------------------
        """ init pinguino device """
        #conf = self.device.configurations[0]
        #iface = conf.interfaces[0][0]
        handle = self.device.open()
        if handle:
            ##handle.detachKernelDriver(iface.interfaceNumber)
            #handle.setConfiguration(conf)
            #handle.claimInterface(iface)
            ##handle.setAltInterface(iface)
            handle.setConfiguration(self.ACTIVE_CONFIG)
            handle.claimInterface(self.INTERFACE_ID)
            return handle
        return self.ERR_USB_INIT1
# ------------------------------------------------------------------------------
    def sendCMD(self, usbBuf):  
# ------------------------------------------------------------------------------
        """ send command to the bootloader """
        sent_bytes = self.handle.bulkWrite(self.OUT_EP, usbBuf, self.TIMEOUT)
        if sent_bytes == len(usbBuf):
            # whatever is returned, USB packet size is always 64 bytes long in high speed mode
            return self.handle.bulkRead(self.IN_EP, 64, self.TIMEOUT)
            #return self.ERR_NONE
        else:        
            return self.ERR_USB_WRITE
# ------------------------------------------------------------------------------
    def resetDevice(self):
# ------------------------------------------------------------------------------
        """ reset device """
        usbBuf = [0] * 64
        # command code
        usbBuf[self.BOOT_CMD] = self.RESET_CMD
        # write data packet
        usbBuf = self.sendCMD(usbBuf)
        # wait 1 second
        #time.sleep(1)
# ------------------------------------------------------------------------------
    def getVersion(self):
# ------------------------------------------------------------------------------
        """ get bootloader version """
        usbBuf = [0] * 64
        # command code
        usbBuf[self.BOOT_CMD] = self.READ_VERSION_CMD
        # write data packet and get response
        usbBuf = self.sendCMD(usbBuf)
        if usbBuf == self.ERR_USB_WRITE:
            return self.ERR_USB_WRITE
        else:        
            # major.minor.subminor
            return str(usbBuf[self.BOOT_VER_MAJOR]) + "." + \
                   str(usbBuf[self.BOOT_VER_MINOR])
# ------------------------------------------------------------------------------
    def getDeviceID(self):
# ------------------------------------------------------------------------------
        """ read 2-byte device ID from location 0x3FFFFE """
        usbBuf = self.readFlash(0x3FFFFE, 2)
        if usbBuf == self.ERR_USB_WRITE:
            return self.ERR_USB_WRITE
        else:        
            #print "BUFFER =", usbBuf
            dev1 = usbBuf[self.BOOT_DEV1]
            #print "DEV1 =", dev1
            dev2 = usbBuf[self.BOOT_DEV2]
            #print "DEV2 =", dev2
            device_id = (int(dev2) << 8) + int(dev1)
            #print device_id
            device_rev = device_id & 0x001F
            # mask revision number
            return device_id  & 0xFFE0
# ------------------------------------------------------------------------------
    def getDeviceName(self, device_id):
# ------------------------------------------------------------------------------
        for n in self.devices_table:
            if n == device_id:
                return self.devices_table[n][0]
        return self.ERR_DEVICE_NOT_FOUND
# ------------------------------------------------------------------------------
    def eraseFlash(self, address, numBlocks):
# ------------------------------------------------------------------------------
        """ erase numBlocks of flash memory """
        usbBuf = [0] * 64
        # command code
        usbBuf[self.BOOT_CMD] = self.ERASE_FLASH_CMD
        # number of blocks to erase
        usbBuf[self.BOOT_SIZE] = numBlocks
        # block address
        usbBuf[self.BOOT_ADDR_LO] = (address      ) & 0xFF
        usbBuf[self.BOOT_ADDR_HI] = (address >> 8 ) & 0xFF
        usbBuf[self.BOOT_ADDR_UP] = (address >> 16) & 0xFF
        # write data packet and get response
        #print usbBuf
        usbBuf = self.sendCMD(usbBuf)
        #print usbBuf
# ------------------------------------------------------------------------------
    def readFlash(self, address, length):
# ------------------------------------------------------------------------------
        """ read a block of flash """
        usbBuf = [0] * 64
        # command code
        usbBuf[self.BOOT_CMD] = self.READ_FLASH_CMD 
        # size of block in bytes
        usbBuf[self.BOOT_CMD_LEN] = length
        # address of the block
        usbBuf[self.BOOT_ADDR_LO] = (address      ) & 0xFF
        usbBuf[self.BOOT_ADDR_HI] = (address >> 8 ) & 0xFF
        usbBuf[self.BOOT_ADDR_UP] = (address >> 16) & 0xFF
        # send request to the bootloader
        return self.sendCMD(usbBuf)
        #self.handle.bulkWrite(self.OUT_EP, usbBuf, self.TIMEOUT)
        #return self.handle.bulkRead(self.IN_EP, self.BOOT_DATA_START + length, self.TIMEOUT)
# ------------------------------------------------------------------------------
    def writeFlash(self, address, block):
# ------------------------------------------------------------------------------
        """ write a block of code """
        usbBuf = [0] * 64
        # command code
        usbBuf[self.BOOT_CMD] = self.WRITE_FLASH_CMD 
        # size of block
        usbBuf[self.BOOT_CMD_LEN] = len(block)
        # block's address
        usbBuf[self.BOOT_ADDR_LO] = (address      ) & 0xFF
        usbBuf[self.BOOT_ADDR_HI] = (address >> 8 ) & 0xFF
        usbBuf[self.BOOT_ADDR_UP] = (address >> 16) & 0xFF
        # add data to the packet
        for i in range(len(block)):
            usbBuf[self.BOOT_DATA_START + i] = block[i]
        # write data packet on usb device
        #print usbBuf
        usbBuf = self.sendCMD(usbBuf)
        #print usbBuf
# ------------------------------------------------------------------------------
    def hexWrite(self, filename, board):
# ------------------------------------------------------------------------------
        """ Parse the Hex File Format and send data to usb device """

        """
        [0]     Start code, one character, an ASCII colon ':'.
        [1:3]   Byte count, two hex digits, a number of bytes (hex digit pairs) in the data field. 16 (0x10) or 32 (0x20) bytes of data are the usual compromise values between line length and address overhead.
        [3:7]   Address, four hex digits, a 16-bit address of the beginning of the memory position for the data. Limited to 64 kilobytes, the limit is worked around by specifying higher bits via additional record types. This address is big endian.
        [7:9]   Record type, two hex digits, 00 to 05, defining the type of the data field.
        [9:*]   Data, a sequence of n bytes of the data themselves, represented by 2n hex digits.
        [*:*]   Checksum, two hex digits - the least significant byte of the two's complement of the sum of the values of all fields except fields 1 and 6 (Start code ":" byte and two hex digits of the Checksum). It is calculated by adding together the hex-encoded bytes (hex digit pairs), then leaving only the least significant byte of the result, and making a 2's complement (either by subtracting the byte from 0x100, or inverting it by XOR-ing with 0xFF and adding 0x01). If you are not working with 8-bit variables, you must suppress the overflow by AND-ing the result with 0xFF. The overflow may occur since both 0x100-0 and (0x00 XOR 0xFF)+1 equal 0x100. If the checksum is correctly calculated, adding all the bytes (the Byte count, both bytes in Address, the Record type, each Data byte and the Checksum) together will always result in a value wherein the least significant byte is zero (0x00).
                For example, on :0300300002337A1E
                03 + 00 + 30 + 00 + 02 + 33 + 7A = E2, 2's complement is 1E
        """

        data        = []
        old_address = 0 # or self.board.memstart ?
        max_address = 0
        address_Hi  = 0
        codesize    = 0

        # read hex file
        # ----------------------------------------------------------------------

        fichier = open(filename,'r')
        lines = fichier.readlines()
        fichier.close()

        # 1st pass : calculate checksum and max_address
        # ----------------------------------------------------------------------

        for line in lines:
            byte_count = int(line[1:3], 16)
            address_Lo = int(line[3:7], 16) # lower 16 bits (bits 0-15) of the data address
            record_type= int(line[7:9], 16)
            
            address = (address_Hi << 16) + address_Lo
            #print "address =", address

            # checksum calculation
            end = 9 + byte_count * 2 # position of checksum at end of line
            checksum = int(line[end:end+2], 16)
            cs = 0
            i = 1
            while i < end:
                cs = cs + (0x100 - int(line[i:i+2], 16) ) & 0xff # not(i)
                i = i + 2
            if checksum != cs:
                return self.ERR_HEX_CHECKSUM

            # extended linear address record
            if record_type == self.Extended_Linear_Address_Record:
                address_Hi = int(line[9:13], 16) << 16 # upper 16 bits (bits 16-31) of the data address
                #address = (address_Hi << 16) + address_Lo

            # code size
            if (address >= self.board.memstart) and (address < self.board.memend):
                codesize = codesize + byte_count

            # max address
            if (address > old_address) and (address < self.board.memend):
                max_address = address + byte_count
                old_address = address
                #print "max address =", max_address

        # max_address must be divisible by self.BLOCKSIZE
        #max_address = max_address + self.BLOCKSIZE - (max_address % self.BLOCKSIZE)        <= ERROR
        max_address = max_address + 64 - (max_address % 64)
        #print self.board.memstart, max_address, self.board.memend    

        # fill data sequence with 0xFF
        # ----------------------------------------------------------------------

        for i in range(max_address - self.board.memstart):
        #for i in range(max_address + 64 - self.board.memstart):
            data.append(0xFF)

        # 2nd pass : parse bytes from line into data
        # ----------------------------------------------------------------------

        address_Hi = 0

        for line in lines:
            byte_count  = int(line[1:3], 16)
            address_Lo  = int(line[3:7], 16) # four hex digits
            record_type = int(line[7:9], 16)

            # 32-bit address
            address = (address_Hi << 16) + address_Lo
            #print hex(address)

            # data record
            if record_type == self.Data_Record:
                if (address >= self.board.memstart) and (address < self.board.memend):
                    #print hex(address)
                    for i in range(byte_count):
                        #print address - self.board.memstart + i
                        #print int(line[9 + (2 * i) : 11 + (2 * i)], 16)
                        data[address - self.board.memstart + i] = int(line[9 + (2 * i) : 11 + (2 * i)], 16)
                    
            # end of file record
            elif record_type == self.End_Of_File_Record:
                break

            # extended linear address record
            elif record_type == self.Extended_Linear_Address_Record:
                address_Hi = int(line[9:13], 16) # upper 16 bits (bits 16-31) of the data address
                #print "address_Hi = " + hex(address_Hi)
                #address = (address_Hi << 16) + address_Lo

            # unsupported record type
            else:
                return self.ERR_HEX_RECORD

        # erase memory from self.board.memstart to max_address 
        # ----------------------------------------------------------------------

        # Pinguino x6j50
        if "j" in board.proc :
            #print board.proc
            numBlocksMax  = 1 + ((self.board.memend - self.board.memstart) / 1024)
            numBlocks1024 = 1 + ((max_address - self.board.memstart) / 1024)
            #print "numBlocks1024 =", numBlocks1024

            if numBlocks1024 > numBlocksMax:
                numBlocks1024 = numBlocksMax

            self.eraseFlash(self.board.memstart, numBlocks1024)

        # Pinguino x550
        else:
            numBlocks64 = 1 + ((max_address - self.board.memstart) / 64)
            if numBlocks64 > 511:
                return self.ERR_USB_ERASE
            if numBlocks64 < 256:
                self.eraseFlash(self.board.memstart, numBlocks64)
            else:
                # erase flash memory from self.board.memstart to self.board.memstart + 0x4000
                self.eraseFlash(self.board.memstart, 255)
                # erase flash memory from self.board.memstart + 0x4000 to max_address
                numBlocks64 = numBlocks64 - 255
                self.eraseFlash(self.board.memstart + 0x4000, numBlocks64)

        # write 32-bit blocks
        # ----------------------------------------------------------------------

        usbBuf = []
        for addr in range(self.board.memstart, max_address):
        #for addr in range(self.board.memstart, max_address + 64):
            index = addr - self.board.memstart
            #print hex(addr)
            if addr % self.BLOCKSIZE == 0:
                if usbBuf != []:
                    #print usbBuf
                    self.writeFlash(addr - self.BLOCKSIZE, usbBuf)
                usbBuf = []
            if data[index] != []:
                #print data[addr - self.board.memstart]
                usbBuf.append(data[index])
        #print "%d bytes written.\n" % codesize

        return self.ERR_NONE
# ------------------------------------------------------------------------------
    #def writeHex(self, output, filename, board):
    def writeHex(self):
# ------------------------------------------------------------------------------

        # check file to upload
        # ----------------------------------------------------------------------

        if self.filename == '':
            self.txtWrite("No program to write\n")
            self.closeDevice()
            return

        fichier = open(self.filename, 'r')
        if fichier == "":
            self.txtWrite("Unable to open %s\n" % self.filename)
            return
        fichier.close()

        # search for a Pinguino board
        # ----------------------------------------------------------------------

        self.device = self.getDevice()
        if self.device == self.ERR_DEVICE_NOT_FOUND:
            self.txtWrite("Pinguino not found\n")
            self.txtWrite("Is your device connected and/or in bootloader mode ?\n")
            return
        else:
            self.txtWrite("Pinguino found\n")

        self.handle = self.initDevice()
        if self.handle == self.ERR_USB_INIT1:
            self.txtWrite("Upload not possible\n")
            self.txtWrite("Try to restart the bootloader mode\n")
            return

        # find out the processor
        # ----------------------------------------------------------------------

        device_id = self.getDeviceID()
        proc = self.getDeviceName(device_id)
        if proc != self.board.proc:
            self.txtWrite("Compiled for %s but device has %s\n" % (self.board.proc, proc))
            return
        self.txtWrite("%s (id=%s)\n" % (proc, hex(device_id)))

        # find out bootloader version
        # ----------------------------------------------------------------------

        #product = handle.getString(device.iProduct, 30)
        #manufacturer = handle.getString(device.iManufacturer, 30)
        self.txtWrite("Pinguino bootloader v%s\n" % self.getVersion())

        # start writing
        # ----------------------------------------------------------------------

        self.txtWrite("Writing ...\n")
        status = self.hexWrite(self.filename, self.board)
        if status == self.ERR_NONE:
            self.txtWrite(os.path.basename(self.filename) + " successfully uploaded\n")
        if status == self.ERR_HEX_RECORD:
            self.txtWrite("Record error\n")
            self.closeDevice()
            return
        if status == self.ERR_HEX_CHECKSUM:
            self.txtWrite("Checksum error\n")
            self.closeDevice()
            return
        if status == self.ERR_USB_ERASE:
            self.txtWrite("Erase error\n")
            self.closeDevice()
            return

        # reset and start start user's app.
        # ----------------------------------------------------------------------

        self.txtWrite("Resetting ...\n")
        self.resetDevice()
        self.closeDevice()
        return
# ------------------------------------------------------------------------------
