#!/bin/bash


# Gets dpms flags
STANDBY_TIME=$(dconf read /custom-desktop/screen-saver/standby-time)
SUSPEND_TIME=$(dconf read /custom-desktop/screen-saver/suspend-time)
OFF_TIME=$(dconf read /custom-desktop/screen-saver/off-time)


# If it isn't saved in dconf, do this
if [ "$STANDBY_TIME" == '' ]; then
	STANDBY_TIME=$(xset q | awk '/DPMS/,/\0/' | awk '/Standby/ {print $2}')
	dconf write /custom-desktop/screen-saver/standby-time "$STANDBY_TIME"
fi

if [ "$SUSPEND_TIME" == '' ]; then
	SUSPEND_TIME=$(xset q | awk '/DPMS/,/\0/' | awk '/Suspend/ {print $4}')
	dconf write /custom-desktop/screen-saver/suspend-time "$SUSPEND_TIME"
fi

if [ "$OFF_TIME" == '' ]; then
	OFF_TIME=$(xset q | awk '/DPMS/,/\0/' | awk '/Off/ {print $6}')
	dconf write /custom-desktop/screen-saver/off-time "$OFF_TIME"
fi


# Sets dpms flags
xset dpms "$STANDBY_TIME" "$SUSPEND_TIME" "$OFF_TIME"
