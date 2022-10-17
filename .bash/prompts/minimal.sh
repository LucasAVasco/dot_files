#!/bin/bash

############ MINIMAL PROMPT ############

# Make to be used with Bash



# Generate PS1 Variable
PROMPT_COMMAND='PROMPT_REFRESH $?'



# Update prompt
PROMPT_REFRESH()
{
	# Variables
	local MAIN_PROMPT
	local WORKING_DIRECTORY
	local END_PROMPT



	# Main prompt
	MAIN_PROMPT='\
\[\033[38;5;${CHAR_COLOR_1}m\] ✹\
\[\033[38;5;${CHAR_COLOR_2}m\] \j\
\[\033[38;5;${CHAR_COLOR_3}m\] -\
\[\033[38;5;${CHAR_COLOR_4}m\] \u\
\[\033[38;5;${CHAR_COLOR_5}m\] [\
\[\033[38;5;${CHAR_COLOR_6}m\]\A\
\[\033[38;5;${CHAR_COLOR_5}m\]]\
\[\033[38;5;${CHAR_COLOR_7}m\] 🢚\
'



	# WORKING_DIRECTORY and ERROR_PROMPT
	if [ "$1" != 0 ]; then       # An error occurred
		WORKING_DIRECTORY='\[$(tput sgr0)\]\[\033[38;5;${CHAR_COLOR_9}m\]\w \[\033[38;5;${CHAR_COLOR_ERROR}m\][Error Code: '${1}']'

	else                         # An error didn't occur
		WORKING_DIRECTORY='\[$(tput sgr0)\]\[\033[38;5;${CHAR_COLOR_8}m\]\w'

	fi



	# End Prompt
	END_PROMPT='\
\[\033[38;5;${CHAR_COLOR_10}m\]\
\[\033[38;5;${CHAR_COLOR_11}m\]\
\[\033[38;5;${CHAR_COLOR_12}m\]\
 '

	# Export final Prompt
	export PS1="\
\n${MAIN_PROMPT}  \
${WORKING_DIRECTORY}  \
${END_PROMPT}\
${TEXT_COLOR}"
}



# Another prompt Variables
export PS2="   "

export PS4="   "
