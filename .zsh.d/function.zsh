###########################################################################
#                                                                       Git
###########################################################################
# ローカルにあるブランチを検索し、checkoutする
function br() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# 対象ブランチのPRを開く
function pr () {
    branch=$(git rev-parse --abbrev-ref HEAD)
    url=$(git config --local remote.origin.url)
    if [[ $url =~ ^https.*$ ]]; then
        open "$url/pull/$branch"
    elif [[ $url =~ ^ssh.*$ ]]; then
        organization=$(echo $url | awk -F'[/]' '{print $4}')
        domain=$(echo $url | awk -F'[/]' '{print $3}' | awk -F'[@]' '{print $2}')
        repository=$(echo $url | awk -F'[/]' '{print $5}' | awk -F'[.]' '{print $1}')
        open "https://$domain/$organization/$repository/pull/$branch"
    else
        domain=$(echo $url | awk -F'[@]' '{print $2}' | awk -F'[:]' '{print $1}')
        repository=$(echo $url | awk -F'[:]' '{print $2}' | awk -F'[.]' '{print $1}')
        open "https://$domain/$repository/pull/$branch"
    fi
}

# 対象のレポジトリのgithubをブラウザで開く
function repo () {
    url=$(git config --local remote.origin.url)
    if [[ $url =~ ^https.*$ ]]; then
        open $url
    elif [[ $url =~ ^ssh.*$ ]]; then
        organization=$(echo $url | awk -F'[/]' '{print $4}')
        domain=$(echo $url | awk -F'[/]' '{print $3}' | awk -F'[@]' '{print $2}')
        repository=$(echo $url | awk -F'[/]' '{print $5}' | awk -F'[.]' '{print $1}')
        open "https://$domain/$organization/$repository"
    else
        domain=$(echo $url | awk -F'[@]' '{print $2}' | awk -F'[:]' '{print $1}')
        repository=$(echo $url | awk -F'[:]' '{print $2}' | awk -F'[.]' '{print $1}')
        open "https://$domain/$repository"
    fi
}

# ghqでレポジトリを検索(Ctrl+g)
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


###########################################################################
#                                                                       SSH
###########################################################################
# sshの接続先ごとにターミナルの背景色を変更する
function ssh() {
  # tmux起動時
  if [[ -n $(printenv TMUX) ]] ; then
      # 現在のペインIDを記録
      local pane_id=$(tmux display -p '#{pane_id}')
      # 接続先ホスト名に応じて背景色を切り替え
      if [[ `echo $1 | grep 'prd'` ]] ; then
          tmux select-pane -P 'bg=colour52,fg=white'
      elif [[ `echo $1 | grep 'stg'` ]] ; then
          tmux select-pane -P 'bg=colour25,fg=white'
      fi

      # 通常通りssh続行
      command ssh $@

      # デフォルトの背景色に戻す
      tmux select-pane -t $pane_id -P 'default'
  else
      command ssh $@
  fi
}

# SSH接続先を検索
function peco-ssh () {
  local selected_host=$(awk '
  tolower($1)=="host" {
    for (i=2; i<=NF; i++) {
      if ($i !~ "[*?]") {
        print $i
      }
    }
  }
  ' ~/.ssh/config | sort | peco --query "$LBUFFER")
  if [ -n "$selected_host" ]; then
    BUFFER="ssh ${selected_host}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ssh
bindkey '^_' peco-ssh


###########################################################################
#                                                                    Docker
###########################################################################
# 対象のdocker containerにログインする
function dcl() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && docker exec -it "$cid" /bin/bash
}

# 対象のdocker containerをstopする
function dcs() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && docker stop "$cid"
}


###########################################################################
#                                                               File search
###########################################################################
# ファイルを横断的に検索し、vimで開く
function file-incremental-search() {
  local selected_file=`find $HOME/* -type d -name "Applications" -prune -o -type d -name "Library" -prune -o -type d -name "Creative Cloud Files" -prune -o -type f | fzf --preview "bat  --color=always --style=header,grid --line-range :100 {}"`
  if [ -n "$selected_file" ];then
      BUFFER="vim $selected_file"
      zle accept-line
  fi
  zle clear-screen
 }
zle -N file-incremental-search
bindkey '^z' file-incremental-search


###########################################################################
#                                                                     Other
###########################################################################
# AWS PROFILEをpecoで切り替える
function awsp() {
    profiles=$(aws configure list-profiles)
    profile_array=($(echo $profiles))
    selected_profile=$(echo $profiles | peco)

    [[ -n ${profile_array[(re)${selected_profile}]} ]] && export AWS_PROFILE=${selected_profile}; echo "😎 Changed to ${selected_profile} AWS Profile! 🚀"
}

# tmuxのペインサイズをide風に変更する
function ide() {
    tmux split-window -v -p 30
}

