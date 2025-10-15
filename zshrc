if [[ $OSTYPE == darwin* ]]; then
  export FPATH=/opt/homebrew/share/zsh/site-functions:$FPATH
  export GPG_TTY=$(tty)
else
  export FPATH=/home/linuxbrew/.linuxbrew/share/zsh/site-functions:$FPATH
fi

export FZF_DEFAULT_OPTS="--bind ctrl-a:toggle-all,ctrl-d:deselect-all --color base16,bg+:-1,hl:bright-red,hl+:reverse:yellow,info:bright-black,marker:reverse:-1,pointer:bright-cyan --gutter ' ' --marker + --pointer '>'"
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=30;41:sg=30;43:ca=30;41:tw=30;42:ow=30;42:st=30;44:ex=01;32"
export PYTHONSTARTUP=$HOME/.pythonrc

export EDITOR=nvim
export VISUAL=$EDITOR

export LESS=Ri # --RAW-CONTROL-CHARS --ignore-case
export PAGER=less
export MANPAGER='nvim +Man!'

export NNN_COLORS=#0e0e0e0e
export NNN_FCOLORS=0b0b0c0a00000e08090b0d09 # Same as "LS_COLORS".
export NNN_OPTS=ARUdo # See "nnn -h" for details.
export NNN_PLUG='b:!bck --nnn*;y:-!yankp --nnn*'

KEYTIMEOUT=30 # Default timeout is 40. Zzzzzz...

HISTFILE=$HOME/.zhistory
HISTSIZE=9999
SAVEHIST=$HISTSIZE

# Improves behaviour of "&" and "|" input immediately after tab completion.
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;' # Removed "&|" from defaults to keep space.
ZLE_SPACE_SUFFIX_CHARS=$'&|' # Add space before "&|" if missing.


setopt correct # Try to correct spelling of commands.
setopt extendedglob
setopt interactivecomments
setopt noclobber # Don't allow overwrites of existing files with ">".
setopt promptsubst

setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histignorespace
setopt histreduceblanks
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
  for seq in {a,i}{\(,\),\[,\],\{,\},\<,\>}; do
    bindkey -M $mode $seq select-bracketed
  done
done

# Delete key.
bindkey -M viins $terminfo[kdch1] delete-char
bindkey -M vicmd $terminfo[kdch1] delete-char

# Home & End keys.
bindkey -M viins $terminfo[khome] beginning-of-line
bindkey -M vicmd $terminfo[khome] beginning-of-line
bindkey -M viins $terminfo[kend] end-of-line
bindkey -M vicmd $terminfo[kend] end-of-line

# Page Up & Page Down keys.
bindkey -M viins $terminfo[kpp] up-line-or-beginning-search
bindkey -M vicmd $terminfo[kpp] up-line-or-beginning-search
bindkey -M viins $terminfo[knp] down-line-or-beginning-search
bindkey -M vicmd $terminfo[knp] down-line-or-beginning-search

bindkey -M viins "^V" edit-command-line
bindkey -M vicmd "^V" edit-command-line

# Search for history entry matching current line up to cursor position.
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Not all is bad in Bash land. Lets assimilate instead of annihilate!
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^U" backward-kill-line
bindkey "^[." insert-last-word
bindkey "^[b" backward-word
bindkey "^[f" forward-word


zstyle ":completion:*" insert-tab pending # No tab characters at prompt.
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*" matcher-list "m:{[:lower:]}={[:upper:]}" # Smartcase.
zstyle ":completion:*" menu select
zstyle ":completion:*" special-dirs true # Make "cd ..<tab>" append "/" etc.

if [[ $OSTYPE == darwin* ]]; then
  compdef _man man2pdf
fi

compdef _nnn n3


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
  if [[ $HOST == Onett ]]; then
    echo "🏠 %B%F{green}$HOST%f%b"
  elif grep -qs docker /proc/1/cgroup; then
    echo "🐳 %B%F{cyan}$HOST%f%b"
  else
    echo "💀 %B%F{yellow}$HOST%f%b"
  fi
}

# Display current path but limit depth to two levels.
function prompt_path {
  echo " 📁 %B%F{blue}%2d%f%b"
}

# Display Git branch name. State is indicated through color.
function prompt_git {
  if ! git rev-parse --is-inside-work-tree &> /dev/null; then
    return
  fi

  branch=$(git branch --show-current 2> /dev/null)
  if [[ -z $branch ]]; then
    branch="?" # Detached HEAD state has no branch name.
  fi
  if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
    echo " 📦 %B%F{red}$branch*%f%b"
  elif [[ -n $(git log --max-count 1 @{upstream}.. 2> /dev/null) ]]; then
    echo " 📦 %B%F{yellow}$branch+%f%b"
  else
    echo " 📦 %B%F{green}$branch%f%b"
  fi
}

# Display info if a todo file is found in current directory.
function prompt_todo {
  files=(.todo(N) .todo.*(N) TODO(N) TODO.*(N))
  if [[ -n $files ]]; then
    echo " 📄 %B%F{magenta}todo%f%b"
  fi
}

# Display current Vi mode. Insert ">>" or "++", command "<<" and replace "**".
function prompt_mode {
  if [[ $KEYMAP == vicmd ]]; then
    echo "%B%F{red}<<%f%b"
  elif [[ $prompt_replace == 1 ]]; then
    echo "%B%F{red}**%f%b"
  else
    if [[ $1 == 2 ]]; then
      char="++"
    else
      char=">>"
    fi

    # if $? == true then green
    # if $? == false then red
    echo "%B%(?.%F{green}.%F{red})$char%f%b"
  fi
}

# 🏠 Onett 📁 Projects/Dotfiles 📦 master 📄 todo
# >>
#
# 🐳 ubuntu-lxc1 📁 Projects/Dotfiles 📦 master 📄 todo
# >>
#
# 💀 Twoson 📁 Projects/Dotfiles 📦 master 📄 todo
# >>
PROMPT=$'\n$(prompt_host)$(prompt_path)$(prompt_git)$(prompt_todo)\n$(prompt_mode) '
PROMPT2='$(prompt_mode 2) ' # Used when entering multi-line commands.


if [[ $OSTYPE == darwin* ]]; then
  alias beep="afplay /System/Library/Sounds/Glass.aiff"
  alias put="pbpaste"
  alias stat="stat -x"

  alias grep="ggrep --binary-files=without-match --color=auto"
  alias bgrep="\grep --binary-files=without-match --color=auto"

  alias ls="gls --classify=auto --color=auto --human-readable --literal"
  alias bls="\ls -FGh"
else
  alias free="free -h"
  alias grep="grep --binary-files=without-match --color=auto"
  alias ls="ls --classify=auto --color=auto --human-readable --literal"
fi

alias crg="cargo"
alias fd="fd --follow --no-ignore"
alias iip="curl icanhazip.com"
alias n3="source n3"
alias nocol="sed 's/\x1B\[[0-9;]\{1,\}m//g'" # Strips all color codes.
alias now="date '+%a %-e %b  %T  %F'"
alias uniqs="sort | uniq"
alias untar="tar -xvf"
alias watch="watch --color --difference"
alias xlns="tr '\n' '\0' | xargs -0 -o"
alias zreload="source ~/.zshenv && source ~/.zshrc"

alias dog="view"
alias vim="nvim"
alias vimdiff="nvim -d"

alias cdb="source cdb"
alias cdj="source cdj"
alias dirs="dirs -v"

alias cp="cp -vi"
alias ln="ln -v"
alias mkdir="mkdir -pv"
alias mv="mv -vi"
alias rm="rm -v"

alias df="df -h"
alias du="du -hs"

alias hist="\history -i -25"
alias history="history -i 1"

alias la="ls -l --all"
alias ll="ls -l"

alias ps="ps a -o user,tt,pid,command"
alias psx="\ps ax -o user,tt,pid,command"

alias py="python3"
alias pyjson="python3 -m json.tool"
alias pyweb="python3 -m http.server 8080"

alias rg="rg --follow --no-ignore --sort path"
alias rgrep="rg --no-heading"
alias xxx="rg '\b(FIXME|NOTE|TODO|XXX)(:|$| )'"

alias svtplay-dl="svtplay-dl --resume"
alias youtube-dl="youtube-dl --continue --output '%(title)s.%(ext)s'"


if [[ -d ~/.local/share/fzf/shell ]]; then
  source ~/.local/share/fzf/shell/completion.zsh
  source ~/.local/share/fzf/shell/key-bindings.zsh

  bindkey "^F" fzf-file-widget && bindkey -r "^T"
  bindkey "^J" fzf-cd-widget   && bindkey -r "^[c"
fi

if [[ -d ~/.local/share/zsh-autosuggestions ]]; then
  source ~/.local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi
