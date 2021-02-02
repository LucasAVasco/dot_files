#!/bin/bash

if [ "$1" = '+' ]; then    # Add 10 to brightness
	brightnessctl -q s +10

elif [ "$1" = '-' ]; then  # Subtracts 10 to brightness

	if [ "$(brightnessctl g)" -gt '15' ]; then
		brightnessctl -q s 10-
	fi

elif [ "$1" = '' ]; then
	brightnessctl -q s 15
fi
