#!/bin/bash

# Calculations
declare -i BATTERY_FULL=$(cat /sys/class/power_supply/*/energy_full | sed -n '1p')
declare -i BATTERY_NOW=$(cat /sys/class/power_supply/*/energy_now | sed -n '1p')
declare -i BATTERY_PERC=$BATTERY_NOW*100/$BATTERY_FULL

# Icons
ICON=''
declare -i SELECTED_ICON=${BATTERY_PERC}/20-1

# Output
echo " ${ICON:${SELECTED_ICON}:1} ${BATTERY_PERC}% "

# Unset
unset BATTERY_PERC BATTERY_FULL BATTERY_NOW ICON SELECTED_ICON
