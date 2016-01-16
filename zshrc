# Göran Gustafsson <gustafsson.g@gmail.com>

[[ $TERM == xterm ]] && export TERM=xterm-256color # GNOME Terminal needs this.
export EDITOR=vim
export VISUAL=$EDITOR

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export LESS=FRSX
export LESS_TERMCAP_us=$(printf "\e[0m")
export PAGER=less

export LS_COLORS="rs=0:di=01;34:ln=01;35:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32"
export LS_COLORS="${LS_COLORS}:*.bmp=01;33:*.gif=01;33:*.ico=01;33:*.jpg=01;33:*.jpeg=01;33:*.png=01;33:*.pxi=01;33:*.svg=01;33:*.tif=01;33:*.tiff=01;33"
export LS_COLORS="${LS_COLORS}:*.avi=01;36:*.flv=01;36:*.f4v=01;36:*.mkv=01;36:*.mov=01;36:*.mpg=01;36:*.mpeg=01;36:*.mp4=01;36:*.m4v=01;36:*.ts=01;36:*.webm=01;36:*.wmv=01;36"
export LS_COLORS="${LS_COLORS}:*.flac=01;35:*.nsf=01;35:*.nsfe=01;35:*.m4a=01;35:*.m4r=01;35:*.mp3=01;35:*.ogg=01;35:*.wav=01;35"
export LS_COLORS="${LS_COLORS}:*.dmg=01;31:*.iso=01;31:*.rar=01;31:*.tar=01;31:*.tar.bz2=01;31:*.tar.gz=01;31:*.tgz=01;31:*.zip=01;31:*.7z=01;31"

export todo_file=~/Documents/Text\ Files/To-do\ List.txt

DIRSTACKSIZE=20

HISTFILE=~/.zsh_histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE

if [[ $OSTYPE == darwin* ]]; then
  d2=/Volumes/MicroSD/Downloads\ 2
  e=/Volumes/External
  m=/Volumes/MicroSD
else
  e=/media/external
fi

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
autoload -U edit-command-line && zle -N edit-command-line
autoload -U url-quote-magic && zle -N self-insert url-quote-magic

autoload -U down-line-or-beginning-search && zle -N down-line-or-beginning-search
autoload -U up-line-or-beginning-search && zle -N up-line-or-beginning-search

# Enable ci" di" vi" etc in Zsh's vi mode :)
autoload -U select-quoted && zle -N select-quoted
for mode in visual viopp; do
  for char in {a,i}{\',\",\`}; do
    bindkey -M $mode $char select-quoted 2> /dev/null # Shut up Ubuntu!
  done
done

bindkey -v
bindkey -M vicmd "R" custom-vi-replace # Use custom Vi replace function.

bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

bindkey -M vicmd $terminfo[khome] beginning-of-line # Home key.
bindkey -M vicmd $terminfo[kend]  end-of-line # End key.
bindkey -M vicmd $terminfo[kdch1] delete-char # Delete key.

bindkey $terminfo[khome] beginning-of-line # Home key.
bindkey $terminfo[kend]  end-of-line # End key.
bindkey $terminfo[kdch1] delete-char # Delete key.

bindkey "jj" vi-cmd-mode
bindkey "^?" backward-delete-char # Delete with backspace under Vi mode.
bindkey "^V" edit-command-line

bindkey "^A"  beginning-of-line
bindkey "^E"  end-of-line
bindkey "^R"  history-incremental-search-backward
bindkey "^U"  kill-whole-line
bindkey "^[." insert-last-word

bindkey "^[[A" up-line-or-beginning-search # Up key.
bindkey "^[[B" down-line-or-beginning-search # Down key.

zstyle ":completion:*"          insert-tab pending # Disable tabs at prompt.
zstyle ":completion:*"          list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*"          matcher-list "m:{[:lower:]}={[:upper:]}" # Works like smartcase in Vim.
zstyle ":completion:*"          menu select
zstyle ":completion:*"          special-dirs true # Make "cd ..<tab>" turn into "cd ../" etc.
zstyle ":completion:*:cd:*"     ignore-parents parent pwd
zstyle ":completion:*:warnings" format "zsh: no matches found." # Display warning when x<tab> don't have matches.

if [[ $OSTYPE == darwin* ]]; then
  compdef _files du # It just stopped working one day.
  compdef _man   man2pdf
fi

# Displays the current git status. I use it for RPROMPT.
function git_branch {
  reference=$(git symbolic-ref HEAD 2> /dev/null) || return
  branch=${reference#refs/heads/}

  if [[ -n $(git rev-list origin..HEAD 2> /dev/null) ]]; then
    if [[ -n $(git status --short 2> /dev/null) ]]; then
      echo " %F{cyan}ahead %F{red}${branch}%f"
    else
      echo " %F{cyan}ahead %F{green}${branch}%f"
    fi
  elif [[ -n $(git status --short 2> /dev/null) ]]; then
    echo " %F{red}${branch}%f"
  else
    echo " %F{green}${branch}%f"
  fi
}

# Custom Vi replace function that changes a variable before entering replace
# mode and afterwards resets the variable. The variable is used under the
# zsh_mode function later on.
function custom-vi-replace {
  replace=1 && zle vi-replace && replace=0
}
zle -N custom-vi-replace

# Part of the custom Vi replace functionality. This is needed to make the
# prompt update when mode is switched.
function zle-line-init zle-keymap-select {
  zle reset-prompt
}
zle -N zle-line-init && zle -N zle-keymap-select

# Part of the custom Vi replace functionality. This is the output part that
# will be used in the prompt to indicate the current Vi mode.
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

# Easily switch between short and long prompt. Convenient to have when using
# vertical split windows in tmux and things get cramped.
function prompts {
  if [[ $zsh_full_prompt -ne 1 ]]; then
    zsh_full_prompt=1
    # Coruscant ~ $
    PROMPT='%B${zsh_host}%b ${PWD/${HOME}/~} %B$(zsh_mode)%b '
    # $ 0 master
    RPROMPT='%B%F{blue}$%f%b %?%B$(git_branch)%b'
  else
    zsh_full_prompt=0
    # Coruscant $
    PROMPT='%B${zsh_host}%b %B$(zsh_mode)%b '
    RPROMPT=''
  fi
}
if [[ -z $dont_run_again ]]; then
  dont_run_again=1
  prompts
fi

if [[ $OSTYPE == darwin* ]]; then
  alias beep="afplay /System/Library/Sounds/Glass.aiff"
  alias caffeinate="caffeinate -di"
  alias eject="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true)' && echo 'Ejecting all external drives.'"
  alias gvimdiff='~/Applications/MacVim.app/Contents/MacOS/Vim -d -g $* &> /dev/null'
  alias o="open"
  alias tim="caffeinate tim"
  alias top="top -o cpu -s 2"
  alias vl='sudo less +F /var/log/system.log'
  alias webcam="imagesnap -t 2 -w 1"
  alias wifiscan="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --scan"

  alias brewi="brew install"
  alias brewr="brew uninstall"
  alias brews="brew search"
  alias brewu="brew update && brew upgrade"

  alias mext="open smb://gleg@192.168.1.3/External"
  alias umext="umount //gleg@192.168.1.3/External"
else
  if type -p apt &> /dev/null; then
    alias apti="sudo apt install"
    alias aptr="sudo apt remove"
    alias apts="apt search"
    alias aptu="sudo apt update && sudo apt full-upgrade"
  fi

  alias cal="cal -m"
  alias vl='less +F /var/log/syslog'
fi

alias free="free -h"
alias iip="curl icanhazip.com"
alias ka="killall"
alias l="less"
alias mkdir="mkdir -pv"
alias pyweb="python3 -m http.server 8080"
alias tma="tmux attach"
alias tree="tree --charset ascii -N"
alias tv='vim $todo_file'
alias wgetp="wget --adjust-extension --convert-links --page-requisites"
alias ycal='cal $(date +%Y)'
alias zreload="source ~/.zshenv && source ~/.zshrc && [[ -f ~/.zsh_local ]] && source ~/.zsh_local || true"

alias ..="source dotdot"
alias cdh="dirs -v | sort --reverse"
alias cdj='cd "$(< ~/.saved_pwd)"'
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
alias ls='ls --classify --color=auto --human-readable -v'

alias df="df -h"
alias du="du -sh"

alias g="grep"
alias grep="grep --color=auto"
alias rg="grep --exclude-dir .git --line-number --recursive"
alias rg3="rg --after-context=3 --before-context=3"

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
alias gsh="git show"
alias gst="git status --branch --short"
alias gun="git reset --soft HEAD^"

alias h="source h"
alias hist="history -i 1 | less"

alias sort="sort --numeric-sort"
alias uniqs="sort | uniq"

alias svtplay-dl="svtplay-dl --resume"
alias youtube-dl="youtube-dl --continue --title"

if [[ -f ~/.ssh/config_local ]]; then
  alias scp2="scp -F ~/.ssh/config_local"
  alias sftp2="sftp -F ~/.ssh/config_local"
  alias ssh2="ssh -F ~/.ssh/config_local"
fi

[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local || true
