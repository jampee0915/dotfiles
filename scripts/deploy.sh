#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

has() {
    type "$1" > /dev/null 2>&1
}

# Create symbolick link
for file in .??*
do
    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".gitignore" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue
    [[ "$file" == ".zsh.d" ]] && continue
    if [[ "$file" == ".vimrc" ]]; then
        ln -s $HOME/.vim $HOME/.config/nvim
        ln -sfnv $DOTFILES_DIR/$file $HOME/.config/nvim/init.vim
    fi

    ln -sfnv $DOTFILES_DIR/$file $HOME/$file
done

# karabiner
mkdir -p $HOME/.config/karabiner
ln -sfnv $DOTFILES_DIR/karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug instal
    fi
fi

# change login shell
if [ "$(uname -m)" = "arm64" ]; then
    sudo sh -c "$(/opt/homebrew/bin/zsh) >> /etc/shells"
else
    sudo sh -c "$(/usr/local/bin/zsh) >> /etc/shells"
fi

