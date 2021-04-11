#!/bin/bash

# Close or open plank
pkill plank || plank -n bspwm_plank &
