alias gs='git status'
alias gco='git checkout'
alias gd='git diff'
alias f='vim $(fzf)'

if [[ $(command -v exa) ]]; then
    alias e='exa --icons --git'
    alias l=e
    alias ls=e
    alias ea='exa -a --icons --git'
    alias la=ea
    alias ee='exa -aahl --icons --git'
    alias ll='ls -l'
else
    alias ll='ls -lGF'
    alias ls='ls -GF'
fi
