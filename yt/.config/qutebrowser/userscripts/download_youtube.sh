#!/bin/bash
yt-dlp -f "best[height<=720]" -o "~/Videos/%(title)s.%(ext)s" "$QUTE_URL"
notify-send "Download started" "$QUTE_URL"
