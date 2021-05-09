#!/bin/sh
TITLES=()
COMMANDS=()

TITLES[0]="Fully Docked (HDMI+VGA+Laptop)"
COMMANDS[0]="layout-docked"

TITLES[1]="Undocked (Only Laptop)"
COMMANDS[1]="layout-undocked"

TITLES[2]="Partially Docked (HDMI+Laptop)"
COMMANDS[2]="layout-partially-docked-1"

TITLES[3]="Partially Docked (VGA+Laptop)"
COMMANDS[3]="layout-partially-docked-2"

TITLES[4]="TV Plugged (TV+Laptop)"
COMMANDS[4]="layout-tv"

TITLES[5]="Manual setup"
COMMANDS[5]="arandr"

function getOptions() {
    for item in "${TITLES[@]}"; do
        echo $item
    done
}

SEL=$(getOptions | rofi -dmenu -p "Display Layout" -format i -lines 6 -width 30)

if [ $SEL == "" ] 
then
    echo "Cancelled"
else
    ${COMMANDS[$SEL]} && i3-msg restart
fi
