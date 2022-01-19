export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

autoload -U promptinit; promptinit

setopt auto_cd
zplug "mafredri/zsh-async"
zplug 'romkatv/powerlevel10k', as:theme, depth:1
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug "chrissicool/zsh-256color"
zplug 'b4b4r07/enhancd', use:init.sh
zplug 'BurntSushi/ripgrep', from:gh-r, as:command, rename-to:rg
# zplug 'mrowa44/emojify', as:command

# enhancd
: "Display a list of files in destination dir." && {
  [ -z "$ENHANCD_ROOT" ] || export ENHANCD_HOOK_AFTER_CD="ls -la"
}

# If there are plug-ins not yet installed, install them.
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug instal
    fi
fi

# plugin load
zplug load

# If .p10k.zsh exsits, load setting
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Road zsh settings
ZSHHOME="${HOME}/dotfiles/.zsh.d"
if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

