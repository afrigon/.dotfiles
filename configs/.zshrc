#!/usr/bin/env zsh

export SHELLRC="$HOME/.zshrc"
export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=30

ZSH_THEME="custom"
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"

plugins=(git golang brew docker)
fpath=(/usr/local/share/zsh-completions $fpath)

source $ZSH/oh-my-zsh.sh
source $HOME/.initrc

