if [[ "$(tty)" == /dev/tty1 ]] && [ -z "$DISPLAY" ] && [ -z "$XDG_SESSION_TYPE" ]; then
  exec startx
fi
