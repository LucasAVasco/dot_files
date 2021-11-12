#!/bin/bash


# Functions
source ~/.config/bspwm/screenlocker/functions.sh


# Saves notification daemon state and pauses it
NOTIFYD_STATE=$(xfconf-query -c xfce4-notifyd -p /do-not-disturb)
xfconf-query -c xfce4-notifyd -p /do-not-disturb -s true

# Changes default compton configurations
SEND_MESSAGE_TO_COMPTON string:no_fading_openclose boolean:false
SEND_MESSAGE_TO_COMPTON string:fade_delta int32:20
SEND_MESSAGE_TO_COMPTON string:fade_in_step double:0.05
SEND_MESSAGE_TO_COMPTON string:fade_out_step double:0.05

# Shows the wallpaper
OPTIONS="-f -i -p -G"
qiv $OPTIONS ~/.config/bspwm/screenlocker/wallpaper.png &

# Shows the widgets
source ~/.config/bspwm/screenlocker/widgets.sh

# Locks keyboard and mouse
xtrlock

# CLoses the widgets
for loop in $WIDGETS; do
	pkill -f "$HOME/.config/bspwm/screenlocker/widgets/${loop}.conf"
done

# Closes the wallpaper
pkill -f "qiv ${OPTIONS} ${HOME}/.config/bspwm/screenlocker/wallpaper.png"
sleep 0.4

# Gets compton default attributes
NO_FADING_OPENCLOSE=$(GET_COMPTON_ATTRIBUTE 'no-fading-openclose')
FADE_DELTA=$(GET_COMPTON_ATTRIBUTE 'fade-delta')
FADE_IN_STEP=$(GET_COMPTON_ATTRIBUTE 'fade-in-step')
FADE_OUT_STEP=$(GET_COMPTON_ATTRIBUTE 'fade-out-step')

# Adds a default value if compton config file hasn't the attribute
if [ "$NO_FADING_OPENCLOSE" == '' ]; then
	NO_FADING_OPENCLOSE="true"
fi

FADE_DELTA=$(SET_0_IF_NULL "$FADE_DELTA")
FADE_IN_STEP=$(SET_0_IF_NULL "$FADE_IN_STEP")
FADE_OUT_STEP=$(SET_0_IF_NULL "$FADE_OUT_STEP")

# Restores default compton attributes
SEND_MESSAGE_TO_COMPTON string:no_fading_openclose boolean:"$NO_FADING_OPENCLOSE"
SEND_MESSAGE_TO_COMPTON string:fade_delta int32:"$FADE_DELTA"
SEND_MESSAGE_TO_COMPTON string:fade_in_step double:"$FADE_IN_STEP"
SEND_MESSAGE_TO_COMPTON string:fade_out_step double:"$FADE_OUT_STEP"

# Resets notification daemon
xfconf-query -c xfce4-notifyd -p /do-not-disturb -s $NOTIFYD_STATE
