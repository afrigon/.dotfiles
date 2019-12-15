#!/usr/bin/env bash

# Move to the dotfile directory
cd $(dirname $BASH_SOURCE)

# Include helper functions
source ./configs/.functions
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"

function echo_ok() {
    echo -e "$COL_GREEN[ok]$COL_RESET "$1
}

function echo_running() {
    echo -en "$COL_YELLOW ⇒ $COL_RESET"$1": "
}

function echo_fatal() {
    echo -e "$COL_RED[error]$COL_RESET $1"; exit 1
}

# Update the dotfiles repository
is_installed git && git pull -q origin master

# Execute this entire file as sudo
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

mkdir -p "$HOME/bin"

# Instal Xcode tools
if is_macos; then
    echo_running "Installing xcode tools..."
    xcode-select --install
    echo_ok
fi

# Install updates
if is_macos; then
    echo_running "Installing updates..."
    sudo softwareupdate -i -a
    echo_ok
fi

# Install/Update package manager
if is_macos; then
    if is_installed brew; then
        echo_running "Updating brew..."
        brew update
        brew upgrade
    else
        echo_running "Installing brew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || echo_fatal
    fi
elif is_linux; then
    echo_running "Updating apt..."
    sudo apt update -y 
    sudo apt upgrade -y
fi
echo_ok

# Install git
if ! is_installed git; then
    echo_running "Installing git..."
    is_macos && brew install git || echo_fatal
    is_linux && sudo apt install git -y || echo_fatal
    echo_ok
fi

# Install packages
echo_running "Installing packages..."
if is_macos; then
    brew bundle --file=./packages/Brewfile
    echo_ok

    echo_running "Configuring brew packages..."
    # Switch to using brew-installed zsh as default shell
    if ! fgrep -q '/bin/zsh' /etc/shells; then
      echo '/bin/zsh' | sudo tee -a /etc/shells
      chsh -s /bin/zsh
    fi

    # fzf
    $(brew --prefix)/opt/fzf/install --bin

    # Yabai
    brew services start skhd
    brew services start yabai

    echo_ok

    # Install casks
    echo_running "Installing brew casks..."
    brew bundle --file=./packages/Caskfile
    echo_ok

    # rename vscode insider binary to code
    mv /usr/local/bin/code-insiders /usr/local/bin/code

    # Cleaning up brew
    echo_running "Cleaning up brew"
    brew cleanup
    echo_ok

    # Install vscode packages
    for extension in $(cat ./packages/Codefile); do
        echo_running "Installing $extension..."
        code --install-extension "$extension"
        echo_ok
    done
    unset extension

    # Set macos system settings
    source ./macos.sh

elif is_linux; then
    # node 12
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

    for package in $(cat ./packages/Aptfile); do
        echo_running "Installing $package..."
        sudo apt install $package -y
        echo_ok
    done
    unset package

    # fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    echo_running "Configuring apt packages..."
    # Switch to using apt-installed zsh as default shell
    if ! fgrep -q '/bin/zsh' /etc/shells; then
      echo '/bin/zsh' | sudo tee -a /etc/shells
      sudo chsh -s /bin/zsh
    fi

    sudo python2 -m pip install --user --upgrade pip
    sudo python3 -m pip install --user --upgrade pip
    sudo apt remove python3-pip python-pip -y

    echo_ok
fi

# oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ./themes/custom.zsh-theme ~/.oh-my-zsh/custom/themes

# GEF
wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

# Install node packages
for package in $(cat ./packages/Npmfile); do
    sudo npm install -g "$package"
done
unset package

# Create symbolic links to config files
echo_running "Linking dotfiles..."
source ./link.sh
echo_ok

echo_running "Installing vim plugins..."
vim +PluginInstall +qall
cd $HOME/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer --go-completer --rust-completer --ts-completer
echo_ok

echo_ok "The initialization is complete, you might want to reboot your system for changes to apply correctly."

# Unset helper functions
unset ESC_SEQ COL_RESET COL_RED COL_GREEN COL_YELLOW;
unset echo_ok echo_running echo_fatal;

