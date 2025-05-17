#!/bin/bash
# Simple battery status script for tmux status bar

# Check if battery exists
if [ ! -d "/sys/class/power_supply/BAT0" ] && [ ! -d "/sys/class/power_supply/BAT1" ]; then
	echo "⚡" # No battery, AC only
	exit 0
fi

# Determine which battery to use
BATTERY="/sys/class/power_supply/BAT0"
if [ ! -d "$BATTERY" ]; then
	BATTERY="/sys/class/power_supply/BAT1"
fi

# Get battery percentage
CAPACITY=$(cat "$BATTERY/capacity")
STATUS=$(cat "$BATTERY/status")

# Choose appropriate icon
if [ "$STATUS" = "Charging" ]; then
	ICON="⚡"
elif [ $CAPACITY -ge 90 ]; then
	ICON="󰁹" # Full
elif [ $CAPACITY -ge 75 ]; then
	ICON="󰂀" # High
elif [ $CAPACITY -ge 50 ]; then
	ICON="󰁿" # Medium
elif [ $CAPACITY -ge 25 ]; then
	ICON="󰁾" # Low
else
	ICON="󰁻" # Critical
fi

# Output format optimized for tmux status bar
echo "$ICON $CAPACITY%"
