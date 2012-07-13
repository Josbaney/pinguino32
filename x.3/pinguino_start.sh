#!/bin/sh

# Pinguino start-script for Linux
## ...based on pinguino_lin64.sh (Marcus Fazzi) and arduino's start-script

LOCALPATH="$(dirname -- $(readlink -f -- "${0}") )"
cd $LOCALPATH

# Set LD_LIBRARY_PATH to have our libs take precedence over what may be installed
ARCH=$(arch)
case $ARCH in
    *64 )
    # catch "ia64" (Itanium) and  "x86_64" 
         LD_LIBRARY_PATH=/usr/lib32:${LOCALPATH}/linux/p32/bin:/usr/lib:/usr/lib64     
	 ;;
    * )
    # i386 and the rest land here.
        LD_LIBRARY_PATH=/usr/lib32:${LOCALPATH}/linux/p32/bin:/usr/lib
	;;
esac

export LD_LIBRARY_PATH
python ./pinguino.py $@

