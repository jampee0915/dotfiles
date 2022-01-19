#!/bin/bash

DOTFILES_DIR=$HOME/dotfiles

has() {
    type "$1" > /dev/null 2>&1
}

# Install homebrew
if ! has "brew"; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! has "brew"; then
    echo "homebrew install unsccessfuly.... please check log."
    exit 1
fi

# Install tools
brew bundle --file $DOTFILES_DIR/Brewfile

