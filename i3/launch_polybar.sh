#!/bin/bash

# script to launch polybar on multiple monitors

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -c ~/.config/polybar/config.ini main --reload  &
  done
else
   polybar -c ~/.config/polybar/config.ini main --reload  &
fi

