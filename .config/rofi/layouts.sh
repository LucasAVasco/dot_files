#!/bin/bash


# Remove backup files
rm ~/.config/bspwm/layouts/*~ 2> '/dev/null'

# Get the layouts names
LAYOUTS=$(bspc-layout ls)

# Get the CONTENT
CONTENT=''
for loop in $LAYOUTS; do
	CONTENT+="$loop\0icon\x1f$HOME/.config/bspwm/icons/$loop.png\n"
done

# Display Rofi
SELECTED_LAYOUT=$(echo -en "$CONTENT" | rofi -theme themes/bspc-layouts.rasi -p 'Layout: ' -dmenu)

# Change to SELECTED_LAYOUT
if [ "$SELECTED_LAYOUT" != '' ]; then
	bspc-layout change $SELECTED_LAYOUT
fi
