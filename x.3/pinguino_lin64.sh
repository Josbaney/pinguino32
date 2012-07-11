#!/bin/bash

#Loader for Linux 64 bits
# 03-03-2012 - First version - Marcus Fazzi <marcus@fazzi.eng.br>

LOCALPATH=$(pwd)
LD_LIBRARY_PATH=/usr/lib32:${LOCALPATH}/linux/p32/bin:/usr/lib:/usr/lib64 ./pinguino.py
