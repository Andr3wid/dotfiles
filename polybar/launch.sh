#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
if [ "$1" == "light" ]
then
	polybar -c $HOME/.config/polybar/light-config nord-top --reload &
	polybar -c $HOME/.config/polybar/light-config nord-down --reload &
else
	polybar -c $HOME/.config/polybar/dark-config nord-top --reload &
	polybar -c $HOME/.config/polybar/dark-config nord-down --reload &
fi

echo "Bars launched..."
