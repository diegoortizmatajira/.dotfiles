#!/bin/sh
TITLES=()
COMMANDS=()

TITLES[0]="Auto-Detect"
COMMANDS[0]="autorandr"

TITLES[1]="Fully Docked (HDMI+VGA+Laptop)"
COMMANDS[1]="autorandr FullyDocked"

TITLES[2]="Undocked (Only Laptop)"
COMMANDS[2]="autorandr UnDocked"

TITLES[3]="Partially Docked (HDMI+Laptop)"
COMMANDS[3]="autorandr PartiallyDockedHDMI"

TITLES[4]="Partially Docked (VGA+Laptop)"
COMMANDS[4]="autorandr PartiallyDocked"

TITLES[5]="TV Plugged (TV+Laptop)"
COMMANDS[5]="autorandr TV"

TITLES[6]="Manual setup"
COMMANDS[6]="arandr"

function getOptions() {
    for item in "${TITLES[@]}"; do
        echo $item
    done
}

SEL=$(getOptions | rofi -dmenu -p "Display Layout" -format i -lines 7 -width 30)

if [ $SEL == "" ]; then
    echo "Cancelled"
    else
    ${COMMANDS[$SEL]} 
    # ${COMMANDS[$SEL]} && i3-msg restart
fi
