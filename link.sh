#!/usr/bin/env bash

# Move to the dotfile directory
cd "$(dirname "${BASH_SOURCE}")";

# Include helper functions
source ./lib.sh;

# Update the dotfiles repository
git pull -q origin master;

# Create symlink to the config files
for file in $(pwd -P)/configs/.*
do
	[ -f "$file" ] ||
	continue
    ln -sf "$file" "$HOME"
done
unset file

cp -R ./configs/.vim "$HOME/.vim"

# Unset helper functions
unset ESC_SEQ COL_RESET COL_RED COL_GREEN COL_YELLOW;
unset echo_ok echo_running echo_ok echo_warn echo_error echo_fatal can_exec is_macos;
