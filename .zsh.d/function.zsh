# checkout git branch(frb)
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# open pull request page(pr)
pr () {
    branch=$(git rev-parse --abbrev-ref HEAD)
    url=$(git config --local remote.origin.url)
    if [[ $url =~ ^https.*$ ]]; then
        open "$url/pull/$branch"
    else
        domain=$(echo $url | awk -F'[@]' '{print $2}' | awk -F'[:]' '{print $1}')
        repository_path=$(echo $url | awk -F'[:]' '{print $2}' | awk -F'[.]' '{print $1}')
        open "https://$domain/$repository_path/pull/$branch"
    fi
}

# open github repository
repo () {
    url=$(git config --local remote.origin.url)
    if [[ $url =~ ^https.*$ ]]; then
        open $url
    else
        domain=$(echo $url | awk -F'[@]' '{print $2}' | awk -F'[:]' '{print $1}')
        repository_path=$(echo $url | awk -F'[:]' '{print $2}' | awk -F'[.]' '{print $1}')
        open "https://$domain/$repository_path"
    fi
}

# full text search
fzgrep() {
  INITIAL_QUERY=""
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
    fzf --bind "change:reload:$RG_PREFIX {q} || true" \
        --ansi --phony --query "$INITIAL_QUERY" \
        --preview 'cat `echo {} | cut -f 1 --delim ":"`'
}

# repository search(Ctrl+g)
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^g' peco-src

# terminal ide window setting
function ide() {
    tmux split-window -v -p 30
    # tmux split-window -h -p 66
    # tmux split-window -h -p 50
}

# docker container login
function fde() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && docker exec -it "$cid" /bin/bash
}

# file incremental search(Ctrl+z)
function file-incremental-search() {
  local selected_file=`find $HOME/* -type f | fzf --preview "bat  --color=always --style=header,grid --line-range :100 {}"`
  if [ -n "$selected_file" ];then
      BUFFER="vim $selected_file"
      zle accept-line
  fi
  zle clear-screen
 }
zle -N file-incremental-search
bindkey '^z' file-incremental-search
