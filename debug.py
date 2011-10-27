#!/usr/bin/env python
#  -*- coding: UTF-8 -*-

import serial
import threading

class debug(threading.Thread):
	def __init__(self, ser):
		threading.Thread.__init__(self)
		self.ser = ser
		self._stopevent = threading.Event()
	def run(self):
		while not self._stopevent.isSet():
			if self.ser:
				print self.ser.readline()
			else:
				print "No device connected"
			self._stopevent.wait(2.0)
	def stop(self):
		self._stopevent.set()

t = debug(serial.Serial('/dev/ttyACM0'))

t.start()
t.stop()

