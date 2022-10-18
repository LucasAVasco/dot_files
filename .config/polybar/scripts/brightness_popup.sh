#!/bin/bash


# Gets brightness value
declare -i CURRENT_BRIGHTNESS_PERCENT=$(($(brightnessctl g)*100/$(brightnessctl m)))


# Fixs logarithmic behavior
CURRENT_BRIGHTNESS_PERCENT=$(\
	bc -l <<< "l(${CURRENT_BRIGHTNESS_PERCENT})*100/l(100)" | \
	sed 's/\..*$//g')

echo "$CURRENT_BRIGHTNESS_PERCENT" > /tmp/current-brightness-percent.txt


# Loop that sets the brightness to value written to '/tmp/current-brightness-percent.txt'
{
while [ -f /tmp/current-brightness-percent.txt ]; do
	NEW_BRIGHTNESS=$(tail -n 1 /tmp/current-brightness-percent.txt 2> /dev/null | sed -z 's/\n//g')

	# If is a valid number
	if [ "$NEW_BRIGHTNESS" != '' ]; then
		# New brightness value (exponential behavior)
		NEW_BRIGHTNESS=$(bc -l <<< "e(${NEW_BRIGHTNESS}*l(100)/100)" | sed 's/\..*$//g')
		brightnessctl -q s "${NEW_BRIGHTNESS}%"
	fi

	sleep 0.01
done
} &


# Popup that writes brightness percentage to '/tmp/current-brightness-percent.txt'
zenity --scale --print-partial --hide-value \
	--name=brightness_popup_bspwm \
	--class=brightness_popup_bspwm \
	--text='Brightness:' \
	--value="$CURRENT_BRIGHTNESS_PERCENT" \
	--min-value=0 \
	--max-value=100 \
	--step=1 > /tmp/current-brightness-percent.txt


# Removes file to stop the loop
rm /tmp/current-brightness-percent.txt
