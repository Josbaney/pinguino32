#!/usr/bin/env python
# -*- coding: iso-8859-15 -*-

"""-------------------------------------------------------------------------
	Pinguino version control interface for Subversion

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

import pysvn		# checked in check.py
import os

#	-----------------------------------------------------------------------------

class VersionControlError(Exception):
	pass

#	-----------------------------------------------------------------------------

class Repository(object):
	
	def __init__(self, url):
		if url == ".":
			url = os.path.abspath(url)
		self.url = url
		
	def __str__(self):
		return "%s at %s" % (self.__class__.__name__, self.url)
	
	def __eq__(self, other):
		return self.__class__ == other.__class__ and self.url == other.url
	
	def __ne__(self, other):
		return not self.__eq__(other)

	def __getstate__(self):
		"""For pickling"""
		return {'url': self.url}

	def __setstate__(self, state):
		"""For unpickling"""
		self.__init__(state['url'])

#	-----------------------------------------------------------------------------

class WorkingCopy(object):
	
	def __eq__(self, other):
		return (self.repository == other.repository) and (self.path == other.path) \
			and (self.current_version() == other.current_version()) #and (self.diff() == other.diff())
			
	def __ne__(self, other):
		return not self.__eq__(other)

#	-----------------------------------------------------------------------------

class SubversionWorkingCopy(WorkingCopy):
	
	def __init__(self, path=None):
		WorkingCopy.__init__(self)
		self.path = os.path.realpath(path or os.getcwd())
		if os.path.exists(os.path.join(self.path, ".svn")):
			client = pysvn.Client()
			url = client.info(self.path).url
			self.repository = SubversionRepository(url)

	def current_version(self):
		try :
			return str(self.repository._client.info(self.path).revision.number)
		except:
			return "unknown"

	def use_version(self, version):
		self.repository._client.update(
			self.path,
			revision=pysvn.Revision(pysvn.opt_revision_kind.number, int(version)))

	def use_latest_version(self):
		self.repository._client.update(self.path)

	def status(self):
		changes = self.repository._client.status(self.path)
		status_dict = {}
		status_dict['modified'] = [f.path for f in changes if f.text_status == pysvn.wc_status_kind.modified]
		status_dict['added'] = [f.path for f in changes if f.text_status == pysvn.wc_status_kind.added]
		status_dict['removed'] = [f.path for f in changes if f.text_status == pysvn.wc_status_kind.deleted]
		status_dict['deleted'] = [f.path for f in changes if f.text_status == pysvn.wc_status_kind.missing]
		status_dict['unknown'] = [f.path for f in changes if f.text_status == pysvn.wc_status_kind.unversioned]
		status_dict['clean'] = [f.path for f in changes if f.text_status == pysvn.wc_status_kind.normal]
		return status_dict

	def has_changed(self):
		status = self.status()
		changed = False
		for st in 'modified', 'removed', 'deleted':
			if status[st]:
				changed = True
				break
		return changed
	
	def diff(self):
		"""Difference between working copy and repository."""
		return self.repository._client.diff('./tmp-', self.path)

#	-----------------------------------------------------------------------------

class SubversionRepository(Repository):
	
	def __init__(self, url):
		Repository.__init__(self, url)
		self._client = pysvn.Client()
		# check that there is a valid Subversion repository at the URL, without doing a checkout.
		try:
			self._client.ls(url)
		except pysvn._pysvn.ClientError, errmsg:
			raise VersionControlError(errmsg)
	
	def current_version(self):
		print "Contacting svn server ..."
		rev = pysvn.Revision(pysvn.opt_revision_kind.head)
		info = self._client.info2(self.url, revision = rev, recurse = False)
		return str(info[0][1].rev.number)

	def checkout(self, path='.'):
		try:
			self._client.checkout(self.url, path)
		except pysvn._pysvn.ClientError: # assume this is an 'object of the same name already exists' error
			repos_contents = self._client.ls(self.url)
			os.mkdir(".backup")
			for entry in repos_contents:
				filename = entry["name"][len(self.url)+1:]
				if os.path.exists(filename):
					os.rename(filename,os.path.join(".backup", filename))
			self._client.checkout(self.url, path)

	def get_working_copy(self, path=None):
		return get_working_copy(path)

