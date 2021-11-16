#!/bin/bash


# $1: qiv options


# Wallpaper variables
OPTIONS="$1"
QUERY_FULLSCREEN=''
NODE=''

# Wallpaper window
while [ "$QUERY_FULLSCREEN" == '' ]; do
	# Closes a already runnig wallpaper
	pkill -f "qiv ${OPTIONS} ${HOME}/.config/bspwm/screenlocker/wallpaper.png"

	# Opens the wallpaper
	qiv $OPTIONS ~/.config/bspwm/screenlocker/wallpaper.png &

	# Gets wallapaer node. If isn't the wallpaper node, the 'while' loop will continue
	sleep 0.7
	NODE=$(bspc query -N -n)

	# Gets a text if the wallpaper node is fullscreen
	QUERY_FULLSCREEN=$(bspc query -T -n $NODE | awk '/"state" *: *"fullscreen"/')
done


# Display dimensions
declare -i DISP_WIDTH=$(xdpyinfo | grep dimensions | cut -d' ' -f7 | cut -d'x' -f1)
declare -i DISP_HEIGHT=$(xdpyinfo | grep dimensions | cut -d' ' -f7 | cut -d'x' -f2)

# Initial wallpapaer dimensions
NODE_DIMENSIONS=$(bspc query -T -n "$NODE" | sed 's/.*"floatingRectangle"://g' | sed 's/[{}]//g')

GET_NODE_DIMENSION()
{
	# $1: Pattern of dimension name

	echo "$NODE_DIMENSIONS" | sed 's/,/\n/g' | awk "/^\"$1\"/" | sed 's/.*://g'
}

declare -i X_POS=$(GET_NODE_DIMENSION x)
declare -i Y_POS=$(GET_NODE_DIMENSION y)
declare -i WIDTH=$(GET_NODE_DIMENSION width)
declare -i HEIGHT=$(GET_NODE_DIMENSION height)

# Sets the wallpapaer dimensions
declare -i X_ZOOM=50
declare -i Y_ZOOM=60

bspc node "$NODE" -t floating
bspc node "$NODE" -l above

bspc node "$NODE" --move $(( -X_POS - X_ZOOM )) $(( -Y_POS - Y_ZOOM ))
bspc node --resize bottom_right $((DISP_WIDTH - WIDTH + 2*X_ZOOM)) $(( DISP_HEIGHT - HEIGHT + 2*Y_ZOOM))


# The wallpaper will focus every 4 seconds
{
	while [ true ]; do
		bspc node "$NODE" -f
		sleep 4
	done
} &
