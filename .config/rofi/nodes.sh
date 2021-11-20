#!/bin/bash


# Node flags information
NODE_INFORMATION=$(bspc query -T -n) || exit

GET_NODE_FLAG_STATE()
{
	# Get the state of a flag of the current node

	# Parameters:
	# $1: Flag name

	# Return:
	# 'true' or 'false'

	TEXT_WITH_STATE_TRUE=$(echo "$NODE_INFORMATION" | awk "/\"$1\":true/")

	if [ "$TEXT_WITH_STATE_TRUE" != '' ]; then
		echo true
	else
		echo false
	fi
}

IS_STICKY=$(GET_NODE_FLAG_STATE sticky)
IS_PRIVATE=$(GET_NODE_FLAG_STATE private)
IS_LOCKED=$(GET_NODE_FLAG_STATE locked)
IS_MARKED=$(GET_NODE_FLAG_STATE marked)

# Node layer information
LAYER=$(echo "$NODE_INFORMATION" | sed 's/^.*"layer":"//g' | sed 's/".*$//g')

IS_BELOW='false'
IS_NORMAL='false'
IS_ABOVE='false'

if [ "$LAYER" == 'below' ]; then
	IS_BELOW='true'
elif [ "$LAYER" == 'normal' ]; then
	IS_NORMAL='true'
elif [ "$LAYER" == 'above' ]; then
	IS_ABOVE='true'
fi


# Content to be sent to Rofi
ADD_MARKER()
{
	# Add a marker icon that indicates if the option is enabled

	# Parameters:
	# $1: 'true' or 'false'. If it's 'true', return the marker

	# Return:
	# A string that shows the marker when sent to Rofi

	if [ "$1" == 'true' ]; then
		echo '\0icon\x1f'"$HOME/.config/rofi/icons/blue-circle.png"
	fi
}

CONTENT='Hidden\n'
CONTENT="${CONTENT}Sticky"$(ADD_MARKER $IS_STICKY)'\n'
CONTENT="${CONTENT}Private"$(ADD_MARKER $IS_PRIVATE)'\n'
CONTENT="${CONTENT}Marked"$(ADD_MARKER $IS_MARKED)'\n'
CONTENT="${CONTENT}Locked"$(ADD_MARKER $IS_LOCKED)'\n'
CONTENT="${CONTENT}Below"$(ADD_MARKER $IS_BELOW)'\n'
CONTENT="${CONTENT}Normal"$(ADD_MARKER $IS_NORMAL)'\n'
CONTENT="${CONTENT}Above"$(ADD_MARKER $IS_ABOVE)'\n'

# Runs Rofi
SELECTED_OPTION=$(echo -en "$CONTENT" | rofi -theme themes/nodes.rasi -dmenu)

# Changes the option state
case "$SELECTED_OPTION" in
	'Hidden' ) bspc node --flag hidden;;
	'Sticky' ) bspc node --flag sticky;;
	'Private' ) bspc node --flag private;;
	'Marked' ) bspc node --flag marked;;
	'Locked' ) bspc node --flag locked;;
	'Below' ) bspc node --layer below;;
	'Normal' ) bspc node --layer normal;;
	'Above' ) bspc node --layer above;;
esac
