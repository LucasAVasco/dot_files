#!/bin/bash


case "$1" in
	left )
		nm-connection-editor &
		;;

	right)
		rfkill unblock all &
		;;

	*)
		nm-connection-editor &
		;;
esac
