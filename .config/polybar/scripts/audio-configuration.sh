#!/bin/bash


case "$1" in
	left )
		pulseaudio --start ; pavucontrol &
		;;

	right )
		pkill pulseaudio ; pulseaudio --start ; pavucontrol &
		;;

	* )
		pulseaudio --start ; pavucontrol &
		;;
esac
