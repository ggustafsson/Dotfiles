# Göran Gustafsson <gustafsson.g@gmail.com>

[[ $OSTYPE == darwin* ]] && umask 077

[[ $TERM == xterm ]] && export TERM=xterm-256color
export GEM_HOME=~/.gem/ruby
export GREP_OPTIONS="--color=auto --ignore-case"
export LC_COLLATE=C

export EDITOR=vim
export VISUAL=$EDITOR

export LESS=FRSX
export PAGER=less

export LS_COLORS="rs=0:di=01;34:ln=01;35:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32"
export LS_COLORS="$LS_COLORS:*.bmp=01;33:*.gif=01;33:*.ico=01;33:*.jpg=01;33:*.jpeg=01;33:*.png=01;33:*.pxi=01;33:*.svg=01;33:*.tiff=01;33"
export LS_COLORS="$LS_COLORS:*.flac=01;35:*.nsf=01;35:*.nsfe=01;35:*.m4r=01;35:*.mp3=01;35:*.ogg=01;35:*.wav=01;35"
export LS_COLORS="$LS_COLORS:*.avi=01;36:*.flv=01;36:*.f4v=01;36:*.mkv=01;36:*.mov=01;36:*.mpg=01;36:*.mpeg=01;36:*.mp4=01;36:*.m4v=01;36:*.wmv=01;36"
export LS_COLORS="$LS_COLORS:*.dmg=01;31:*.iso=01;31:*.rar=01;31:*.tar=01;31:*.tar.bz2=01;31:*.tar.gz=01;31:*.tgz=01;31:*.zip=01;31:*.7z=01;31"

export ps_display="user,pid,command"
export todo_file=~/Documents/Text\ Files/To-do\ List.todo

DIRSTACKSIZE=20

HISTFILE=~/.zsh_histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE

if [[ $OSTYPE == darwin* ]]; then
  wireshark=(/usr/local/Cellar/wireshark/*/bin/*(N:t))

  e=/Volumes/External
  ed=/Volumes/External/Downloads
fi

[[ -f ~/.ssh/config ]] && ssh_hosts=($(sed -n 's/^Host //p' ~/.ssh/config | grep -v ${HOST%%.*}))
ls_options=(--classify --color=auto --human-readable)

d=~/Downloads
p=~/Projects
t=~/Documents/Text\ Files

setopt combiningchars
setopt correct
setopt interactivecomments
setopt nobeep
setopt noclobber
setopt promptsubst

setopt appendhistory
setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histignorespace
setopt histreduceblanks
setopt histverify
setopt incappendhistory

setopt autopushd
setopt pushdignoredups

[[ ! $TERM == dumb ]] && autoload -U colors && colors
autoload -U compinit && compinit
autoload -U url-quote-magic && zle -N self-insert url-quote-magic

bindkey -v
bindkey "jj" vi-cmd-mode
bindkey "^?" backward-delete-char
bindkey "^R" history-incremental-search-backward
bindkey "^U" kill-whole-line
bindkey -M vicmd "R" custom-vi-replace

zstyle ":completion:*"          insert-tab pending
zstyle ":completion:*"          list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*"          matcher-list "m:{[:lower:]}={[:upper:]}"
zstyle ":completion:*"          menu select
zstyle ":completion:*"          special-dirs true
zstyle ":completion:*:cd:*"     ignore-parents parent pwd
zstyle ":completion:*:warnings" format "zsh: no matches found."

[[ $OSTYPE == darwin* ]] && compdef _man man2pdf

function precmd {
  echo
}

function git_branch {
  reference=$(git symbolic-ref HEAD 2> /dev/null) || return
  branch=${reference#refs/heads/}

  if [[ -n $(git rev-list origin..HEAD 2> /dev/null) ]]; then
    if [[ -n $(git status --short 2> /dev/null) ]]; then
      echo " %F{cyan}ahead %F{red}$branch%f"
    else
      echo " %F{cyan}ahead %F{green}$branch%f"
    fi
  elif [[ -n $(git status --short 2> /dev/null) ]]; then
    echo " %F{red}$branch%f"
  else
    echo " %F{green}$branch%f"
  fi
}

function custom-vi-replace {
  REPLACE=1 && zle vi-replace && REPLACE=0
}
zle -N custom-vi-replace

function zle-line-init zle-keymap-select {
  zle reset-prompt
}
zle -N zle-line-init && zle -N zle-keymap-select

function zsh_mode {
  if [[ $KEYMAP == vicmd ]]; then
    echo "%F{red}E%f"
  elif [[ $REPLACE -eq 1 ]]; then
    echo "%F{magenta}R%f"
  else
    echo "%F{blue}$%f"
  fi
}

if [[ $TERM == dumb ]]; then
  PROMPT='%~ $ '
else
  # GLEG Tatooine ~ $
  PROMPT='%B${(U)USER} %F{yellow}${(C)HOST%%.*}%f%b ${PWD/$HOME/~} %B$(zsh_mode)%b '
  # $ 0 master
  RPROMPT='%B%F{blue}$%f%b %?%B$(git_branch)%b'
fi

if [[ $HOST == hoth ]]; then
  alias minecraft="cd ~/Minecraft && tmux new 'java -Xmx4096M -Xms1024M -jar minecraft_server.jar nogui' && cd -"
else
  alias fmcbackup="rsync --archive --delete --human-readable --progress -e ssh fulknark:~/Minecraft/ ~/Dropbox/Minecraft/Server/"
  alias fmclogs='ssh fulknark "tail -n $LINES -f ~/Minecraft/server.log"'
  alias mcbackup="rsync --archive --delete --human-readable --progress -e ssh hoth:~/Minecraft/ ~/Dropbox/Minecraft/Server/"
  alias mclogs='ssh hoth "tail -n $LINES -f ~/Minecraft/server.log"'
fi

if [[ $OSTYPE == darwin* ]]; then
  alias eject="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true)' && echo 'Ejecting all external drives.'"
  alias gvimdiff='/Applications/MacVim.app/Contents/MacOS/Vim -d -g $* >& /dev/null'
  alias o="open"
  alias top="top -o cpu -s 2"
  alias tree="tree -N"
  alias vl='sudo tail -n $LINES -f /var/log/system.log'
  alias webcam="imagesnap -t 2 -w 1"

  alias brewi="brew install"
  alias brewr="brew uninstall"
  alias brews="brew search"
  alias brewu="brew update && brew upgrade"

  alias wifioff="networksetup -setairportpower en0 off && echo 'Turning Wi-Fi off.'"
  alias wifion="networksetup -setairportpower en0 on && echo 'Turning Wi-Fi on.'"
  alias wifiscan="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --scan"

  for command in $wireshark; do
    alias $command="wiresharkfix $command"
  done
else
  if ! type -p ifconfig >& /dev/null && type -p ip >& /dev/null; then
    alias arp="ip neigh"
    alias ifconfig="ip addr"
    alias netstat="ss"
    alias route="ip route"
  fi

  if type -p apt-get >& /dev/null; then
    alias apti="sudo apt-get install"
    alias aptr="sudo apt-get purge"
    alias apts="apt-cache search"
    alias aptu="sudo apt-get update && sudo apt-get upgrade"
  fi

  alias cal="cal -m"
  alias psme='\ps x -u $USER -o $ps_display'
  alias vl='tail -n $LINES -f /var/log/syslog'
fi

alias bc="bc --quiet"
alias bigf="du -sk * | sort --numeric-sort --reverse | head"
alias c="clear"
alias df="df -h"
alias du="du -sh"
alias hist="history -i 1 | less"
alias iip="curl icanhazip.com"
alias ka="killall"
alias ls='ls $ls_options'
alias mkdir="mkdir -pv"
alias nsfw="reddit ~/.reddit/nsfw.config"
alias random='FILES=(*) && echo $FILES[$RANDOM%$#FILES+1]'
alias recf="ls -t | head -n 5"
alias reload="source ~/.zshenv && source ~/.zshrc && echo 'Zsh reloaded.'"
alias tmuxa="tmux attach"
alias tv='vim "$todo_file"'
alias wgetp="wget --adjust-extension --convert-links --page-requisites"
alias ycal='cal $(date +%Y)'

alias -- -="cd -"
alias ...="cd ../.."
alias ..="cd .."
alias cdh="dirs -v | sort --reverse"
alias cdj='cat ~/.pwd && cd "$(< ~/.pwd)"'
alias cds='echo "Saving current path." && pwd >| ~/.pwd'

alias cl="wc -l"
alias cw="wc -w"
alias g="grep"
alias l="less"
alias rg="rgrep"

alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v"

alias d="ls -l"
alias da="ls --all -l"
alias la="ls --all"

alias gad="git add"
alias gca="git commit --all --verbose"
alias gcl="git clone"
alias gco="git commit --verbose"
alias gdi="git diff"
alias gin="git init"
alias glo="git log"
alias gmv="git mv"
alias gpl="git pull"
alias gpu='git push && [[ $OSTYPE == darwin* ]] && say fuck yeah'
alias grm="git rm"
alias gst="git status --branch --short"
alias gun="git reset --soft HEAD^"

alias int="tim --interval"
alias pomo="tim --pomodoro"
alias rint="tim --rinterval"

alias phpweb="php -S 0.0.0.0:8080"
alias pyweb="python3 -m http.server 8080"

alias svtplay-dl="svtplay-dl --resume"
alias youtube-dl="youtube-dl --continue --title"

for name in $ssh_hosts; do
  alias $name="ssh $name"
done

function h {
  if [[ $# -gt 0 ]]; then
    history -i 1 | grep "$*"
  else
    history -20
  fi
}
