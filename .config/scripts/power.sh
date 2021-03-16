#!/usr/bin/env bash

name="power"

shutdown=""
reboot=""
suspend=""
lock=""
logout=""

options="$shutdown\n$reboot\n$suspend\n$lock\n$logout"

uptime="$(uptime -p | sed 's/up //g')"

action=$(echo -e "$options" | rofi -theme power -dmenu -p "Uptime: $uptime")

case $action in
	$shutdown)
		systemctl poweroff
		;;
	$reboot)
		systemctl reboot
		;;
	$suspend)
		systemctl suspend
		;;
	$lock)
		if [[ -f /usr/bin/i3lock ]]; then
			i3lock
		elif [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		fi
        ;;
    $logout)
		if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
			openbox --exit
		elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
			bspc quit
		elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
			i3-msg exit
		fi
		;;
esac