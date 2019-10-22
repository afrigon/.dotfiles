#!/usr/bin/env bash

# Move to the dotfile directory
cd $(dirname $BASH_SOURCE);

# Update the dotfiles repository
git pull -q origin master;

# Create symlink to the config files
for file in $(pwd -P)/configs/.*; do
	[ -f "$file" ] || continue
    ln -sf "$file" "$HOME"
done
unset file

touch $HOME/.hushlogin

mkdir -p $HOME/.vim/{backups,swaps,undo,syntax}
cp ./configs/.vim/syntax/* $HOME/.vim/syntax

