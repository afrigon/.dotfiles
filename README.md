# Dotfiles

This is a collection of my personnal dotfiles and configuration scripts. These settings are my personnal preference and you should probably check what they do before using them.

## Installation

### New machine

On a brand new system simply run this command to install everything including **brew packages**, **cask applications**, **npm modules** and **vscode extensions**. It will also create links to these dotfiles in your home directory and change a bunch of macos defaults if it detects a macos machine.

```sh
bash -c "`curl -fsSL https://raw.githubusercontent.com/afrigon/dotfiles/master/remote-install.sh`"
source ~/.dotfiles/init.sh
```

### Dotfiles only

To skip the installation of the packages directory, simply clone this repository and execute the `link.sh` script to create links to these dotfiles.

```sh
git clone https://github.com/afrigon/dotfiles.git ~/.dotfiles
source ~/.dotfiles/link.sh
```

### MacOS Defaults

To simply install the macos defaults configuration you can run the `macos.sh` script after downloading the repository

```sh
source ~/.dotfiles/macos.sh
```

### Notes

The init script will install the content of packages and call the other scripts (link, macos). The file `configs/.extra` is automaticly included and won't be commited so credentials and signing keys can go there.

## TODO

- Add apt support for the init script.
- Create script for updates only.
- Fix hammerspoon

## Credits

Most of these configuration are stolen or adapted from these people.

- Ian Bouchard [PwnBox](https://github.com/Corb3nik/PwnBox)
- Lars Kappert [awesome-dotfiles](https://github.com/webpro/dotfiles)
- Mathias Bynens [dotfiles](https://github.com/mathiasbynens/dotfiles)

