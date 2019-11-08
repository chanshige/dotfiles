# -------------------------------------
# zsh settings
# -------------------------------------
export LANG=ja_JP.UTF-8
export PATH=/usr/local/bin:$PATH
export EDITOR=vim
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true

setopt nonomatch
setopt no_beep
setopt nolistbeep
setopt correct
setopt auto_cd
setopt auto_pushd
# emacs
bindkey -e

# -------------------------------------
# Prompt
# -------------------------------------
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

autoload -U colors;
colors
PROMPT="%{${fg[yellow]}%}%~ %1(v|%F{green}%1v%f|)%{${fg[red]}%}%# %{${reset_color}%}"

# -------------------------------------
# Complement
# -------------------------------------
autoload -U compinit;
compinit
setopt auto_list
setopt auto_menu
setopt list_packed
setopt list_types
bindkey "^[[Z" reverse-menu-complete
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# -------------------------------------
# History
# -------------------------------------
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

# -------------------------------------
# peco
# -------------------------------------
function peco-select-history() {
    BUFFER=$(\history -n 1 | \
        eval "tail -r" | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# -------------------------------------
# Alias
# -------------------------------------
alias alias-list="alias |cut -d "=" -f1"
alias ll="ls -l"
alias tailf="tail -f"
alias cp-sshkey="cat .ssh/id_rsa | pbcopy| echo 'sshkey copied.'"
alias weather="curl -4 wttr.in/Fukuoka"
alias trash="rm -vrf ~/.Trash/*"
alias trash-force="sudo rm -vrf ~/.Trash/*"
alias gip='curl -s inet-ip.info/json | jq'

alias -g G='| grep'
alias -g L='| less'

function iwhois(){
  curl -s https://api.whoisproxy.info/whois/$1 |jq
}

function idig(){
  curl -s https://api.whoisproxy.info/dig/$1 |jq
}

alias tar-kaito="tar -zxvf"

# -------------------------------------
# svn
# -------------------------------------
function svn-log-oneline() {
  svn log $*  | grep "^r[0-9]*" -A2|egrep -v "^$|--" |perl -pe "s/[0-9]* line[s]*\n$//g" 
}

# -------------------------------------
# Env
# -------------------------------------
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export PATH="$HOME/.nodebrew/current/bin:$HOME/.composer/vendor/bin:$PATH"
eval "$(rbenv init -)"

# -------------------------------------
# Docker setting
# -------------------------------------
alias docker-stop-all='docker stop $(docker ps -q)'
alias docker-rm-all='docker rm $(docker ps -aq)'
alias docker-rmi-all='docker rmi $(docker images -aq)'

alias docker-vrm-all='docker volume rm $(docker volume ls -qf dangling=true)'
