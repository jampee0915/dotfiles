#!/bin/bash

DOTFILES_DIR=$HOME/dotfiles

# Install homebrew
if [! which brew >/dev/null 2>&1]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [! which brew >/dev/null 2>&1]; then
    echo "homebrew install unsccessfuly.... please check log."
    exit 1
fi

# Install tools
brew bundle --file $DOTFILES_DIR/Brewfile

if which anyenv >/dev/null 2>&1; then
    anyenv init
    anyenv install nodenv
    anyenv install pyenv
    anyenv install tfenv

    exec $SHELL -l

    nodenv install 17.3.1
    nodenv global 17.3.1
fi

