#!/bin/bash


# Battery file prefix
cat /sys/class/power_supply/*/energy_full > '/dev/null' 2> '/dev/null' && \
	PREFIX='energy'

cat /sys/class/power_supply/*/charge_full > '/dev/null' 2> '/dev/null' && \
	PREFIX='charge'


# Print battery information if there is any
if [ "$PREFIX" != '' ]; then
	# Calculations
	declare -i BATTERY_FULL=$(cat /sys/class/power_supply/BAT*/${PREFIX}_full | sed -n '1p')
	declare -i BATTERY_NOW=$(cat /sys/class/power_supply/BAT*/${PREFIX}_now | sed -n '1p')
	declare -i BATTERY_PERC=$BATTERY_NOW*100/$BATTERY_FULL

	# Icons
	ICON=''
	declare -i SELECTED_ICON=${BATTERY_PERC}/20-1

	# Output
	echo "   ${ICON:${SELECTED_ICON}:1} ${BATTERY_PERC}% "

	# Send a notification if battery is lower than 25%
	if [ "$BATTERY_PERC" -lt '25' ]; then
		notify-send -u critical -i battery-caution 'Low battery!' 'Connect to Charger'

		# Shutdown if the battery is lower than 15%
		if [ "$BATTERY_PERC" -lt '15' ]; then
			shutdown now
		fi
	fi
fi
