#!/bin/bash

# Universal control + info script with notifications
# Supports volume, brightness, battery, time & status

ICON_VOLUME="🔊"
ICON_MUTED="🔇"
ICON_BRIGHTNESS="🔆"
ICON_BATTERY_FULL="🔋"
ICON_BATTERY_CHARGING="⚡"
ICON_BATTERY_LOW="🪫"
ICON_TIME="⏰"

BATTERY_PATH="/sys/class/power_supply/BAT0"

notify_volume() {
    local vol=$1
    local muted=$2
    local icon=$([ "$muted" == "true" ] && echo "$ICON_MUTED" || echo "$ICON_VOLUME")

    dunstify -a volume -r 5555 "$icon Volume" "$vol%" \
        -h int:value:"$vol" -t 1500 -h string:x-dunst-stack-tag:volume
}

notify_brightness() {
    local bright=$1

    dunstify -a brightness -r 6666 "$ICON_BRIGHTNESS Brightness" "$bright%" \
        -h int:value:"$bright" -t 1500 -h string:x-dunst-stack-tag:brightness
}

notify_battery() {
    local percent=$1
    local status=$2
    local icon
    local urgency="normal"
    local message="Battery: $percent% ($status)"
    local time_left=""

    # Try to get battery runtime (seconds), fallback empty if no info
    if [ -f "$BATTERY_PATH/energy_now" ] && [ -f "$BATTERY_PATH/power_now" ]; then
        local energy_now=$(cat "$BATTERY_PATH/energy_now")
        local power_now=$(cat "$BATTERY_PATH/power_now")
        if [[ $power_now -ne 0 ]]; then
            local seconds_left=$((energy_now * 3600 / power_now))
            local hours=$((seconds_left / 3600))
            local minutes=$(((seconds_left % 3600) / 60))
            time_left=" — ${hours}h ${minutes}m remaining"
        fi
    fi

    if [[ "$status" == "Charging" ]]; then
        icon=$ICON_BATTERY_CHARGING
    else
        if (( percent <= 10 )); then
            icon=$ICON_BATTERY_LOW
            urgency="critical"
            message+=" - Please charge soon!"
        else
            icon=$ICON_BATTERY_FULL
        fi
    fi

    dunstify -a battery -r 7777 -u $urgency "$icon Battery Status" "$message$time_left" \
        -h int:value:"$percent" -t 3000 -h string:x-dunst-stack-tag:battery
}

notify_time() {
    local datetime
    datetime=$(date "+%A, %d %B %Y — %H:%M:%S")
    dunstify -a time -r 8888 "$ICON_TIME Current Time" "$datetime" -t 3000 \
        -h string:x-dunst-stack-tag:time
}

notify_status() {
    # Volume info
    local vol=$(pamixer --get-volume)
    local muted=$(pamixer --get-mute)
    local vol_icon=$([ "$muted" == "true" ] && echo "$ICON_MUTED" || echo "$ICON_VOLUME")

    # Brightness info
    local bright_val=$(brightnessctl get)
    local bright_max=$(brightnessctl max)
    local bright=$(( 100 * bright_val / bright_max ))

    # Battery info
    if [ -d "$BATTERY_PATH" ]; then
        local batt_percent=$(cat "$BATTERY_PATH/capacity")
        local batt_status=$(cat "$BATTERY_PATH/status")
    else
        local batt_percent="N/A"
        local batt_status="No battery"
    fi

    # Time info
    local datetime=$(date "+%A, %d %B %Y — %H:%M")

    # Build message with icons
    local batt_icon=$ICON_BATTERY_FULL
    if [[ "$batt_status" == "Charging" ]]; then
        batt_icon=$ICON_BATTERY_CHARGING
    elif [[ "$batt_percent" != "N/A" ]] && (( batt_percent <= 10 )); then
        batt_icon=$ICON_BATTERY_LOW
    fi

    local status_msg="$vol_icon Volume: $vol% $( [ "$muted" == "true" ] && echo '(muted)' )\n"
    status_msg+="💡 Brightness: $bright%\n"
    status_msg+="$batt_icon Battery: $batt_percent% ($batt_status)\n"
    status_msg+="⏰ Time: $datetime"

    dunstify -a status -r 9999 "System Status Overview" "$status_msg" -t 5000 \
        -h string:x-dunst-stack-tag:status
}

case "$1" in
    volup)
        pamixer -i 5
        ;;
    voldown)
        pamixer -d 5
        ;;
    mute)
        pamixer -t
        ;;
    brightup)
        brightnessctl set +10%
        ;;
    brightdown)
        brightnessctl set 10%-
        ;;
    battery)
        if [ ! -d "$BATTERY_PATH" ]; then
            dunstify -a battery -r 7777 "Battery Info" "No battery detected" -t 2000
            exit 1
        fi
        percent=$(cat "$BATTERY_PATH/capacity")
        status=$(cat "$BATTERY_PATH/status")
        notify_battery "$percent" "$status"
        exit 0
        ;;
    time)
        notify_time
        exit 0
        ;;
    status)
        notify_status
        exit 0
        ;;
    *)
        echo "Usage: $0 {volup|voldown|mute|brightup|brightdown|battery|time|status}"
        exit 1
        ;;
esac

# Notifications for volume and brightness changes

if [[ "$1" == vol* ]]; then
    VOL=$(pamixer --get-volume)
    IS_MUTED=$(pamixer --get-mute)
    notify_volume "$VOL" "$IS_MUTED"
fi

if [[ "$1" == bright* ]]; then
    BRIGHT_RAW=$(brightnessctl get)
    BRIGHT_MAX=$(brightnessctl max)
    PERCENT=$(( 100 * BRIGHT_RAW / BRIGHT_MAX ))
    notify_brightness "$PERCENT"
fi

