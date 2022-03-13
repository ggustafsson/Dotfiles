export GREP_COLORS="fn=01;34:ln=00;34:se=01;30" # File, line & separator.
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32"

export EDITOR=vim
export VISUAL=$EDITOR

export LESS=FR # --quit-if-one-screen --RAW-CONTROL-CHARS
export PAGER=less
export MANPAGER='nvim +Man!'

ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;' # Removed "&|" from defaults to keep space.

HISTFILE=~/.zhistory
HISTSIZE=9999
SAVEHIST=$HISTSIZE

if [[ $OSTYPE == darwin* ]]; then
  hash -d ext=/Volumes/External
  hash -d key=/Volumes/Keychain
  hash -d msd=/Volumes/MicroSD
else
  hash -d ext=/media/external
fi

tmp=~/Documents/Text/Tmp.txt
todo=~/Documents/Text/Todo.txt


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

autoload -U down-line-or-beginning-search && zle -N down-line-or-beginning-search
autoload -U up-line-or-beginning-search && zle -N up-line-or-beginning-search

autoload -U select-bracketed && zle -N select-bracketed
autoload -U select-quoted && zle -N select-quoted


bindkey -v
bindkey -M vicmd "R" custom-vi-replace

# Same as "backspace=indent,eol,start" in Vim.
bindkey "^?" backward-delete-char
bindkey "^H" backward-delete-char
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

# Search for history entry matching current line up to the cursor position.
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Not all is bad in Emacs land. Lets assimilate instead of annihilate!
bindkey "^A"  beginning-of-line
bindkey "^E"  end-of-line
bindkey "^R"  history-incremental-search-backward
bindkey "^U"  kill-whole-line
bindkey "^[." insert-last-word
bindkey "^['" quote-line
bindkey "^[h" run-help


zstyle ":completion:*" insert-tab pending # No tab characters at prompt.
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*" matcher-list "m:{[:lower:]}={[:upper:]}" # Smartcase.
zstyle ":completion:*" menu select
zstyle ":completion:*" special-dirs true # Make "cd ..<tab>" append "/" etc.

if [[ $OSTYPE == darwin* ]]; then
  compdef _man man2pdf
fi


# Custom Vi replace function that change a variable before and after entering
# replace mode. Variable is used in function "prompt_mode" later on.
function custom-vi-replace {
  prompt_replace=1 && zle vi-replace && prompt_replace=0
}
zle -N custom-vi-replace

# Reset prompt when switching Vi mode so function "prompt_mode" works.
function zle-keymap-select {
  zle reset-prompt
}
zle -N zle-keymap-select

# Display hostname according to various rules.
function prompt_host {
  if [[ $OSTYPE == darwin* ]]; then
    echo "🏠 %F{green}${HOST}%f "
  elif grep -qs docker /proc/1/cgroup; then
    echo "🐳 %F{cyan}${HOST}%f "
  else
    echo "💀 %F{yellow}${HOST}%f "
  fi
}

# Display current path but limit depth to two levels.
function prompt_path {
  echo "📁 %F{blue}%2d%f"
}

# Display Git branch name. State is indicated through color.
function prompt_git {
  if ! git rev-parse --is-inside-work-tree &> /dev/null; then
    return 1
  fi

  branch=$(git branch --show-current 2> /dev/null)
  if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
    echo " 📦 %F{red}${branch}%f"
  else
    echo " 📦 %F{green}${branch}%f"
  fi
}

# Display info if a todo file is found in current directory.
function prompt_todo {
  files=(.todo(N) .todo.*(N) TODO(N) TODO.*(N))
  if [[ ! -z $files ]]; then
    echo " 📄 %F{magenta}todo%f"
  fi
}

# Display current Vi mode. Insert ">>" or "++", command "<<" and replace "**".
function prompt_mode {
  if [[ $KEYMAP == vicmd ]]; then
    echo "%F{red}<<%f"
  elif [[ $prompt_replace == 1 ]]; then
    echo "%F{red}**%f"
  else
    if [[ $1 == 2 ]]; then
      char="++"
    else
      char=">>"
    fi

    # if $? == true then green
    # if $? == false then red
    echo "%(?.%F{green}.%F{red})${char}%f"
  fi
}

# 🏠 Onett 📁 Projects/Dot-Files 📦 master 📄 todo
# >>
#
# 🐳 ubuntu-lxc1 📁 Projects/Dot-Files 📦 master 📄 todo
# >>
#
# 💀 Twoson 📁 Projects/Dot-Files 📦 master 📄 todo
# >>
PROMPT=$'\n$(prompt_host)$(prompt_path)$(prompt_git)$(prompt_todo)\n$(prompt_mode) '
PROMPT2='$(prompt_mode 2) ' # Used when entering multi-line commands.


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

alias la="ls -l --all"
alias ll="ls -l"
alias ls="ls --classify --color=auto --human-readable"

alias df="df -h"
alias du="du -hs"

alias grep="grep --color=auto"
alias rgrep="grep --binary-file=without-match --dereference-recursive --exclude-dir .git"

alias py="python3"
alias pyjson="python3 -m json.tool"
alias pyweb="python3 -m http.server 8080"

alias rg="rg --follow --sort path"
alias xxx="rg '\b(FIXME|TODO|XXX)(:|$| )'"

alias svtplay-dl="svtplay-dl --resume"
alias youtube-dl="youtube-dl --continue --output '%(title)s.%(ext)s'"


if [[ -d ~/.local/share/fzf/shell ]]; then
  source ~/.local/share/fzf/shell/completion.zsh
  source ~/.local/share/fzf/shell/key-bindings.zsh

  bindkey -r "^T"
  bindkey "^O" fzf-file-widget

  bindkey -r "^[c"
  bindkey "^P" fzf-cd-widget
fi

if [[ -d ~/.zsh/zsh-autosuggestions ]]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi
