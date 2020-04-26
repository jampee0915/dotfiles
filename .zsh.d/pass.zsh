# golang
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH=$PATH:$HOME/go/bin

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"

# pyenv
export PYENV_ROOT=/usr/local/var/pyenv

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# nodenv
eval "$(nodenv init -)"

# git
export PATH=/usr/local/Cellar/git/2.26.1_1/bin:$PATH
