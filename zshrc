# Göran Gustafsson <gustafsson.g@gmail.com>

umask 077

[[ $TERM == xterm ]] && export TERM=xterm-256color # GNOME Terminal needs this.
export GEM_HOME=~/.gem/ruby
export GREP_OPTIONS="--color=auto --ignore-case"

export EDITOR=vim
export VISUAL=$EDITOR

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export LESS=FRSX
export PAGER=less

export LS_COLORS="rs=0:di=01;34:ln=01;35:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32"
export LS_COLORS="$LS_COLORS:*.bmp=01;33:*.gif=01;33:*.ico=01;33:*.jpg=01;33:*.jpeg=01;33:*.png=01;33:*.pxi=01;33:*.svg=01;33:*.tif=01;33:*.tiff=01;33"
export LS_COLORS="$LS_COLORS:*.avi=01;36:*.flv=01;36:*.f4v=01;36:*.mkv=01;36:*.mov=01;36:*.mpg=01;36:*.mpeg=01;36:*.mp4=01;36:*.m4v=01;36:*.webm=01;36:*.wmv=01;36"
export LS_COLORS="$LS_COLORS:*.flac=01;35:*.nsf=01;35:*.nsfe=01;35:*.m4a=01;35:*.m4r=01;35:*.mp3=01;35:*.ogg=01;35:*.wav=01;35"
export LS_COLORS="$LS_COLORS:*.dmg=01;31:*.iso=01;31:*.rar=01;31:*.tar=01;31:*.tar.bz2=01;31:*.tar.gz=01;31:*.tgz=01;31:*.zip=01;31:*.7z=01;31"

export ps_display="user,pid,command"
export todo_file=~/Documents/Text\ Files/To-do\ List.todo

DIRSTACKSIZE=20

HISTFILE=~/.zsh_histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE

if [[ $OSTYPE == darwin* ]]; then
  e=/Volumes/External
else
  e=/media/external
fi

# This must be inside of an array otherwise "ls" will take it as one argument.
ls_options=(--classify --color=auto --human-readable -v)

d=~/Downloads
p=~/Projects
t=~/Documents/Text\ Files

[[ $OSTYPE == darwin* ]] && setopt combiningchars # HFS+ is fucked up.
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

autoload -U compinit && compinit
autoload -U url-quote-magic && zle -N self-insert url-quote-magic

bindkey -v
bindkey "jj" vi-cmd-mode
bindkey "^?" backward-delete-char # Delete with backspace under Vi mode.
bindkey "^R" history-incremental-search-backward
bindkey "^U" kill-whole-line
bindkey -M vicmd "R" custom-vi-replace

zstyle ":completion:*"          insert-tab pending # Disable tabs at prompt.
zstyle ":completion:*"          list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*"          matcher-list "m:{[:lower:]}={[:upper:]}" # Works like smartcase in Vim.
zstyle ":completion:*"          menu select
zstyle ":completion:*"          special-dirs true # Make "cd ..<tab>" turn into "cd ../" etc.
zstyle ":completion:*:cd:*"     ignore-parents parent pwd
zstyle ":completion:*:warnings" format "zsh: no matches found." # Display warning when x<tab> don't have matches.

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
  replace=1 && zle vi-replace && replace=0
}
zle -N custom-vi-replace

function zle-line-init zle-keymap-select {
  zle reset-prompt
}
zle -N zle-line-init && zle -N zle-keymap-select

function zsh_mode {
  if [[ $KEYMAP == vicmd ]]; then
    echo "%F{red}E%f"
  elif [[ $replace -eq 1 ]]; then
    echo "%F{magenta}R%f"
  else
    echo "%F{blue}$%f"
  fi
}

if [[ $HOST == Coruscant* ]]; then
  zsh_host="%F{yellow}%m%f"
elif [[ $HOST == *-VM ]]; then
  zsh_host="%F{green}%m%f"
else
  zsh_host="%F{red}%m%f"
fi

# Coruscant ~ $
PROMPT='%B$zsh_host%b ${PWD/$HOME/~} %B$(zsh_mode)%b '
# $ 0 master
RPROMPT='%B%F{blue}$%f%b %?%B$(git_branch)%b'

if [[ $HOST == Hoth ]]; then
  alias killxbmc="killall xbmc xbmc.bin xbmc-standalone"

  alias mccreative="cd ~/Minecraft\ -\ Creative && java -Xmx3072M -Xms1024M -jar minecraft_creative.jar nogui && cd -"
  alias mccreativelog='tail -n $LINES -f ~/Minecraft\ -\ Creative/server.log'
  alias mcsurvival="cd ~/Minecraft\ -\ Survival && java -Xmx3072M -Xms1024M -jar minecraft_survival.jar nogui && cd -"
  alias mcsurvivallog='tail -n $LINES -f ~/Minecraft\ -\ Survival/server.log'
else
  alias mcbackup="rsync --archive --delete --human-readable --progress -e ssh 'hoth:~/Minecraft\ -\ Creative/' ~/Storage/Game\ Files/Minecraft/Server\ -\ Creative && rsync --archive --delete --human-readable --progress -e ssh 'hoth:~/Minecraft\ -\ Survival/' ~/Storage/Game\ Files/Minecraft/Server\ -\ Survival"
  alias mccreativelog='ssh -t hoth "tail -n $LINES -f ~/Minecraft\ -\ Creative/server.log"'
  alias mcsurvivallog='ssh -t hoth "tail -n $LINES -f ~/Minecraft\ -\ Survival/server.log"'
fi

if [[ $OSTYPE == darwin* ]]; then
  alias caffeinate="caffeinate -di"
  alias eject="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true)' && echo 'Ejecting all external drives.'"
  alias gvimdiff='~/Applications/MacVim.app/Contents/MacOS/Vim -d -g $* &> /dev/null'
  alias o="open"
  alias tim="caffeinate tim"
  alias top="top -o cpu -s 2"
  alias tree="tree --charset ascii -N"
  alias vl='sudo tail -n $LINES -f /var/log/system.log'
  alias webcam="imagesnap -t 2 -w 1"

  alias brewi="brew install"
  alias brewr="brew uninstall"
  alias brews="brew search"
  alias brewu="brew update && brew upgrade"

  alias mext="open smb://gleg@10.11.12.3/External"
  alias umext="umount //gleg@10.11.12.3/External"

  alias wifioff="networksetup -setairportpower en0 off && echo 'Wi-Fi is turned off.'"
  alias wifion="networksetup -setairportpower en0 on && echo 'Wi-Fi is turned on.'"
  alias wifiscan="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --scan"
else
  if type -p apt-get &> /dev/null; then
    alias apti="sudo apt-get install"
    alias aptr="sudo apt-get purge"
    alias apts="apt-cache search"
    alias aptu="sudo apt-get update && sudo apt-get upgrade"
  fi

  alias cal="cal -m"
  alias vl='tail -n $LINES -f /var/log/syslog'
fi

alias bigf="du -sk * | sort --numeric-sort --reverse | head"
alias df="df -h"
alias du="du -sh"
alias iip="curl icanhazip.com"
alias ka="killall"
alias l="less"
alias pyweb="python3 -m http.server 8080"
alias recf="ls -t | head -n 5"
alias tv='vim $todo_file'
alias wgetp="wget --adjust-extension --convert-links --page-requisites"
alias ycal='cal $(date +%Y)'
alias zreload="source ~/.zshenv && source ~/.zshrc && echo 'Zsh reloaded.'"

alias ..="source dotdot"
alias cdh="dirs -v | sort --reverse"
alias cdj='cat ~/.saved_pwd && cd "$(< ~/.saved_pwd)"'
alias cds='echo "Saving current path." && echo $PWD >| ~/.saved_pwd'

alias cl="wc -l"
alias cw="wc -w"

alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v"

alias csv="column -t -s ,"
alias csvv="column -t -s ';'"

alias d="ls -l"
alias da="ls --all -l"
alias la="ls --all"
alias ls='ls $ls_options'

alias g="grep"
alias rg="rgrep"

alias gad="git add"
alias gca="git commit --all --verbose"
alias gcl="git clone"
alias gco="git commit --verbose"
alias gdi="git diff"
alias gin="git init"
alias glo="git log"
alias gmv="git mv"
alias gpl="git pull"
alias gpu="git push"
alias grm="git rm"
alias gst="git status --branch --short"
alias gun="git reset --soft HEAD^"

alias h="source h"
alias hist="history -i 1 | less"

alias mkcd="source mkcd"
alias mkdir="mkdir -pv"

alias svtplay-dl="svtplay-dl --resume"
alias youtube-dl="youtube-dl --continue --title"

alias tm="tmux"
alias tma="tmux attach"
