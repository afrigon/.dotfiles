#!/usr/bin/env bash

# Move to the dotfile directory
cd "$(dirname "${BASH_SOURCE}")";

# Include helper functions
source ./lib.sh;

# Update the dotfiles repository
git pull -q origin master;


# Execute this entire file as sudo
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

mkdir -p "$HOME/bin"

# Instal Xcode tools
echo_running "Installing xcode tools..."
xcode-select --install
echo_ok

# Install updates
echo_running "Installing updates..."
sudo softwareupdate -i -a
echo_ok

# Install/Update brew
if can_exec "brew"
then
    echo_running "Updating brew..."
    brew update
   	brew upgrade
    echo_ok
else
    echo_running "Installing brew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || echo_fatal
    echo_ok
fi


# Install git
if ! can_exec "git"
then
    echo_running "Installing git..."
    brew install git
    echo_ok
fi


# Install brew packages
echo_running "Installing brew formulae..."
brew bundle --file=./packages/Brewfile
echo_ok

echo_running "Configuring brew packages..."
# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells
then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/bash
fi
echo_ok

# Install casks
echo_running "Installing brew casks..."
brew bundle --file=./packages/Caskfile
echo_ok

mv /usr/local/bin/code-insiders /usr/local/bin/code

echo_running "Cleaning up brew"
brew cleanup
echo_ok


# Hammerspoon setup
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.hammerspoon"

# Install vscode packages
for extension in $(cat packages/Codefile)
do
    echo_running "Installing $extension..."
    code --install-extension "$extension"
    echo_ok
done
unset extension

# Install node packages
for package in $(cat packages/Npmfile)
do
    sudo npm install -g "$package"
done
unset package


# Set macos system settings
if is_macos
then
    source ./macos.sh
fi


# Create symbolic links to config files
echo_running "Linking dotfiles..."
source ./link.sh
echo_ok

echo_ok "The initialization is complete, you might want to reboot your system for changes to apply correctly."

# Unset helper functions
unset ESC_SEQ COL_RESET COL_RED COL_GREEN COL_YELLOW;
unset echo_ok echo_running echo_ok echo_warn echo_error echo_fatal can_exec is_macos;

