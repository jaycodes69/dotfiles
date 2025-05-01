#!/bin/bash

PIDFILE="/tmp/waybar.pid"

if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")
    if kill -0 "$PID" 2>/dev/null; then
        kill "$PID"
        rm "$PIDFILE"
        notify-send "Waybar" "Stopped"
        exit 0
    else
        rm "$PIDFILE"
    fi
fi

# Launch Waybar and save its PID
waybar &
echo $! > "$PIDFILE"
notify-send "Waybar" "Started"

