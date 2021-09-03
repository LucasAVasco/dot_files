#!/bin/bash


case "$1" in
	left )
		nm-applet &
		;;

	right )
		pkill nm-applet &
		;;

	* )
		nm-applet &
		;;
esac
