#!/bin/bash


# Battery file prefix
cat /sys/class/power_supply/*/energy_full > '/dev/null' 2> '/dev/null' && \
	PREFIX='energy'

cat /sys/class/power_supply/*/charge_full > '/dev/null' 2> '/dev/null' && \
	PREFIX='charge'


# Prints battery information if there is any
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

	if [ "$BATTERY_PERC" -lt '20' ]; then
		# Sends a notification if battery is lower than 20%
		if [ ! -f /tmp/ignore_battery_low_notify_custom_desktop ]; then
			notify-send -u critical -i battery-caution 'Low battery!' "Battery is ${BATTERY_PERC}%\nConnect to Charger"
		fi

		# Whether to shutdown at minimum power
		SHUTDOWN_ON_LOW_POWER=$(dconf read /custom-desktop/power/shutdown_on_low_power)
		
		if [ "$SHUTDOWN_ON_LOW_POWER" == '' ]; then
			dconf write /custom-desktop/power/shutdown_on_low_power true
			SHUTDOWN_ON_LOW_POWER=true
		fi

		# Low power percentage
		LOW_POWER_PERCENTAGE=$(dconf read /custom-desktop/power/low_power_percentage)

		if [ "$LOW_POWER_PERCENTAGE" == '' ]; then
			dconf write /custom-desktop/power/low_power_percentage 15
			LOW_POWER_PERCENTAGE=15
		fi

		# Shutdown if the battery is lower than minimum percentage
		if [ "$BATTERY_PERC" -lt "$LOW_POWER_PERCENTAGE" -a "$SHUTDOWN_ON_LOW_POWER" == 'true' ]; then
			shutdown now
		fi
	fi
fi
