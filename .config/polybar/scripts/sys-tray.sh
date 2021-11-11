#!/bin/bash

# $1: Option
# $2: Polybar theme name


# Reset default system tray bar (also excludes expanded system tray)
RESET_SYSTEM_TRAY()
{
	pkill stalonetray
	pkill -USR1 -f 'polybar system-tray'
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
		pkill stalonetray && \
			{
				RESET_SYSTEM_TRAY &
			} || \
				OPEN_EXPANDED_SYSTEM_TRAY "$2"
		;;

	# Closes expanded system tray and reloads default system tray
	"reload" | "reset" )
		RESET_SYSTEM_TRAY &
		;;
esac
