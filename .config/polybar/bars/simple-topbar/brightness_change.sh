#!/bin/bash


declare -i MIN_VALUE="$(brightnessctl m)/15"


if [ "$1" = '+' ]; then    # Adds 10% to brightness
	brightnessctl -q s +10%

elif [ "$1" = '-' ]; then  # Subtractes 10% to brightness
	if [ "$(brightnessctl g)" -gt "$MIN_VALUE" ]; then
		brightnessctl -q s 10%-
	fi

elif [ "$1" = '' ]; then   # Sets 15% to brightness
	brightnessctl -q s 15%
fi

# Fixes the brightness if it bypassed the minimum value
if [ "$(brightnessctl g)" -lt "$MIN_VALUE" ]; then
	brightnessctl -q s 15%
fi
