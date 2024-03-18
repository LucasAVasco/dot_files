#!/bin/bash

# Close or open plank
pkill -x -f 'plank -n bspwm_plank' || plank -n bspwm_plank &
