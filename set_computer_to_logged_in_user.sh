#!/bin/sh
#Changing computer name to logged in user.
export LOCALMACHINENAME=$(ls -l /dev/console | cut -d " " -f4)
/usr/sbin/networksetup -setcomputername "$LOCALMACHINENAME“

