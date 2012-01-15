# Göran Gustafsson <gustafsson.g@gmail.com>

export GEM_HOME=~/.ruby
export LC_COLLATE=C

export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent"
export GIT_EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
export VISUAL=$EDITOR

export LESS=FRX
export PAGER=less

DIRSTACKSIZE=17
TODO_FILE=~/Documents/Text\ Files/To-do\ List.txt

HISTFILE=~/.zsh_histfile
HISTSIZE=2000
SAVEHIST=6000

path=(/usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin /usr/X11/bin ~/Scripts ~/.ruby/gems/*/bin(N))

setopt correct
setopt interactivecomments
setopt longlistjobs
setopt nobeep
setopt noclobber
setopt notify
setopt promptsubst

setopt appendhistory
setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histreduceblanks
setopt histverify
setopt incappendhistory

setopt autopushd
setopt pushdignoredups

setopt combiningchars
setopt noautomenu

[[ ! $TERM == dumb ]] && autoload -U colors && colors
autoload -U compinit && compinit
autoload -U url-quote-magic && zle -N self-insert url-quote-magic

bindkey -v
bindkey '^?' backward-delete-char
bindkey -M vicmd 'R' custom-vi-replace

zstyle ':completion:*'          insert-tab pending
zstyle ':completion:*'          matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*'          special-dirs true
zstyle ':completion:*:cd:*'     ignore-parents parent pwd
zstyle ':completion:*:warnings' format "zsh: no matches found."

compdef _man manp
compdef _path_files cd
compdef _path_files git add

precmd() {
  echo
}

function git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  BRANCH=${ref#refs/heads/}

  if [[ -n $(git rev-list origin..HEAD 2> /dev/null) ]]; then
    if [[ -n $(git status -s 2> /dev/null) ]]; then
      echo "%F{cyan}ahead %F{red}$BRANCH%f"
    else
      echo "%F{cyan}ahead %F{green}$BRANCH%f"
    fi
  elif [[ -n $(git status -s 2> /dev/null) ]]; then
    echo "%F{red}$BRANCH%f"
  else
    echo "%F{green}$BRANCH%f"
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
  elif [[ $REPLACE == 1 ]]; then
    echo "%F{magenta}R%f"
  else
    echo "%F{blue}$%f"
  fi
}

PROMPT='%B${(C)USER} %F{yellow}${(C)HOST%%.*}%f%b %~ %B$(zsh_mode)%b '
RPROMPT='%B$(git_branch)%b'

alias bc="bc -q"
alias c="clear"
alias capit="imagesnap -t 2 -w 1"
alias chkm="find ~/Music -type f ! -iname '*.mp3'"
alias df="df -h"
alias dh="dirs -v | sort -r"
alias dontsleep="pmset noidle"
alias eject="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true)' && echo 'All external drives ejected!'"
alias fetch="wget --page-requisites --adjust-extension --convert-links"
alias grep="grep --color=auto -i"
alias hi="history"
alias ka="killall"
alias mkdir="mkdir -pv"
alias o="open"
alias ping="ping -c 10"
alias pyweb="python3 -m http.server 8080"
alias re="ls -t | head -n 5"
alias reload="source ~/.zshrc"
alias s="screen"
alias tv="vim '$TODO_FILE'"
alias update="brew update && brew upgrade"
alias ycal="cal $(date +%Y)"
alias yt="youtube-dl -l"

alias -- -="cd -"
alias ...="cd ../.."
alias ..="cd .."

alias awk="gawk"
alias cal="gcal -s 1"
alias head="ghead"
alias sed="gsed"
alias sort="gsort"
alias tail="gtail"
alias wc="gwc"

alias cdb="cd /Volumes/Black\ Disk"
alias cdd="cd ~/Downloads"
alias cdp="cd ~/Projects"
alias cds="cd ~/Sites"

alias cl="wc -l"
alias cw="wc -w"
alias g="grep"
alias he="head"
alias l="less"
alias rg="grep -r"
alias so="sort"
alias ta="tail"
alias un="uniq"

alias console="open -a Console"
alias safari="open -a Safari"

alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v"

alias csd='echo "Change directory to saved PATH." && cd $SAVE_DIR'
alias sd='echo "Saving current PATH." && SAVE_DIR=$PWD'

alias cv="cvim"
alias cvim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vimdiff="/Applications/MacVim.app/Contents/MacOS/Vim -d -g $* >& /dev/null"
alias vimp="/Applications/MacVim.app/Contents/MacOS/Vim - -g >& /dev/null"

alias d="ls -l"
alias da="ls -la"
alias dae="ls -lae"
alias de="ls -le"
alias l1="ls -1"
alias la="ls -a"
alias ls="ls -Gh"

alias fleia="sftp twiggy@leia.lan"
alias leia="ssh twiggy@leia.lan"

alias gad="git add"
alias gbr="git branch"
alias gca="git commit -a -v"
alias gch="git checkout"
alias gcl="git clone"
alias gco="git commit -v"
alias gdi="git diff"
alias gfe="git fetch"
alias git="hub"
alias glo="git log"
alias gme="git merge"
alias gmv="git mv"
alias gpl="git pull"
alias gpu="git push"
alias grm="git rm"
alias gst="git status -s -b"

alias ip="ifconfig"
alias iip="curl -s http://automation.whatismyip.com/n09230945.asp | html2text"

alias top="top -o cpu"
alias topme="top -o cpu -U $USER"

alias v="vim"
alias vd="vimdiff"
alias vimp="vim -"
alias vp="vimp"

for x in {1..16}; do
  alias +$x="cd +$x >& /dev/null"
done

function chkp {
  local CURRENT_DIR=$PWD
  local CLEAN_BRANCH

  for dir in ~/Projects/*; do
    cd $dir

    if [[ -n $(git rev-list origin..HEAD 2> /dev/null) ]]; then
      echo "\033[1;36m$dir:t:\033[0m"
      git status -s -b
      echo
    elif [[ -n $(git status -s 2> /dev/null) ]]; then
      echo "\033[1;31m$dir:t:\033[0m"
      git status -s -b
      echo
    else
      CLEAN_BRANCH="$CLEAN_BRANCH * $dir:t\n"
    fi
  done

  echo -n "\033[1;32mClean branches:\033[0m\n$CLEAN_BRANCH"

  cd $CURRENT_DIR
}

function f {
  if [ ! -z $1 ]; then
    open -a Finder $*
  else
    open .
  fi
}

function ff {
  if [ ! -z $1 ]; then
    find . -iname $* | sed 's/.\///'
  else
    echo "Usage: $0 [PATTERN]..."
  fi
}

function fff {
  if [ ! -z $1 ]; then
    find "$PWD" -iname $*
  else
    echo "Usage: $0 [PATTERN]..."
  fi
}

function frees {
  mv ~/Library/Caches/Homebrew ~/.Trash
  mv ~/Library/Caches/com.apple.Safari/Webpage\ Previews ~/.Trash
  mv ~/Library/iTunes/iPhone\ Software\ Updates ~/.Trash
}

function gifit {
  if [[ ! -z $1 ]]; then
    local FILENAME=animated_$(date '+%Y-%m-%d_%H:%M').gif
    convert -delay 30 -loop 0 $* $FILENAME

    open -a Safari $FILENAME
  fi
}

function h {
  if [ ! -z $1 ]; then
    history -i 1 | grep "$*"
  else
    history -i 1 | less +G
  fi
}

function manp {
  for arg in $*; do
    man -t $arg | open -f -a Preview
  done
}

function mkcd {
  if [ ! -z $1 ]; then
    mkdir -p "$*"
    cd "$*"
  else
    echo "Usage: $0 [NAME]..."
  fi
}

function p {
  if [ ! -z $1 ]; then
    ps ax | grep -v "grep --color=auto -i $*" | grep "$*"
  else
    ps ax
  fi
}

function permf {
  find . -type d -exec chmod -N 755 "{}" \;
  find . -type f -exec chmod -N 644 "{}" \;
}

function ppermf {
  find . -type d -exec chmod -N 700 "{}" \;
  find . -type f -exec chmod -N 600 "{}" \;
}

function ql {
  if [ ! -z $1 ]; then
    qlmanage -p $* >& /dev/null
  else
    qlmanage
  fi
}

function t {
  [ ! -f $TODO_FILE ] && echo "TODO file does not exist." && return

  if [ -z $1 ]; then
    if [ ! -s $TODO_FILE ]; then
      echo "TODO file is currently empty." && return
    else
      cat $TODO_FILE
    fi
  else
    echo "$*" >> $TODO_FILE
  fi
}

function unp {
  [ -z $1 ] && echo "Usage: $0 [FILENAME]..." && return

  for arg in $*; do
    if [ -f $arg ]; then
      case $arg in
        *.gz)
          if [[ $arg == *.tar.gz ]]; then
            tar zxvf $arg
          else
            gunzip $arg
          fi
        ;;
        *.bz2)
          if [[ $arg == *.tar.bz2 ]]; then
            tar xvjf $arg
          else
            bunzip2 $arg
          fi
        ;;
        *.tar)  tar xvf    $arg ;;
        *.tgz)  tar zxvf   $arg ;;
        *.tbz2) tar xvjf   $arg ;;
        *.zip)  unzip      $arg ;;
        *.rar)  unrar x    $arg ;;
        *.Z)    uncompress $arg ;;
        *.7z)   7z x       $arg ;;
        *)
          echo "File $arg cannot be extracted via $0."
        ;;
      esac
    else
      echo "File $arg does not exist."
    fi
  done
}

function vim {
  if [ -z $1 ]; then
    /Applications/MacVim.app/Contents/MacOS/Vim -g
  else
    /Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent $*
  fi
}

