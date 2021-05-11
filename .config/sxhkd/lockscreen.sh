#!/bin/bash


# Lock the screen
slimlock 2> '/dev/null' &

# Wait 2 seconds
sleep 1

# Poweroff the screen
xset dpms force off
