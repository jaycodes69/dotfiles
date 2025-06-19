#!/usr/bin/env bash

# Kill existing Waybar instances
pkill -x waybar

# Wait for process termination
while pgrep -x waybar >/dev/null; do sleep 0.1; done

# Optional: Log file for debugging
LOGFILE="$HOME/.cache/waybar.log"
mkdir -p "$(dirname "$LOGFILE")"

# Launch Waybar and redirect output to log file
waybar >"$LOGFILE" 2>&1 &

