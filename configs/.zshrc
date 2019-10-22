#!/usr/bin/env zsh

export SHELLRC="$HOME/.zshrc"
export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=30

ZSH_THEME="frig"
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"

plugins=(git golang brew docker)
fpath=(/usr/local/share/zsh-completions $fpath)

source $ZSH/oh-my-zsh.sh
source $HOME/.initrc


# FZF

if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH=$PATH:/usr/local/opt/fzf/bin
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

