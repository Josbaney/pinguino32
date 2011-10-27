#!/usr/bin/env python
# -*- coding: iso-8859-15 -*-

"""-------------------------------------------------------------------------
	Pinguino Universal Uploader

	(c) 2011 Regis Blanchot <rblanchot@gmail.com> 

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

# based on the DOCKER software licensed by Pierre Gaufillet <pierre.gaufillet@magic.fr> 
# based on the VascoBootloader software by Jean-Pierre Mandon <jp.mandon@gmail.com>
# based on UBW32 bootloader software licensed by Phillip Burgess <pburgess@dslextreme.com>

import sys
import os
import time
import usb			# checked in check.py

class uploader:
	""" upload .hex into pinguino device """

	INTERFACE_ID					=	0x00

	# Hex format record types
	# ---------------------------------------------------------------------------

	Data_Record = 00
	End_Of_File_Record = 01
	Extended_Segment_Address_Record = 02
	Start_Segment_Address_Record = 03
	Extended_Linear_Address_Record = 04
	Start_Linear_Address_Record = 05

	# Vasco Bulk bootloader commands
	# ---------------------------------------------------------------------------
	VSC_ERASE_FLASH_CMD			=	0x00
	VSC_WRITE_FLASH_CMD			=	0x01
	VSC_READ_FLASH_CMD			=	0x02
	VSC_VALID_APPLICATION_CMD	=	0x03
	VSC_RESET_DEVICE_CMD			=	0x04
	VSC_SECTION_DESCRIPTOR_CMD	=	0x05

	# bulk endpoints
	VSC_IN_EP						=	0x82	# endpoint for Bulk reads
	VSC_OUT_EP						=	0x01	# endpoint for Bulk writes

	# Microchip Hid bootloader commands
	# ---------------------------------------------------------------------------
	MCC_QUERY_DEVICE_CMD			=	0x02	# what regions can be programmed, and what type of memory is the region
	MCC_UNLOCK_CONFIG_CMD		=	0x03	# for both locking and unlocking the config bits
	MCC_ERASE_DEVICE_CMD			=	0x04	# to start an erase operation, firmware controls which pages should be erased
	MCC_PROGRAM_DEVICE_CMD		=	0x05	# to send a full RequestDataBlockSize to be programmed
	MCC_PROGRAM_COMPLETE_CMD	=	0x06	# if host send less than a RequestDataBlockSize to be programmed, or if it wished to program whatever was left in the buffer, it uses this command
	MCC_GET_DATA_CMD				=	0x07	# the host sends this command in order to read out memory from the device. Used during verify (and read/export hex operations)
	MCC_RESET_DEVICE_CMD			=	0x08	# resets the microcontroller, so it can update the config bits (if they were programmed, and so as to leave the bootloader (and potentially go back into the main application)

	# Unlock Configs Command Definitions
	MCC_UNLOCKCONFIG_CMD			=	0x00	# sub-command for the MCC_ERASE_DEVICE_CMD
	MCC_LOCKCONFIG_CMD			=	0x01	# sub-command for the MCC_ERASE_DEVICE_CMD

	# Query Device Response "Types"
	TypeProgramMemory				=	0x01	# when the host sends a QUERY_DEVICE command, need to respond by populating a list of valid memory regions that exist in the device (and should be programmed)
	TypeEEPROM						=	0x02
	TypeConfigWords				=	0x03
	TypeEndOfTypeList				=	0xFF	# sort of serves as a "null terminator" like number, which denotes the end of the memory region list has been reached.

	# hid endpoints
	MCC_IN_EP						=	0x81	# endpoint for Hid reads
	MCC_OUT_EP						=	0x01	# endpoint for Bulk writes

	# Device family
	DEVICE_FAMILY_PIC18			=	0x01
	DEVICE_FAMILY_PIC24			=	0x02
	DEVICE_FAMILY_PIC32			=	0x03

	# operations
	USB_READ = 1
	USB_WRITE = 0

	# Error codes returned by various functions
	# ---------------------------------------------------------------------------
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

# ------------------------------------------------------------------------------
	def getDevices(self, board):
		""" get list of USB devices and test for pinguino """
		busses = usb.busses()
		for bus in busses:
			for device in bus.devices:
				if device.idVendor == board.vendor and device.idProduct == board.product:
					return device
		return self.ERR_DEVICE_NOT_FOUND
# ------------------------------------------------------------------------------
	def initDevice(self, device, board):
		""" get endpoints and init pinguino device """
		if board.arch == 8:
			self.getEndpoint(device, 2)
		else:
			self.getEndpoint(device, 1)
		handle = device.open()
		if handle:
			try:
				# make sure the hiddev kernel driver is not active
				handle.detachKernelDriver(self.iface)
			except usb.USBError:
				pass
			try:			
				handle.reset()
			except usb.USBError:
				return self.ERR_USB_INIT1
			handle.setConfiguration(self.conf)
			handle.claimInterface(self.iface)
			handle.setAltInterface(self.iface)
			return handle
		return self.ERR_USB_INIT1
# ------------------------------------------------------------------------------
	def getEndpoint(self, device, active_config):
		""" get an endpoint instance """
		for config in device.configurations:
			#print "  Configuration:", config.value
			#print "    Total length:", config.totalLength 
			#print "    selfPowered:", config.selfPowered
			#print "    remoteWakeup:", config.remoteWakeup
			#print "    maxPower:", config.maxPower
			self.conf = config.value
			if config.value == active_config:
				for intf in config.interfaces:
					#print "    Interface:",intf[0].interfaceNumber
					self.iface = intf[0].interfaceNumber
					for alt in intf:
						#print "    Alternate Setting:",alt.alternateSetting
						#print "      Interface class:",alt.interfaceClass
						#print "      Interface sub class:",alt.interfaceSubClass
						#print "      Interface protocol:",alt.interfaceProtocol
						for ep in alt.endpoints:
							#print "      Endpoint:",hex(ep.address)
							#print "        Type:",ep.type
							#print "        Max packet size:",ep.maxPacketSize
							#print "        Interval:",ep.interval
							if ep.address > 0x80:
								#return VSC_IN_EP or MCC_IN_EP
								self.endpoint = ep.address
								return
# ------------------------------------------------------------------------------
	def usbWrite(self, handle, usbBuf):
		"""
		Write data packet to currently-open USB device, optionally
		Data source is always global array usbBuf[]
		Parameters  : len -> Size of source data in bytes (max 64).
		Returns     : ErrorCode  ERR_NONE on success, ERR_USB_WRITE on error.
		Notes       : Device is assumed to have already been successfully opened
				        by the time this function is called; no checks performed here.
		"""
		if self.endpoint == self.MCC_IN_EP:
			# handle.bulkWrite(self.MCC_OUT_EP, usbBuf, 200)
			if not handle.interruptWrite(self.MCC_OUT_EP, usbBuf, 0):
				return self.ERR_USB_WRITE
		else:
			if not handle.bulkWrite(self.VSC_OUT_EP, usbBuf, 200):
				return self.ERR_USB_WRITE
		return self.ERR_NONE
# ------------------------------------------------------------------------------
	def eraseBlock(self, handle, address):
		""" erase 64 bytes of flash memory """

		if self.endpoint == self.VSC_IN_EP:
			# command
			readbyte0 = self.VSC_ERASE_FLASH_CMD
			# block address
			address = "%06X" % address
			readbyte1 = int(address[4:6],16)
			readbyte2 = int(address[2:4],16)
			readbyte3 = int(address[0:2],16)
			#
			usbBuf = chr(readbyte0) + chr(readbyte1) + chr(readbyte2) + chr(readbyte3)
		else:
			# command
			readbyte0 = self.MCC_ERASE_DEVICE_CMD
			# block address
			address = "%08X" % address
			readbyte1 = int(address[6:8], 16)
			readbyte2 = int(address[4:6], 16)
			readbyte3 = int(address[2:4], 16)
			readbyte4 = int(address[0:2], 16)
			#
			usbBuf = chr(readbyte0) + chr(readbyte1) + chr(readbyte2) + chr(readbyte3) + chr(readbyte4)

		# write data packet
		self.usbWrite(handle, usbBuf)
# ------------------------------------------------------------------------------
	def issueBlock(self, output, handle, address, block):
		""" write a 32 bytes block of code """

		# progress bar
		self.txtWrite(output, ".")

		if self.endpoint == self.MCC_IN_EP:
			# device command
			readbyte0 = self.MCC_PROGRAM_DEVICE_CMD 
			# block's address
			address = "%08X" % address
			readbyte1 = int(address[6:8], 16)
			readbyte2 = int(address[4:6], 16)
			readbyte3 = int(address[2:4], 16)
			readbyte4 = int(address[0:2], 16)
			# data's length
			readbyte5 = len(block)
			# 
			usbBuf = chr(readbyte0) + chr(readbyte1) + chr(readbyte2) + chr(readbyte3) + chr(readbyte4) + chr(readbyte5)
		else:					
			readbyte0 = self.VSC_WRITE_FLASH_CMD 
			# block's address
			address = "%06X" % address
			readbyte1 = int(address[4:6], 16)
			readbyte2 = int(address[2:4], 16)
			readbyte3 = int(address[0:2], 16)
			#
			usbBuf = chr(readbyte0) + chr(readbyte1) + chr(readbyte2) + chr(readbyte3)

		# add data to the packet
		for i in range(len(block)):
			usbBuf = usbBuf + chr(block[i])

		# write data packet on usb device
		self.usbWrite(handle, usbBuf)
# ------------------------------------------------------------------------------
	def hexWrite(self, output, handle, filename, board):
		""" Parse the Hex File Format and send data to usb device """

		"""
		[0]		Start code, one character, an ASCII colon ':'.
		[1:3]		Byte count, two hex digits, a number of bytes (hex digit pairs) in the data field. 16 (0x10) or 32 (0x20) bytes of data are the usual compromise values between line length and address overhead.
		[3:7]		Address, four hex digits, a 16-bit address of the beginning of the memory position for the data. Limited to 64 kilobytes, the limit is worked around by specifying higher bits via additional record types. This address is big endian.
		[7:9]		Record type, two hex digits, 00 to 05, defining the type of the data field.
		[9:*]		Data, a sequence of n bytes of the data themselves, represented by 2n hex digits.
		[*:*]		Checksum, two hex digits - the least significant byte of the two's complement of the sum of the values of all fields except fields 1 and 6 (Start code ":" byte and two hex digits of the Checksum). It is calculated by adding together the hex-encoded bytes (hex digit pairs), then leaving only the least significant byte of the result, and making a 2's complement (either by subtracting the byte from 0x100, or inverting it by XOR-ing with 0xFF and adding 0x01). If you are not working with 8-bit variables, you must suppress the overflow by AND-ing the result with 0xFF. The overflow may occur since both 0x100-0 and (0x00 XOR 0xFF)+1 equal 0x100. If the checksum is correctly calculated, adding all the bytes (the Byte count, both bytes in Address, the Record type, each Data byte and the Checksum) together will always result in a value wherein the least significant byte is zero (0x00).
					For example, on :0300300002337A1E
					03 + 00 + 30 + 00 + 02 + 33 + 7A = E2, 2's complement is 1E
		"""

		data = []
		old_address = 0
		max_address = 0
		address_Hi	= 0

		# read hex file
		# ------------------------------------------------------------------------

		fichier = open(filename,'r')
		lines = fichier.readlines()
		fichier.close()

		# 1st pass : calculate checksum and max address
		# ------------------------------------------------------------------------

		for line in lines:
			byte_count = int(line[1:3], 16)
			address_Lo = int(line[3:7], 16) # lower 16 bits (bits 0-15) of the data address
			record_type= int(line[7:9], 16)

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
			#if record_type == self.Extended_Linear_Address_Record:
			#	address_Hi = int(line[9:13], 16) << 16 # upper 16 bits (bits 16-31) of the data address

			if (address_Lo > old_address): #and (address < board.memend):
				max_address = address_Lo + byte_count
				old_address = address_Lo

		max_address = max_address + 64 - (max_address % 64)            
		self.txtWrite(output, "%d bytes to write\n" % max_address)

		# fill data sequence with 0xFF
		# ------------------------------------------------------------------------

		for i in range(max_address):
			data.append(0xFF)

		# 2nd pass : parse bytes from line into data
		# ------------------------------------------------------------------------

		for line in lines:
			byte_count = int(line[1:3], 16)
			address_Lo = int(line[3:7], 16) # four hex digits
			record_type= int(line[7:9], 16)

			# data record
			if record_type == self.Data_Record:
				if address_Lo >= board.memstart and address_Lo < board.memend:
					for i in range(0, byte_count):
						data[address_Lo + i] = int(line[9 + (2 * i) : 11 + (2 * i)], 16)
				else:
					return self.ERR_HEX_RECORD

			# end of file record
			elif record_type == self.End_Of_File_Record:
				break

			# extended linear address record
			elif record_type == self.Extended_Linear_Address_Record:
				address_Hi = int(line[9:13], 16) # upper 16 bits (bits 16-31) of the data address

			# unsupported record type
			else:
				return self.ERR_HEX_RECORD

		# ------------------------------------------------------------------------

		index = 0
		usbBuf = []

		if self.endpoint == self.MCC_IN_EP:
			blocksize = 64
		else:
			blocksize = 32

		address_Hi = address_Hi << 16

		self.txtWrite(output, "writing ")
		for i in range(board.memstart, max_address):
			if i % 64 == 0:
				self.eraseBlock(handle, i)
			if i % blocksize == 0:
				index = 0
				if usbBuf != []:
					self.issueBlock(output, handle, address_Hi + i - blocksize, usbBuf)
				usbBuf = []
			if data[i] != []:
				usbBuf.append(data[i])
			index += 1 
		self.txtWrite(output, "\n")
		
		#if self.endpoint == self.MCC_IN_EP:
		#	self.txtWrite(output, "completing ...\n")
		#	readbyte0 = self.MCC_PROGRAM_COMPLETE_CMD
		#	handle.interruptWrite(self.MCC_OUT_EP, usbBuf, 200)
		#	self.txtWrite(output, "resetting device ...\n")
		#	usbBuf = chr(self.MCC_RESET_DEVICE_CMD)
		#	handle.interruptWrite(self.MCC_OUT_EP, usbBuf, 200)

		return self.ERR_NONE
# ------------------------------------------------------------------------------
	def txtWrite(self, output, message):
		""" display message in the log window """
		#if gui==True:
		output.WriteText(message)
		#else:
		#	print message
		return  
# ------------------------------------------------------------------------------
	def release(self, handle):
		""" release USB interface """
		handle.releaseInterface()
# ------------------------------------------------------------------------------
	def writeHex(self, output, filename, board):
		device = self.getDevices(board)
		if device is self.ERR_DEVICE_NOT_FOUND:
			self.txtWrite(output, "Pinguino not found\n")
			return
		handle = self.initDevice(device, board)
		if handle is self.ERR_USB_INIT1:
			self.txtWrite(output, "Upload not possible : is device in bootloader mode ?\n")
			return
		#self.getDeviceFamily(self, handle):
		#self.getProgramMemory(self, handle):
		if filename != '':
			status = self.hexWrite(output, handle, filename, board)
			if status == self.ERR_NONE: self.txtWrite(os.path.basename(filename) + " successfully uploaded\n")
			if status == self.ERR_HEX_RECORD: self.txtWrite(output, "Record error\n")
			if status == self.ERR_HEX_CHECKSUM: self.txtWrite(output, "Checksum error\n")
		else:
			self.txtWrite(output, "Nothing to write\n")
		self.release(handle)
# ------------------------------------------------------------------------------

