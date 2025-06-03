#!/bin/bash

# Notifies and optionally suspends system at low battery

critical_level=15
battery=$(upower -i $(upower -e | grep 'BAT') | awk '/percentage:/ {gsub("%",""); print $2}')

if [ "$battery" -lt "$critical_level" ]; then
    dunstify -u critical "⚠️ Battery Low" "Battery at ${battery}%. Plug in the charger!" -h string:x-dunst-stack-tag:battery
fi

