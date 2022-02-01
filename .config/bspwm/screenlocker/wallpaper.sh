#!/bin/bash


# $1: qiv options


cd ~/.config/bspwm/screenlocker


# Creates cahce directory
mkdir -p cache


# if there aren't a wallpapaer, creates it
if [ ! -f wallpaper.png ]; then
	convert -size 1000x1000 xc:black wallpaper.png
fi


# Display dimensions
declare -i DISP_WIDTH=$(xdpyinfo | grep dimensions | cut -d' ' -f7 | cut -d'x' -f1)
declare -i DISP_HEIGHT=$(xdpyinfo | grep dimensions | cut -d' ' -f7 | cut -d'x' -f2)


# Resizes the wallpaper
if [ ! -f cache/wallpaper.png ]; then
	convert wallpaper.png -resize "$DISP_WIDTH"x"$DISP_HEIGHT"\! cache/wallpaper.png
fi


# Wallpaper variables
OPTIONS="$1"
QUERY_FULLSCREEN=''
NODE=''

# Wallpaper window
while [ "$QUERY_FULLSCREEN" == '' ]; do
	# Closes a already runnig wallpaper
	pkill -f "qiv ${OPTIONS} ${HOME}/.config/bspwm/screenlocker/cache/wallpaper.png"

	# Opens the wallpaper
	qiv $OPTIONS ~/.config/bspwm/screenlocker/cache/wallpaper.png &

	# Gets wallapaer node. If isn't the wallpaper node, the 'while' loop will continue
	sleep 0.7
	NODE=$(bspc query -N -n)

	# Gets a text if the wallpaper node is fullscreen
	QUERY_FULLSCREEN=$(bspc query -T -n $NODE | awk '/"state" *: *"fullscreen"/')
done



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


cd -


# The wallpaper will focus every 4 seconds
{
	while [ true ]; do
		bspc node "$NODE" -f
		sleep 4
	done
} &
