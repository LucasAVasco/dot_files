#!/bin/bash


# Get the CONTENT
declare -i DESKTOPS_NUMBER=$(chdesk ls | wc -l)-2
CONTENT=$(chdesk ls | sed -n "1,${DESKTOPS_NUMBER}p")

# Display Rofi
SELECTED_DESKTOP=$(echo -en "$CONTENT" | rofi -theme themes/chdesk.rasi -p 'Desktops:' -dmenu)

# Change to SELECTED_DESKTOP
if [ "$SELECTED_DESKTOP" != '' ]; then
	chdesk change "$SELECTED_DESKTOP"
fi
