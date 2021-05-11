#!/bin/bash


# Lock the screen
light-locker-command -l

# Wait 2 seconds
sleep 1

# Poweroff the screen
xset dpms force off
