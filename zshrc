# Göran Gustafsson (gustafsson.g@gmail.com)

export GEM_HOME=~/.ruby
export LC_COLLATE=C
export LESS=R
export PAGER=less

DIRSTACKSIZE=17
TODO_FILE=~/Documents/Text\ Files/Things\ to\ Do.txt

HISTFILE=~/.zsh_histfile
HISTSIZE=2000
SAVEHIST=5000

if [[ $OSTYPE == darwin* ]]; then
	export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent"
	export GIT_EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
	export VISUAL=$EDITOR

	FLACDIR=/Volumes/Black\ Disk/Music/FLAC
	MP3DIR=/Volumes/Black\ Disk/Music/MP3

	path=(/usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin /usr/X11/bin ~/Scripts ~/.ruby/gems/*/bin)

	print -Pn "\e]0;Zsh\a"
else
	export EDITOR=vim
	export VISUAL=$EDITOR

	export LS_COLORS="ln=01;34"
	export LS_COLORS="$LS_COLORS:*.bmp=01;33:*.gif=01;33:*.ico=01;33:*.jpg=01;33:*.jpeg=01;33:*.png=01;33:*.svg=01;33:*.tiff=01;33"
	export LS_COLORS="$LS_COLORS:*.flac=01;35:*.nsf=01;35:*.nsfe=01;35:*.m4r=01;35:*.mp3=01;35:*.ogg=01;35:*.wav=01;35"
	export LS_COLORS="$LS_COLORS:*.avi=01;36:*.flv=01;36:*.f4v=01;36:*.mkv=01;36:*.mov=01;36:*.mpg=01;36:*.mpeg=01;36:*.mp4=01;36:*.m4v=01;36:*.wmv=01;36"
	export LS_COLORS="$LS_COLORS:*.dmg=01;31:*.iso=01;31:*.rar=01;31:*.tar=01;31:*.tar.bz2=01;31:*.tar.gz=01;31:*.zip=01;31"

	FLACDIR=~/Music/FLAC
	MP3DIR=~/Music/MP3

	path=(/bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin ~/Scripts)

	if [[ $TTY == /dev/tty1 ]]; then
		startx

		[ $? -eq 0 ] && exit
	fi
fi

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

zstyle ':completion:*'          matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*'          special-dirs true
zstyle ':completion:*:cd:*'     ignore-parents parent pwd
zstyle ':completion:*:warnings' format "zsh: no matches found."

compdef _man manp
compdef _path_files cd

precmd() {
	echo
}

function git_branch {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	BRANCH=${ref#refs/heads/}

	[[ -f TODO.txt ]] && echo -n "$(sed '/^\s*$/d' TODO.txt | wc -l 2> /dev/null) "

	if [[ -n $(git status -s 2> /dev/null) ]]; then
		echo "%{$fg[red]%}$BRANCH%{$reset_color%}"
	else
		echo "%{$fg[green]%}$BRANCH%{$reset_color%}"
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
		echo "%{$fg[red]%}E%{$reset_color%}"
	elif [[ $REPLACE == 1 ]]; then
		echo "%{$fg[magenta]%}R%{$reset_color%}"
	else
		echo "%{$fg[blue]%}$%{$reset_color%}"
	fi
}

PROMPT="%B${(C)USER} %{$fg[yellow]%}${(C)HOST%%.*}%{$reset_color%}%b %~ %B$(zsh_mode)%b "
RPROMPT='%B$(git_branch)%b'

if [[ $OSTYPE == darwin* ]]; then
	alias c="clear"
	alias dontsleep="pmset noidle"
	alias eject="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true)' && echo 'All external drives ejected!'"
	alias cdb="cd /Volumes/Black\ Disk"

	alias cv="cvim"
	alias cvim="/Applications/MacVim.app/Contents/MacOS/Vim"
	alias vimdiff="/Applications/MacVim.app/Contents/MacOS/Vim -d -g $* > /dev/null"
	alias vimp="/Applications/MacVim.app/Contents/MacOS/Vim - -g > /dev/null"

	alias dae="ls -lae"
	alias de="ls -le"
	alias ls="ls -Gh"

	alias f="open ."
	alias o="open"

	alias awk="gawk"
	alias cal="gcal -s 1"
	alias head="ghead"
	alias sed="gsed"
	alias sort="gsort"
	alias tail="gtail"
	alias wc="gwc"

	alias startmpd="echo 'Starting MPD daemon.' && mpd"
	alias stopmpd="echo 'Stopping MPD daemon.' && mpc -q stop && mpd --kill"
else
	alias c="clearcmd"
	alias cal="cal -m"
	alias ls="ls -h --color=auto"
	alias vimp="vim -"
	alias vl="tail -n $LINES -f /var/log/everything.log"

	alias paci="sudo pacman -S"
	alias pacr="sudo pacman -Rs"
	alias pacu="sudo pacman -Syu"
fi

alias bc="bc -q"
alias df="df -h"
alias dh="dirs -v"
alias favs="mv -f ~/.mpd/playlists/Favorites.m3u ~/.mpd/tmp.playlist > /dev/null && sort ~/.mpd/tmp.playlist | uniq > ~/.mpd/playlists/Favorites.m3u"
alias fetch="wget --page-requisites --adjust-extension --convert-links"
alias grep="grep --color=auto -i"
alias hi="history"
alias ip="curl -s http://automation.whatismyip.com/n09230945.asp | html2text"
alias ka="killall"
alias mkdir="mkdir -pv"
alias ping="ping -c 10"
alias pyweb="python3 -m http.server 8080"
alias reload="source ~/.zshrc"
alias s="screen"
alias tv="vim '$TODO_FILE'"
alias ycal="cal $(date +%Y)"
alias yt="youtube-dl -l"
alias zv="vim ~/.zshrc"

alias -- -="cd -"
alias ...="cd ../.."
alias ..="cd .."

alias cdd="cd ~/Downloads"
alias cdp="cd ~Projects"

alias cl="wc -l"
alias cw="wc -w"
alias g="grep"
alias he="head"
alias l="less"
alias rg="grep -r"
alias so="sort"
alias ta="tail"
alias un="uniq"

alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v"

alias csd='echo "Change directory to saved PATH." && cd $SAVE_DIR'
alias sd='echo "Saving current PATH." && SAVE_DIR=$PWD'

alias d="ls -l"
alias da="ls -la"
alias l1="ls -1"
alias la="ls -a"

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
alias gpl="git pull"
alias gpu="git push"
alias gst="git status -s -b"

alias int="tim.zsh -i"
alias pomo="tim.zsh -p"
alias ti="tim.zsh"

alias next="mpc next | head -n 1"
alias prev="mpc prev | head -n 1"
alias song="mpc current"
alias toggle="mpc toggle | head -n 2"

alias top="top -o cpu"
alias topme="top -o cpu -U twiggy"

alias v="vim"
alias vd="vimdiff"
alias vp="vimp"

for x in {1..16}; do
	alias +$x="cd +$x > /dev/null"
done

if [[ $OSTYPE == darwin* ]]; then
	function frees {
		rm -rf ~/Library/Caches/Homebrew
		rm -rf ~/Library/Caches/com.apple.Safari/Webpage\ Previews
		rm -rf ~/Library/Mail Downloads
		rm -rf ~/Library/iTunes/iPhone\ Software\ Updates
	}

	function manp {
		for arg in $*; do
			man -t $arg | open -f -a Preview
		done
	}

	function ql {
		for arg in $*; do
			qlmanage -p $* >& /dev/null
		done
	}

	function vim {
		if [ -z $* ]; then
			/Applications/MacVim.app/Contents/MacOS/Vim -g
		else
			/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent $*
		fi
	}
else
	if [[ $TERM == rxvt-unicode ]]; then
		function clearcmd {
			for x in {1..$LINES}; do
				echo
			done

			clear
		}
	else
		alias clearcmd="clear"
	fi

	function pacs {
		CL='\\e['
		RS='\\e[0;0m'

		echo -e "$(pacman -Ss "$*" | sed "
			/^core/         s,.*,${CL}1;31m&${RS},
			/^extra/        s,.*,${CL}0;32m&${RS},
			/^community/    s,.*,${CL}1;35m&${RS},
			/^[^[:space:]]/ s,.*,${CL}0;36m&${RS},
		")" | less -R
	}

	function restart {
		for arg in $*; do
			sudo /etc/rc.d/$arg restart
		done
	}

	function start {
		for arg in $*; do
			sudo /etc/rc.d/$arg start
		done
	}

	function stop {
		for arg in $*; do
			sudo /etc/rc.d/$arg stop
		done
	}
fi

function chkm {
	find "$FLACDIR" -type f ! -iname "*.flac" ! -iname "*.log"
	find "$MP3DIR" -type f ! -iname "*.mp3"
}

function chkp {
	local CURRENT_DIR=$PWD
	local CLEAN_BRANCH

	for dir in ~/Projects/*; do
		cd $dir

		if [[ -n $(git status -s 2> /dev/null) ]]; then
			echo "\033[1;31m$dir:t:\033[0m"
			git status -s
			echo
		else
			CLEAN_BRANCH="$CLEAN_BRANCH * $dir:t\n"
		fi
	done

	echo -n "\033[1;34mClean branches:\033[0m\n$CLEAN_BRANCH"

	cd $CURRENT_DIR
}

function ff {
	if [ ! -z $* ]; then
		find . -iname $* | sed 's/.\///'
	else
		echo "Usage: $0 [PATTERN]..."
	fi
}

function fff {
	if [ ! -z $* ]; then
		find "$PWD" -iname $*
	else
		echo "Usage: $0 [PATTERN]..."
	fi
}

function h {
	if [ ! -z $* ]; then
		history -i 1 | grep "$*"
	else
		history -i 1 | less +G
	fi
}

function mkcd {
	if [ ! -z $* ]; then
		mkdir -p "$*"
		cd "$*"
	else
		echo "Usage: $0 [NAME]..."
	fi
}

function p {
	if [ ! -z $* ]; then
		ps ax | grep -v "grep --color -i $*" | grep "$*"
	else
		ps ax
	fi
}

function permf {
	if [[ $OSTYPE == darwin* ]]; then
		find . -type d -exec chmod -N 755 "{}" \;
		find . -type f -exec chmod -N 644 "{}" \;
	else
		find . -type d -exec chmod 755 "{}" \;
		find . -type f -exec chmod 644 "{}" \;
	fi
}

function ppermf {
	if [[ $OSTYPE == darwin* ]]; then
		find . -type d -exec chmod -N 700 "{}" \;
		find . -type f -exec chmod -N 600 "{}" \;
	else
		find . -type d -exec chmod 700 "{}" \;
		find . -type f -exec chmod 600 "{}" \;
	fi
}

function systemu {
	if [[ $OSTYPE == darwin* ]]; then
		brew update
		brew upgrade
	else
		pacu
	fi

	gem update
	cheat --new
}

function t {
	if [ ! -f $TODO_FILE ]; then
		echo "TODO file does not exist."

		return
	elif [ ! -s $TODO_FILE ]; then
		echo "TODO file is currently empty."

		return
	fi

	if [ -z $* ]; then
		cat $TODO_FILE
	else
		echo "$*" >> $TODO_FILE
	fi
}

function unp {
	[ -z $* ] && echo "Usage: $0 [FILENAME]..." && return

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

