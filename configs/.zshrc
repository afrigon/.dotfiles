export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="frig"

HYPHEN_INSENSITIVE="true"

DISABLE_UPDATE_PROMPT="true"
export UPDATE_ZSH_DAYS=30

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

ENABLE_CORRECTION="true"

plugins=(git golang)

source $ZSH/oh-my-zsh.sh
source $HOME/.bash_profile

