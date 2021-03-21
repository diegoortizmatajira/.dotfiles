#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
for m in $(polybar --list-monitors | grep "(primary)" | cut -d":" -f1); do
    MONITOR=$m polybar primary-bar &
    # MONITOR=$m polybar --reload basic-bar &
done

for m in $(polybar --list-monitors | grep -v "(primary)" | cut -d":" -f1); do
    MONITOR=$m polybar basic-bar &
    # MONITOR=$m polybar --reload basic-bar &
done

echo "Polybar launched..."
