#!/usr/bin/env bash

# from https://www.reddit.com/r/swaywm/comments/m3sbge/how_do_i_get_battery_percentage_in_sway_config/

# Battery
battery=$(acpi | cut -f 4,4 -d " " | cut -f 1,1 -d ",")

# Date
date=$(date "+%a %F %R")

# CPU temp
cpu=$(sensors | grep "Package" | cut -f 4,5 -d " ")

# Alsa master volume
volume=$(amixer get Master | sed -n 's/.*\[\(.*\)\%\].*/\1\%/gp')

# Status bar
echo "battery:" $battery "|" $cpu "| vol:" $volume "|" $date
