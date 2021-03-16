#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

bars="left right"
args="-c $HOME/.config/polybar/config.ini"

for i in $bars; do
	echo "--- Polybar ($i) ---" | tee -a /tmp/polybar-$i.log
	polybar $args $i >> /tmp/polybar-$i.log 2>&1 & disown
done

# Launch bar1 and bar2
#echo "---" | tee -a /tmp/polybar1.log
#polybar left >>/tmp/polybar1.log 2>&1 & disown
#polybar right>>/tmp/polybar2.log 2>&1 & disown

echo "Bars launched..."
