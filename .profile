# To see the default '~/.profile' content, check the '/etc/skel/.profile' file.
#
# The bash does not read this file if the '~/.bash_profile' file exists. '~/.profile' needs to be sourced
# from the '~/.bash_profile' if you want to use it.


# Custom paths added to PATH variable
FOLDERS_TO_PATH="$HOME/.bin $HOME/.local/bin $HOME/.local/dotfiles_bin"

for folder in $FOLDERS_TO_PATH; do
	if [ -d "$folder" ]; then
		PATH="$folder:$PATH"
	fi
done

# Homebrew on Linux
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Configurations of BSPWM window manager
if [ "$DESKTOP_SESSION" == "bspwm" ]; then
	# Java aplication that use AWT (Abstract Window Toolkit) may not work properly in BSPWM (window becomes while).
	# TRo disable the reparenting of the toolkit fix this problem.
	export _JAVA_AWT_WM_NONREPARENTING=1

	export DESKTOP_SESSION="GNOME"
	export XDG_SESSION_DESKTOP="GNOME"
	export XDG_CURRENT_DESKTOP="GNOME"
fi
