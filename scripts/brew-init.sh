#!/bin/bash

DOTFILES_DIR=$HOME/dotfiles

has() {
    type "$1" > /dev/null 2>&1
}

# Install homebrew
if ! has "brew"; then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
fi

if ! has "brew"; then
    echo "homebrew install unsccessfuly.... please check log."
    exit 1
fi

# Install tools
brew bundle --file $DOTFILES_DIR/Brewfile

if has "anyenv"; then
    anyenv init
    anyenv install nodenv
    anyenv install pyenv
    anyenv install tfenv

    exec $SHELL -l

    nodenv install 17.3.1
    nodenv global 17.3.1
fi

