#!/bin/bash


# Whether to shutdown at minimum power
SHUTDOWN_ON_LOW_POWER=$(dconf read /custom-desktop/power/shutdown_on_low_power)

if [ "$SHUTDOWN_ON_LOW_POWER" == '' ]; then
	dconf write /custom-desktop/power/shutdown_on_low_power true
	SHUTDOWN_ON_LOW_POWER=true
fi

# Whether to ignore the battery minimum notification
IGNORE_LOW_BATTERY_NOTIFICATION=false
if [ -f /tmp/ignore_battery_low_notify_custom_desktop ]; then
	IGNORE_LOW_BATTERY_NOTIFICATION=true
fi

# Displays the popup
POPUP_RESULT=$(\
	zenity --list --column='' --column='' --checklist --hide-header \
	--text="Power management settings:" \
	--name=power_popup_bspwm \
	--class=power_popup_bspwm \
	$SHUTDOWN_ON_LOW_POWER     'shutdown on low power' \
	$IGNORE_LOW_BATTERY_NOTIFICATION 'ignore low battery notification' \
) || exit 0  # Mades no changes if you press 'cancel'

# Updates Whether it will shutdown at minimum power
if [ "$(echo $POPUP_RESULT | grep 'shutdown')" != '' ]; then
	dconf write /custom-desktop/power/shutdown_on_low_power true
else
	dconf write /custom-desktop/power/shutdown_on_low_power false
fi

# Updates Whether it will ignore battery minimum notification
if [ "$(echo $POPUP_RESULT | grep 'ignore')" != '' ]; then
	touch /tmp/ignore_battery_low_notify_custom_desktop
else
	rm /tmp/ignore_battery_low_notify_custom_desktop 2> /dev/null
fi
