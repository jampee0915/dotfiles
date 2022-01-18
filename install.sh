#!/bin/bash

DOT_DIR="$HOME/dotfiles"

has() {
    type "$1" > /dev/null 2>&1
}

if if [ ! -d ${DOT_DIR} ]; then
    if has "git"; then
        git clone https://github.com/jampee0915/dotfiles ${DOT_DIR}
    elif has "curl" || has "wget"; then
        TARBALL="https://github.com/jampee0915/dotfiles/archive/refs/heads/master.tar.gz"
        if has "curl"; then
            curl -L ${TARBALL} -o master.tar.gz
        else
            wget ${TARBALL}
        fi
        tar -zxvf master.tar.gz
        rm -f master.tar.gz
        mv -f dotfiles-master "${DOT_DIR}"
    else
        echo "curl or wget or git required"
        exit 1
    fi
fi

