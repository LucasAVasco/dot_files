#!/bin/bash


# Gets the brightness value and calculates the percentage to add
declare -i CURRENT_BRIGHTNESS_PERCENT=$(($(brightnessctl g)*100/$(brightnessctl m)))
ADD_BRIGHTNESS_PERCENT=$(bc -l <<< "e(${CURRENT_BRIGHTNESS_PERCENT}*l(50)/100)" | sed 's/\..*$//g')

# Adds brightness
if [ "$1" == '+' ]; then
	brightnessctl -q s "+${ADD_BRIGHTNESS_PERCENT}%"

# Subtracts brightness
elif [ "$1" == '-' ]; then
	# Doesn't blanks the screen
	if [ "$CURRENT_BRIGHTNESS_PERCENT" -gt "$ADD_BRIGHTNESS_PERCENT" ]; then
		brightnessctl -q s "${ADD_BRIGHTNESS_PERCENT}%-"
	fi
fi

# Minimun brightness (doesn't blanks the screen)
if [ "$(brightnessctl g)" == 0 ]; then
	brightnessctl -q s 1
fi
