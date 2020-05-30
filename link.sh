#!/usr/bin/env sh

# Update the dotfiles repository
git pull -q origin master;

# Create symlink to the config files
for file in $(pwd -P)/configs/.*; do
	[ -f "$file" ] || continue
    ln -sf "$file" "$HOME"
done
unset file

touch $HOME/.hushlogin

mkdir -p $HOME/.emacs/{backups}
mkdir -p $HOME/.vim/{backups,swaps,undo,syntax}
cp ./configs/.vim/syntax/* $HOME/.vim/syntax

[ ! -e $HOME/.emacs.d ] && git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d

