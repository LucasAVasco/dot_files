#!/bin/bash


# Compton dbus informations
DEST=com.github.chjj.compton.$(echo "$DISPLAY" | sed 's/[^1-9^a-z^A-Z]/_/g')
OBJECT="/com/github/chjj/compton"
INTERFACE=com.github.chjj.compton.opts_set

# Send a dbus message to compton
SEND_MESSAGE_TO_COMPTON()
{
	# $@: Dbus contents that will be send to compton (see 'man dbus-send' for more information)

	dbus-send --print-reply --dest="$DEST" "$OBJECT" "$INTERFACE" $@
}


CONFIG_FILE=~/.config/compton.conf

# Get the compton attribute value defined in 'CONFIG_FILE'
# Return '' if the 'CONFIG_FILE' does't define the attribute
GET_COMPTON_ATTRIBUTE()
{
	# $1: Name of attribute

	cat "$CONFIG_FILE" | awk "/^$1 *= */" | sed -n '1p' | sed 's/.*= *//g' | sed 's/;$//'
}


# If the value is '', return '0'
SET_0_IF_NULL()
{
	# $1: Value

	if [ "$1" == '' ]; then
		echo '0'
	else
		echo "$1"
	fi
}
