#!/bin/bash

######### MINIMAL POLYGON PROMPT #########


# Generates PS1 Variable
PROMPT_COMMAND='PROMPT_REFRESH $?'


# Success colors
BACK_COLOR_SUCCESS=$BACK_COLOR_3
CHAR_COLOR_SUCCESS=$CHAR_COLOR_3


# Updates prompt
PROMPT_REFRESH()
{
	# Changes the colors in case of error
	if [ $1 != 0 ]; then
		BACK_COLOR_3=$BACK_COLOR_ERROR
		CHAR_COLOR_3=$CHAR_COLOR_ERROR
	else
		BACK_COLOR_3=$BACK_COLOR_SUCCESS
		CHAR_COLOR_3=$CHAR_COLOR_SUCCESS
	fi

	# Error prompt
	if [ $1 != 0 ]; then
		ERROR_PROMPT="\
\[$(tput sgr0)\] \
\[\033[38;5;${BACK_COLOR_ERROR}m\] \
\[\033[38;5;${CHAR_COLOR_ERROR}m\]\[\033[48;5;${BACK_COLOR_ERROR}m\] Error: $1 \
\[$(tput sgr0)\]\[\033[38;5;${BACK_COLOR_ERROR}m\]"
	else
		ERROR_PROMPT=''
	fi

	export PS1="\
\n\[\033[38;5;${CHAR_COLOR_1}m\]\[\033[48;5;${BACK_COLOR_1}m\] \s \
\[\033[38;5;${BACK_COLOR_1}m\]\[\033[48;5;${BACK_COLOR_2}m\]\
\[\033[38;5;${CHAR_COLOR_2}m\] \u  \A \
\[$(tput sgr0)\]\[\033[38;5;${BACK_COLOR_2}m\]\[\033[48;5;${BACK_COLOR_3}m\]\
\[\033[38;5;${CHAR_COLOR_3}m\] \w \
\[$(tput sgr0)\]\[\033[38;5;${BACK_COLOR_3}m\]\
${ERROR_PROMPT}\
\n\n\
\[\033[48;5;${BACK_COLOR_5}m\]\[\033[38;5;${CHAR_COLOR_5}m\] \$\
\[$(tput sgr0)\]\[\033[38;5;${BACK_COLOR_5}m\]  \
\[$(tput sgr0)\]\
$TEXT_COLOR"
}



# Another prompt Variables

export PS2="\[\033[48;5;${BACK_COLOR_4}m\] \[$(tput sgr0)\]  $TEXT_COLOR"

export PS4="\[\033[48;5;${BACK_COLOR_1}m\] \[$(tput sgr0)\]  \[$(tput sgr0)\]$TEXT_COLOR"
