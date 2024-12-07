#!/bin/sh
if [ ${EUID} -ne 0 ]
then
    echo "mac-keys-start should be run as root"
	exit 1 # this is meant to be run as root
fi
xhost +SI:localuser:root
xkeysnail --quiet  /opt/mac-keys/mac-keys.py --watch
