#!/bin/bash


APP_LIST=(
	'exo-web-browser.desktop'
	'exo-mail-reader.desktop'
	'exo-file-manager.desktop'
	'exo-terminal-emulator.desktop'
	'exo-preferred-applications.desktop'
	'lxappearance.desktop'
	'xfce4-notifyd-config.desktop'
)


for loop in ${APP_LIST[@]}; do
	FILE_NAME="${HOME}/.local/share/applications/$loop"

	# Copies file from '/usr/share/applications' directory
	cp "/usr/share/applications/$loop" ~/.local/share/applications/

	# Changes the desktop enviroment configurations
	sed -i 's/^NotShowIn/temp-atribute-1234/' "$FILE_NAME"
	sed -i 's/^OnlyShowIn/NotShowIn/' "$FILE_NAME"
	sed -i 's/^temp-atribute-1234/OnlyShowIn/' "$FILE_NAME"

	# Makes executable
	chmod +x "$FILE_NAME"
done
