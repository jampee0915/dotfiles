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

# anyenv
if has "anyenv" -a ! has "nodenv"; then
    anyenv init
    anyenv install --init
    anyenv install nodenv
    anyenv install pyenv
    anyenv install tfenv

    nodenv install 17.3.1
    nodenv global 17.3.1
fi

# change login shell
if [ "$SHELL" != $(which zsh) ]; then
    sudo sh -c "$(echo which zsh) >> /etc/shells"
    chsh -s $(echo which zsh)
    exec $SHELL -l
fi

