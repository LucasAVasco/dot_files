#!/bin/bash


# Main bar
polybar simple-topbar &

# System tray
stalonetray --config ~/.config/polybar/bars/simple-topbar/stalonetrayrc &
