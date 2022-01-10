export EDITOR=vim
export VISUAL=$EDITOR

export LESS=R # --RAW-CONTROL-CHARS
export LESS_TERMCAP_us=$(printf "\e[0m") # Remove underscores in 'man' etc.
export PAGER=less

# fn = filename, ln = line number, and se = separator.
export GREP_COLORS="fn=01;34:ln=00;34:se=01;30"

# First LS_COLORS line is based on output from 'dircolors' version 9.0.
export LS_COLORS="rs=0:di=01;34:ln=01;35:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32"
export LS_COLORS="${LS_COLORS}:*.bmp=01;33:*.gif=01;33:*.heic=01;33:*.ico=01;33:*.jpg=01;33:*.jpeg=01;33:*.png=01;33:*.pxi=01;33:*.svg=01;33:*.tif=01;33:*.tiff=01;33"
export LS_COLORS="${LS_COLORS}:*.avi=01;36:*.flv=01;36:*.f4v=01;36:*.mkv=01;36:*.mov=01;36:*.mpg=01;36:*.mpeg=01;36:*.mp4=01;36:*.m4v=01;36:*.ts=01;36:*.webm=01;36:*.wmv=01;36"
export LS_COLORS="${LS_COLORS}:*.flac=01;35:*.nsf=01;35:*.nsfe=01;35:*.m4a=01;35:*.m4r=01;35:*.mp3=01;35:*.ogg=01;35:*.wav=01;35"
export LS_COLORS="${LS_COLORS}:*.dmg=01;31:*.iso=01;31:*.rar=01;31:*.tar=01;31:*.tar.bz2=01;31:*.tar.gz=01;31:*.tgz=01;31:*.zip=01;31:*.7z=01;31"

HISTFILE=~/.zsh_histfile
HISTSIZE=9999
SAVEHIST=$HISTSIZE

if [[ $OSTYPE == darwin* ]]; then
  hash -d ext=/Volumes/External
  hash -d msd=/Volumes/MicroSD
else
  hash -d ext=/media/external
fi

tmp=~/Documents/Text\ Files/Tmp.txt
todo=~/Documents/Text\ Files/Todo.txt

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

autoload -U bracketed-paste-magic && zle -N bracketed-paste bracketed-paste-magic
autoload -U url-quote-magic && zle -N self-insert url-quote-magic

autoload -U down-line-or-beginning-search && zle -N down-line-or-beginning-search
autoload -U up-line-or-beginning-search && zle -N up-line-or-beginning-search

# Enable ci" di" vi" etc in Zsh's Vi mode :)
autoload -U select-quoted && zle -N select-quoted
for mode in visual viopp; do
  for char in {a,i}{\',\",\`}; do
    bindkey -M $mode $char select-quoted
  done
done

bindkey -v

bindkey "jj" vi-cmd-mode
bindkey "^V" edit-command-line
bindkey "^?" backward-delete-char # Delete with backspace under Vi mode.

bindkey "^A"  beginning-of-line
bindkey "^E"  end-of-line
bindkey "^R"  history-incremental-search-backward
bindkey "^U"  kill-whole-line
bindkey "^[." insert-last-word

bindkey -M vicmd "R" custom-vi-replace # Use custom Vi replace function.

# Insert & Delete key.
bindkey -M vicmd $terminfo[kich1] overwrite-mode
bindkey          $terminfo[kich1] overwrite-mode
bindkey -M vicmd $terminfo[kdch1] delete-char
bindkey          $terminfo[kdch1] delete-char

# Page Up & Page Down keys.
bindkey -M vicmd $terminfo[kpp] up-line-or-beginning-search
bindkey          $terminfo[kpp] up-line-or-beginning-search
bindkey -M vicmd $terminfo[knp] down-line-or-beginning-search
bindkey          $terminfo[knp] down-line-or-beginning-search

# Home & End key fix for Terminal.app, Cygwin etc.
bindkey -M vicmd "^[[H" beginning-of-line
bindkey          "^[[H" beginning-of-line
bindkey -M vicmd "^[[F" end-of-line
bindkey          "^[[F" end-of-line

# Home & End key fix for Tmux.
bindkey -M vicmd "^[[1~" beginning-of-line
bindkey          "^[[1~" beginning-of-line
bindkey -M vicmd "^[[4~" end-of-line
bindkey          "^[[4~" end-of-line

zstyle ":completion:*"          insert-tab pending # Disable tabs at prompt.
zstyle ":completion:*"          list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*"          matcher-list "m:{[:lower:]}={[:upper:]}" # Works like smartcase in Vim.
zstyle ":completion:*"          menu select
zstyle ":completion:*"          special-dirs true # Make "cd ..<tab>" turn into "cd ../" etc.
zstyle ":completion:*:cd:*"     ignore-parents parent pwd
zstyle ":completion:*:warnings" format "zsh: no matches found." # Display warning when x<tab> don't have matches.

if [[ $OSTYPE == darwin* ]]; then
  compdef _man man2pdf
fi

function prompt_git {
  if [[ -n $(git status --short 2> /dev/null) ]]; then
    echo "%B%F{red}[+]%f%b "
  fi
}

function prompt_todo {
  if [[ -f .todo.txt ]]; then
    echo "%B%F{green}[t]%f%b "
  fi
}

# Custom Vi replace function that changes a variable before entering replace
# mode and afterwards resets the variable. The variable is used under the
# prompt_mode function later on.
function custom-vi-replace {
  prompt_replace=1 && zle vi-replace && prompt_replace=0
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
function prompt_mode {
  if [[ $KEYMAP == vicmd ]]; then
    prompt_char=E
  elif [[ $prompt_replace -eq 1 ]]; then
    prompt_char=R
  else
    prompt_char="%#"
  fi
  echo "%B%F{cyan}${prompt_char}%f%b"
}

if [[ $OSTYPE == darwin* ]]; then
  prompt_host="%B%F{yellow}%m%f%b"
else
  prompt_host="%B%F{red}%m%f%b"
fi

# Coruscant ~/Projects/Dot Files [t] [+] $
PROMPT='$prompt_host %2~ $(prompt_todo)$(prompt_git)$(prompt_mode) '

if [[ $OSTYPE == darwin* ]]; then
  alias beep="afplay /System/Library/Sounds/Glass.aiff"
  alias tim="caffeinate tim"
  alias wifiscan="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --scan"

  alias brewi="brew install"
  alias brewr="brew uninstall"
  alias brews="brew search"
  alias brewu="brew update && brew upgrade"
else
  if type -p apt &> /dev/null; then
    alias apti="sudo apt install"
    alias aptr="sudo apt remove"
    alias apts="apt search"
    alias aptu="sudo apt update && sudo apt full-upgrade && sudo apt-get autoremove"
  fi

  alias cal="cal -m"
  alias free="free -h"
fi

alias caly='cal $(date +%Y)'
alias hist="source hist"
alias iip="curl icanhazip.com"
alias mkdir="mkdir -pv"
alias zreload="source ~/.zshenv && source ~/.zshrc"

alias cdh="dirs -v | tac"
alias cdj='cd "$(< ~/.saved_pwd)"'
alias cds='echo "Saving current path." && echo $PWD >| ~/.saved_pwd'

alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v"

alias la="ls --all -l"
alias ll="ls -l"
alias ls="ls --classify --color=auto --human-readable"

alias df="df -h"
alias du="du -sh"

alias grep="grep --color=auto"
alias grepr="grep --binary-file=without-match --exclude-dir .git --recursive"
alias grepr3="grepr --after-context=3 --before-context=3"

alias gad="git add"
alias gbr="git branch"
alias gca="git commit --all --verbose"
alias gch="git checkout"
alias gcl="git clone"
alias gco="git commit --verbose"
alias gdi="git diff"
alias gfp="echo -n 'Confirm action...' && read && git reset --hard origin/master && git pull"
alias gin="git init"
alias glo="git log"
alias gmv="git mv"
alias gpl="git pull"
alias gpu="git push"
alias grm="git rm"
alias gsh="git show"
alias gst="git status"
alias gsu="git submodule update --recursive"
alias gun="echo -n 'Confirm action...' && read && git reset --soft HEAD^"

alias py="python3"
alias pyjson="python3 -m json.tool"
alias pyweb="python3 -m http.server 8080"

alias svtplay-dl="svtplay-dl --resume"
alias youtube-dl="youtube-dl --continue --output '%(title)s.%(ext)s'"

alias tree="tree --charset ascii"
alias treed="tree -d -L 2"

if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi
