#!/bin/bash


GET_DEVICE_ID()
{
	# $1: Device name

	xinput list | grep "$1" | sed -n '1p' | sed 's/.*id=//' | sed 's/[ \t].*//'
}

GET_DEVICE_OPTION_ID()
{
	# $1: Device name
	# $2: Device option name

	DEVICE_ID=$(GET_DEVICE_ID "$1")

	# Doesn't return if there aren't this device
	if [ "$DEVICE_ID" != '' ]; then
		OPTION_LINE=$(xinput list-props "$DEVICE_ID" | grep "$2" | sed -n '1p')

		# Doesn't return if this device hasn't this option
		if [ "$(echo "$OPTION_LINE" | awk '/\(/')" != '' ]; then
			echo $OPTION_LINE | sed 's/).*$//' | sed 's/^.*(//'
		fi
	fi
}

SET_DEVICE_OPTION()
{
	# $1: Device name
	# $2: Device option name
	# $3: Option value

	DEVICE_ID=$(GET_DEVICE_ID "$1") && \
	OPTION_ID=$(GET_DEVICE_OPTION_ID "$1" "$2") && \

	# Doesn't set if there aren't this device
	if [ "$DEVICE_ID" == '' ]; then
		echo "There aren't this device!"

	# Doesn't set if this device there aren't this option
	elif [ "$OPTION_ID" == '' ]; then
		echo "There aren't this option!"

	# Sets the option
	else
		xinput set-prop "$DEVICE_ID" "$OPTION_ID" "$3"
	fi
}


# Enable Touchpad Tapping
SET_DEVICE_OPTION "Touchpad" "libinput Tapping Enabled" "1"
