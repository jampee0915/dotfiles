#!/bin/bash

# Create symbolick link
for file in .??*
do
    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".gitignore" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue
    [[ "$file" == ".zsh.d" ]] && continue

    ln -sfnv $DOTFILES_DIR/$file $HOME/$file
done
