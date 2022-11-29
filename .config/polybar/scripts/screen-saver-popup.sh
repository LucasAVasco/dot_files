#!/bin/bash


ENABLE_FEATURES_POPUP()
{
	# Gets current status of dpms
	STANDBY_TIME=$(xset q | awk '/DPMS/,/\0/' | awk '/Standby/ {print $2}')
	SUSPEND_TIME=$(xset q | awk '/DPMS/,/\0/' | awk '/Suspend/ {print $4}')
	OFF_TIME=$(xset q | awk '/DPMS/,/\0/' | awk '/Off/ {print $6}')

	STANDBY=true
	SUSPEND=true
	OFF=true
	if [ "$STANDBY_TIME" == 0 ]; then STANDBY=false; fi
	if [ "$SUSPEND_TIME" == 0 ]; then SUSPEND=false; fi
	if [ "$OFF_TIME" == 0 ]; then OFF=false; fi

	# Popup
	POPUP_RESULT=$( \
		zenity --list --column='' --column='' --checklist --hide-header \
			--text="Screen saver configurations:" \
			--name=screen_saver_popup_bspwm \
			--class=screen_saver_popup_bspwm \
			$STANDBY 'Blank' \
			$SUSPEND 'Suspend' \
			$OFF 'Shutdown'
	) || exit 0  # Mades no changes if you press 'cancel'

	# Uses $POPUP_RESULT to set new dpms flags
	if [ "$(echo "$POPUP_RESULT" | awk '/Blank/')" == '' ]; then
		STANDBY_TIME=0
		xset s off
		xset s noblank
	else
		STANDBY_TIME=$(dconf read /custom-desktop/screen-saver/standby-time)
		xset s on
		xset s blank
	fi

	if [ "$(echo "$POPUP_RESULT" | awk '/Suspend/')" == '' ]; then
		SUSPEND_TIME=0
	else
		SUSPEND_TIME=$(dconf read /custom-desktop/screen-saver/suspend-time)
	fi

	if [ "$(echo "$POPUP_RESULT" | awk '/Shutdown/')" == '' ]; then
		OFF_TIME=0
	else
		OFF_TIME=$(dconf read /custom-desktop/screen-saver/off-time)
	fi

	xset dpms "$STANDBY_TIME" "$SUSPEND_TIME" "$OFF_TIME"
}


case "$1" in
	left )
		ENABLE_FEATURES_POPUP
		;;

	right )
		echo 'not yet implemented'
		;;

	* )
		ENABLE_FEATURES_POPUP
		;;
esac
