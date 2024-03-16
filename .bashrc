# Default '.bashrec' configurations
test -f /etc/skel/.bashrc && source /etc/skel/.bashrc


# ASDF and its completions
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

# Tmux and vim colors
export TERM=xterm-256color

# Source Colorscheme
source ~/.sub_modules/bash_custom_prompts/colorschemes/basic.sh

# Source Prompt
source ~/.sub_modules/bash_custom_prompts/prompts/basic.sh
