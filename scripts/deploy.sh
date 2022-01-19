#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

# Create symbolick link
for file in .??*
do
    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".gitignore" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue
    [[ "$file" == ".zsh.d" ]] && continue
    if [[ "$file" == ".vimrc" ]]; then
        ln -sfnv $HOME/.vim $HOME/.config/nvim
        ln -sfnv $DOTFILES_DIR/$file $HOME/.config/nvim/init.vim
    fi

    ln -sfnv $DOTFILES_DIR/$file $HOME/$file
done

mkdir -p $HOME/.config/karabiner
ln -sfnv $DOTFILES_DIR/karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json

if has "anyenv"; then
    anyenv init
    anyenv install nodenv
    anyenv install pyenv
    anyenv install tfenv

    exec $SHELL -l

    nodenv install 17.3.1
    nodenv global 17.3.1
fi

