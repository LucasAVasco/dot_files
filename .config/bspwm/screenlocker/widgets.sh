#!/bin/bash


cd ~/.config/bspwm/screenlocker


# Creates cache directory
mkdir -p cache

# User icon information
declare -i DIAMETER=80
declare -i DIAMETER_2=DIAMETER/2
DIMENSIONS="${DIAMETER}x${DIAMETER}"

# Generates the 'cache/user_icon.png' file if it doesn't exist
if [ ! -f ~/.config/bspwm/screenlocker/cache/user_icon.png ]; then
	# Generetes the mask file
	CIRCLE="circle ${DIAMETER_2},${DIAMETER_2} ${DIAMETER},${DIAMETER_2}"
	convert -size "$DIMENSIONS" xc:none -fill black -draw "$CIRCLE" cache/mask.png

	# Creates the widget icon if there are an user icon
	if [ -f "/var/lib/AccountsService/icons/${USER}" ]; then
		# Generates the user icon
		convert -resize "$DIMENSIONS" "/var/lib/AccountsService/icons/${USER}" \
			cache/mask.png -compose CopyOpacity -composite cache/user_icon.png

	else  # If there aren't a user icon
		NAME=$(echo ${USER^^})  # Uppercase user name

		# Image with a character (first user name character)
		convert -size 100x100 -background white -fill \
			black -font Arial -pointsize 72 -gravity center label:"${NAME:0:1}" 'cache/tmp_icon.png'

		# Generates the user icon
		convert -resize "$DIMENSIONS" "cache/tmp_icon.png" \
			cache/mask.png -compose CopyOpacity -composite cache/user_icon.png
	fi
fi


# Sets time language to English
LC_TIME=en_US.UTF-8

# Runs the widgets
WIDGETS=(
	'panel'
)

for loop in "${WIDGETS[@]}"; do
	conky -c ~/.config/bspwm/screenlocker/widgets/"$loop".conf &
done


cd -
