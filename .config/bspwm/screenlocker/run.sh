#!/bin/bash


# Doesn't run if the screenlocker is already running
pgrep -f "xtrlock" && exit


# Functions
source ~/.config/bspwm/screenlocker/functions.sh


# Temporarily locks the keyboard and mouse
xtrlock &

# Saves notification daemon state and pauses it
NOTIFYD_STATE=$(xfconf-query -c xfce4-notifyd -p /do-not-disturb)
xfconf-query -c xfce4-notifyd -p /do-not-disturb -s true

# Changes default compton configurations
SEND_MESSAGE_TO_COMPTON string:no_fading_openclose boolean:false
SEND_MESSAGE_TO_COMPTON string:fade_delta int32:20
SEND_MESSAGE_TO_COMPTON string:fade_in_step double:0.05
SEND_MESSAGE_TO_COMPTON string:fade_out_step double:0.05

# Saves and changes Bspwm configurations
BORDER_WIDTH=$(bspc config border_width)
bspc config border_width 0

# Shows the wallpaper
OPTIONS="-f -i -p -G"
~/.config/bspwm/screenlocker/wallpaper.sh "${OPTIONS}"

# Shows the widgets
sleep 0.5  # If the widgets are shown before the wallpaper, they go to the back of the wallpaper (sleep fix this)
source ~/.config/bspwm/screenlocker/widgets.sh

# Locks keyboard and mouse
pkill xtrlock
xtrlock

# Closes the widgets
for loop in $WIDGETS; do
	pkill -f "$HOME/.config/bspwm/screenlocker/widgets/${loop}.conf"
done

# Closes the wallpaper
pkill -f "$HOME/.config/bspwm/screenlocker/wallpaper.sh ${OPTIONS}"
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

# Restores Bspwm configurations
bspc config border_width $BORDER_WIDTH

# Resets notification daemon
xfconf-query -c xfce4-notifyd -p /do-not-disturb -s $NOTIFYD_STATE
