#!/usr/bin/env bash

#bash -c "`curl -fsSL https://raw.githubusercontent.com/afrigon/dotfiles/master/remote-install.sh`" && source ~/.dotfiles/init.sh

REPO="https://github.com/afrigon/dotfiles"
TARGET="$HOME/.dotfiles"

# Download dotfiles to "~/.dotfiles" 
mkdir -p "$TARGET"
curl -#L $REPO/tarball/master | tar -xzv -C "$TARGET" --strip-components=1 --exclude={README.md,LICENSE}
echo "repository was downloaded into $TARGET"

