#!/bin/bash

# $1: Option
# $2: Polybar theme name


# Reset compton (fix shadows of default system tray bar)
RESET_COMPTON()
{
	pkill compton
	compton --dbus &
}


# Open expanded system tray (The default system tray will be hidden automatically)
OPEN_EXPANDED_SYSTEM_TRAY()
{
	# $1: Polybar theme name

	stalonetray -c ~/.config/polybar/bars/"$1"/stalonetrayrc
}


case "$1" in
	# Switches between default system tray and expanded system tray
	"switch" )
		pkill stalonetray || \
			OPEN_EXPANDED_SYSTEM_TRAY "$2"
		;;

	# Closes the expanded system tray and reloads compton
	"reload" | "reset" )
		pkill stalonetray
		RESET_COMPTON &
		;;
esac
