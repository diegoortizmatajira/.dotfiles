#!/bin/sh
EXTERNAL0=DP-0
EXTERNAL1=DP-2
EXTERNAL2=HDMI-0
case $1 in
    'primary-only')
        echo "Leaving only primary display on"
        xrandr --output $EXTERNAL1 --off
        ;;
    'all-external')
        echo "Turning on all external displays"
        xrandr --output $EXTERNAL1 --auto --left-of $EXTERNAL0
        ;;
    'tv-only')
        echo "Turning on TV only"
        xrandr --output $EXTERNAL1 --off --output $EXTERNAL0 --off
        ;;
    *)
        echo "Use 'primary-only' or 'all-external'."
        ;;
esac
