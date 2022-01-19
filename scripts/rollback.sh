#!/bin/bash

for file in .??*
do
    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".gitignore" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue
    [[ "$file" == ".zsh.d" ]] && continue
    if [[ "$file" == ".vimrc" ]]; then
        rm -vrf $HOME/.config/nvim
        rm -vrf $HOME/.config/nvim/init.vim
    fi

    rm -vrf $HOME/$file
done

