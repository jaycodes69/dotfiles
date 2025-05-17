#!/bin/bash

SESSION="popup"
WM_CLASS="DropdownAlacritty"

# Check if already running
if xdotool search --class "$WM_CLASS" >/dev/null 2>&1; then
	# Toggle hide/show using bspc
	bspc node "$(xdotool search --class "$WM_CLASS" | head -n 1)" --flag hidden --toggle
	exit
fi

# Otherwise, spawn it
alacritty \
	--class "$WM_CLASS" \
	-o window.dimensions.columns=100 \
	-o window.dimensions.lines=25 \
	-e tmux new-session -A -s "$SESSION" &
i
