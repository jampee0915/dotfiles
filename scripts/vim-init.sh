#!/bin/bash

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install color theme
curl -fLo ~/.vim/colors/goodwolf.vim --create-dirs https://raw.githubusercontent.com/sjl/badwolf/master/colors/goodwolf.vim
