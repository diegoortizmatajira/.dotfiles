#!/bin/sh
TITLES=()
COMMANDS=()

TITLES[0]="Auto-Detect"
COMMANDS[0]="autorandr"

TITLES[1]="0. Undocked (Only Laptop)"
COMMANDS[1]="autorandr UnDocked"

TITLES[2]="1. External Displays Only"
COMMANDS[2]="autorandr ExternalDisplaysOnly"

TITLES[3]="2. External Display HDMI Only"
COMMANDS[3]="autorandr ExternalDisplayHDMI"

TITLES[4]="3. External Display VGA Only"
COMMANDS[4]="autorandr ExternalDisplayVGA"

TITLES[5]="4. Fully Docked (HDMI+VGA+Laptop)"
COMMANDS[5]="autorandr FullyDocked"

TITLES[6]="5. TV Plugged (TV+Laptop)"
COMMANDS[6]="autorandr TV"

TITLES[7]="9. Manual setup"
COMMANDS[7]="arandr"

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
fi
