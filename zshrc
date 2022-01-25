export GREP_COLORS="fn=01;34:ln=00;34:se=01;30" # File, line & separator.

export EDITOR=vim
export VISUAL=$EDITOR

export LESS=FR # --quit-if-one-screen --RAW-CONTROL-CHARS
export LESS_TERMCAP_us=$(printf "\e[0m") # Remove underscores in "man" etc.
export PAGER=less

# First LS_COLORS line is based on output from "dircolors" version 9.0.
export LS_COLORS="rs=0:di=01;34:ln=01;35:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32"
export LS_COLORS="${LS_COLORS}:*.bmp=01;33:*.gif=01;33:*.heic=01;33:*.ico=01;33:*.jpg=01;33:*.jpeg=01;33:*.png=01;33:*.pxi=01;33:*.svg=01;33:*.tif=01;33:*.tiff=01;33"
export LS_COLORS="${LS_COLORS}:*.avi=01;36:*.flv=01;36:*.f4v=01;36:*.mkv=01;36:*.mov=01;36:*.mpg=01;36:*.mpeg=01;36:*.mp4=01;36:*.m4v=01;36:*.ts=01;36:*.webm=01;36:*.wmv=01;36"
export LS_COLORS="${LS_COLORS}:*.flac=01;35:*.nsf=01;35:*.nsfe=01;35:*.m4a=01;35:*.m4r=01;35:*.mp3=01;35:*.ogg=01;35:*.wav=01;35"
export LS_COLORS="${LS_COLORS}:*.dmg=01;31:*.iso=01;31:*.rar=01;31:*.tar=01;31:*.tar.bz2=01;31:*.tar.gz=01;31:*.tgz=01;31:*.zip=01;31:*.7z=01;31"

HISTFILE=~/.zsh_history
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

setopt correct # Try to correct the spelling of commands.
setopt extendedglob
setopt interactivecomments
setopt noclobber # Don't allow overwrites of existing files with ">".
setopt promptsubst

setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histignorespace
setopt histreduceblanks
setopt histverify # "!" and "!!" commands are expanded instead of executed.
setopt incappendhistory

setopt autopushd
setopt pushdignoredups

autoload -U compinit && compinit
autoload -U edit-command-line && zle -N edit-command-line

autoload -U bracketed-paste-magic && zle -N bracketed-paste bracketed-paste-magic
autoload -U url-quote-magic && zle -N self-insert url-quote-magic

autoload -U select-bracketed && zle -N select-bracketed
autoload -U select-quoted && zle -N select-quoted

bindkey -v
bindkey -M vicmd "R" custom-vi-replace

# Same as "backspace=indent,eol,start" in Vim.
bindkey "^?" backward-delete-char
bindkey "^H" backward-delete-char
bindkey "^U" backward-kill-line
bindkey "^W" backward-kill-word

# Enable Vim quote and bracket selections in Zsh's Vi mode :)
for mode in viopp visual; do
  # a' a" a` i' i" i`
  for seq in {a,i}{\',\",\`}; do
    bindkey -M $mode $seq select-quoted
  done
  # a( i( a) i) a[ i[ a] i] a{ i{ a} i} a< i< a> i>
  for seq in {a,i}${(s..)^:-'()[]{}<>'}; do
    bindkey -M $mode $seq select-bracketed
  done
done

bindkey "jj" vi-cmd-mode
bindkey "^V" edit-command-line

bindkey "^A"  beginning-of-line
bindkey "^E"  end-of-line
bindkey "^R"  history-incremental-search-backward
bindkey "^[." insert-last-word

zstyle ":completion:*" insert-tab pending # Don't insert tab characters at prompt.
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*" matcher-list "m:{[:lower:]}={[:upper:]}" # Works like smartcase in Vim.
zstyle ":completion:*" menu select
zstyle ":completion:*" special-dirs true # Make "cd ..<tab>" turn into "cd ../" etc.

if [[ $OSTYPE == darwin* ]]; then
  compdef _man man2pdf
fi

# Custom Vi replace function that changes a variable before entering replace
# mode and afterwards resets the variable. The variable is used in the function
# "prompt_mode" later on.
function custom-vi-replace {
  prompt_replace=1 && zle vi-replace && prompt_replace=0
}
zle -N custom-vi-replace

# Prints " ♦︎ <branch>" when git repo is found in the current directory.
function prompt_git {
  if [[ ! -d .git ]]; then
    return 1
  fi

  branch=$(git branch --show-current 2> /dev/null)
  if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
    echo " ♦︎ %B%F{red}${branch}%f%b"
  else
    echo " ♦︎ %B%F{green}${branch}%f%b"
  fi
}

# Prints hostname in different ways depending on various rules.
function prompt_host {
  if [[ $OSTYPE == darwin* ]]; then
    echo "%B%F{yellow}%m%f%b"
  else
    echo "%B%F{cyan}%m%f%b"
  fi
}

# Prints current Vi mode. Insert "❯", command "❮" and replace "✱".
function prompt_mode {
  if [[ $KEYMAP == vicmd ]]; then
    echo "%B%F{red}❮%f%b"
  elif [[ $prompt_replace -eq 1 ]]; then
    echo "%B%F{red}✱%f%b"
  else
    echo "%B%F{green}❯%f%b"
  fi
}

# Prints " ✔︎ todo" when file ".todo(.txt)" is found in the current directory.
function prompt_todo {
  if [[ -f .todo || -f .todo.txt ]]; then
    echo " ✔︎ %B%F{cyan}todo%f%b"
  fi
}

# This is needed to make the prompt update when mode is switched.
function zle-line-init zle-keymap-select {
  zle reset-prompt
}
zle -N zle-line-init && zle -N zle-keymap-select

# Coruscant ~/Projects/Dot Files ❯                              ✔︎ todo ♦︎ master
PROMPT='$(prompt_host) %~ $(prompt_mode) '
PROMPT2='$(prompt_mode) ' # Used when entering multi-line commands.
RPROMPT='$(prompt_todo)$(prompt_git)' && ZLE_RPROMPT_INDENT=0

if [[ $OSTYPE == darwin* ]]; then
  alias beep="afplay /System/Library/Sounds/Glass.aiff"
  alias locate="mdfind -name"
  alias tim="caffeinate tim" # Give Tim a cup of Joe! :)
  alias wifiscan="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --scan"

  alias brewi="brew install"
  alias brewr="brew uninstall"
  alias brews="brew search"
  alias brewu="brew update && brew upgrade"
  alias caski="brew install --cask --appdir=~/Applications"
else
  if type -p apt &> /dev/null; then
    alias apti="sudo apt install"
    alias aptr="sudo apt remove"
    alias apts="apt search"
    alias aptu="sudo apt update && sudo apt full-upgrade && sudo apt autoremove"
  fi

  alias free="free -h"
fi

alias dog="tac" # Woof woof! :)
alias hist="source hist"
alias hogs="du -sk * | sort --numeric-sort --reverse | head -n 15"
alias iip="curl icanhazip.com"
alias mkdir="mkdir -pv"
alias tree="tree --charset ascii"
alias untar="tar -xvf"
alias zreload="source ~/.zshenv && source ~/.zshrc"

alias cdh="dirs -v | tac"
alias cdj='cd "$(< ~/.saved_pwd)"'
alias cds='echo "Saving current path."; echo $PWD >| ~/.saved_pwd'

alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v"

alias la="ls --all -l"
alias ll="ls -l"
alias ls="ls --classify --color=auto --human-readable"

alias df="df -h"
alias du="du -sh"

alias grep="grep --color=auto"
alias rgrep="grep --binary-file=without-match --dereference-recursive --exclude-dir .git"

alias py="python3"
alias pyjson="python3 -m json.tool"
alias pyweb="python3 -m http.server 8080"

alias svtplay-dl="svtplay-dl --resume"
alias youtube-dl="youtube-dl --continue --output '%(title)s.%(ext)s'"

if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi
