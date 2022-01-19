#!/bin/bash

for file in .??*
do
    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".gitignore" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue
    [[ "$file" == ".zsh.d" ]] && continue

    rm -vrf $HOME/$file
done

