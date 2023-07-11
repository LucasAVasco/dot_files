# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/dotfiles-bin" ]; then
    PATH="$HOME/.local/dotfiles-bin:$PATH"
fi

# Change the 'DESKTOP_SESSION' enviroment variable to "gnome" if in bspwm
if [ "$DESKTOP_SESSION" == "bspwm" ]; then
	export DESKTOP_SESSION="GNOME"
	export XDG_SESSION_DESKTOP="GNOME"
	export XDG_CURRENT_DESKTOP="GNOME"
fi

# Add Homebrew
if [ -d "/home/linuxbrew" ]; then
	eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi
