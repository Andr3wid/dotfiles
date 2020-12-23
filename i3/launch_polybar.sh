#!/bin/bash

# script to launch polybar on multiple monitors

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m ~/.config/polybar/launch.sh
  done
else
   ~/.config/polybar/launch.sh
fi

