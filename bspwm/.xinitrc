#!/bin/sh

setxkbmap -option caps:swapescape
eval "$(dbus-launch --sh-syntax)"
dunst &
exec bspwm
