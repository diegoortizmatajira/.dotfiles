#!/bin/sh
pgrep 'xkeysnail' | xargs -r -n1 sudo kill
sudo -K # remove privilege
# No dups should exist
exit 0
