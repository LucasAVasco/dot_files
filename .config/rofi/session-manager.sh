#!/bin/bash


# Define the CONTENT
CONTENT=''

# Get the CONTENT
for loop in 'Shutdown;system-shutdown' 'Reboot;system-reboot' 'Suspend;system-suspend' 'Hibernate;system-hibernate' 'Lock screen;lock-screen' 'Switch user;system-switch-user'; do
	CONTENT+=$(echo -n "$loop" | sed 's/;/\\0icon\\x1f/')
	CONTENT+='\n'
done

# Display ROFI
SELECTED_COMMAND=$(echo -en "$CONTENT" | rofi -dmenu -theme themes/session-manager.rasi)

# Execute the command
case $SELECTED_COMMAND in
	# Shutdown
	Shutdown )
		shutdown now
	;;

	# Reboot
	Reboot )
		reboot
	;;

	# Suspend
	Suspend )
		systemctl suspend
	;;

	# Hibernate
	Hibernate )
		systemctl hibernate
	;;

	# Lock-screen
	'Lock screen' )
		~/.config/sxhkd/lockscreen.sh
	;;

	# Switch-user
	'Switch user' )
		pkill bspwm
	;;

esac
