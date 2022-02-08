# homebrew
if [ "$(uname -m)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="/opt/homebrew/bin:$PATH"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

# anyenv
eval "$(anyenv init -)"

# fzf option
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --inline-info --preview 'head -100 {}'"
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'

# enhancd
export ENHANCD_DISABLE_HOME=1
export ENHANCD_DISABLE_DOT=1

# Go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
