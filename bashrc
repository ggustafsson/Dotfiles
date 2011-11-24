# Göran Gustafsson (gustafsson.g@gmail.com)

export HISTSIZE="20000"
export LC_COLLATE="C"
export PAGER="less"
export PROMPT_COMMAND="history -a"

export GEM_HOME="~/.ruby"
export OS=$(uname)

if [ ! $TERM == "dumb" ] ; then
	export NORMAL="\[\033[0m\]"
	export BRIGHT="\[\033[1;37m\]"
	export GREEN="\[\033[1;32m\]"
	export YELLOW="\[\033[1;33m\]"
fi

if [ $OS == "Darwin" ] ; then
	export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent"
	export PATH="/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11/bin:~/Scripts"
	export VISUAL="$EDITOR"

	export HOST=$(hostname -s)
	export HOST_FIXED="${HOST[@]^}"

	export PS1="\n$BRIGHT\u $YELLOW${HOST_FIXED} $NORMAL\w > "

	export FLACDIR="/Volumes/Black Disk/Music/FLAC"
	export MP3DIR="/Volumes/Black Disk/Music/MP3"
else
	export EDITOR="vim"
	export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/Scripts"
	export VISUAL="$EDITOR"

	export PS1="\n$BRIGHT\u $YELLOW\h $NORMAL\w > "

	export LS_COLORS="ln=01;34"
	export LS_COLORS="$LS_COLORS:*.bmp=01;33:*.gif=01;33:*.ico=01;33:*.jpg=01;33:*.jpeg=01;33:*.png=01;33:*.svg=01;33:*.tiff=01;33"
	export LS_COLORS="$LS_COLORS:*.flac=01;35:*.nsf=01;35:*.nsfe=01;35:*.m4r=01;35:*.mp3=01;35:*.ogg=01;35:*.wav=01;35"
	export LS_COLORS="$LS_COLORS:*.avi=01;36:*.flv=01;36:*.f4v=01;36:*.mkv=01;36:*.mov=01;36:*.mpg=01;36:*.mpeg=01;36:*.mp4=01;36:*.m4v=01;36:*.wmv=01;36"
	export LS_COLORS="$LS_COLORS:*.dmg=01;31:*.iso=01;31:*.rar=01;31:*.tar=01;31:*.tar.bz2=01;31:*.tar.gz=01;31:*.zip=01;31"

	export FLACDIR="~/Music/FLAC"
	export MP3DIR="~/Music/MP3"

	if [ $(tty) == "/dev/tty1" ] ; then
		startx
		logout
	fi
fi

for dir in ~/.ruby/gems/*/bin; do
	export PATH="$PATH:$dir"
done

complete -cf man
set -o vi
shopt -s cdspell checkwinsize cmdhist histappend no_empty_cmd_completion

if [ $OS == "Darwin" ] ; then
	alias c="clear"
	alias dontsleep="pmset noidle"
	alias f="open ."
	alias head="ghead"
	alias ls="ls -Gh"
	alias o="open"
	alias ql="qlmanage -p \"$@\" >& /dev/null"
	alias rmds='find "$PWD" -name ".DS_Store" -depth -exec rm {} \;'
	alias sed="gsed"
	alias startmpd="mpd ~/.mpd/config"
	alias stopmpd="killall mpd"
	alias tail="gtail"
	alias vim="/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab-silent"
	alias vimdiff="/Applications/MacVim.app/Contents/MacOS/Vim -d -g"
else
	alias c="clearcmd"
	alias cal="cal -m"
	alias ls="ls -h --color=auto"
	alias paci="sudo pacman -S"
	alias pacr="sudo pacman -Rs"
	alias pacu="sudo pacman -Syu"
	alias vl="tail -n $LINES -f /var/log/everything.log"
fi

alias ...="cd ../.."
alias ..="cd .."
alias back="cd $OLDPWD"
alias bc="bc -q"
alias cdd="cd ~/Downloads"
alias cp="cp -vi"
alias d="ls -l"
alias da="d -a"
alias dal="da | less"
alias df="df -h"
alias dl="d | less"
alias favs="cat ~/.mpd/playlists/Favorites.m3u > ~/.mpd/tmp.playlist; sort ~/.mpd/tmp.playlist | uniq > ~/.mpd/playlists/Favorites.m3u"
alias g="grep"
alias grep="grep --color"
alias ip="internet_ip.py"
alias irssi="irssi"
alias ka="killall"
alias l1="ls -1"
alias l1l="ls -1 | less"
alias l="less"
alias la="ls -a"
alias lal="la | less"
alias lsl="ls | less"
alias mv="mv -vi"
alias next="mpc next"
alias ping="ping -c 10"
alias pl="p | less"
alias pomo="timer.py -i 15"
alias prev="mpc prev"
alias pyweb="python3 -m http.server 8080"
alias reload="source ~/.bashrc"
alias s="screen"
alias song="mpc current"
alias t="cat ~/Documents/Text\ Files/Things\ to\ Do.txt"
alias ti="timer.py"
alias toggle="mpc toggle"
alias top="top -o cpu"
alias topme="top -o cpu -U twiggy"
alias tv="vim ~/Documents/Text\ Files/Things\ to\ Do.txt"
alias v="vim"
alias yt="youtube-dl -l"

if [ $OS == "Linux" ] ; then
	if [ $TERM == "rxvt-unicode" ] ; then
		function clearcmd {
			for ((i = 1; i < $LINES; i++)) ; do
				echo
			done

			clear
		}
	else
		alias clearcmd="clear"
	fi

	function pacs {
		local CL='\\e['
		local RS='\\e[0;0m'

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

function checkmusic {
	find "$FLACDIR" -type f ! -iname *.flac ! -iname *.log
	find "$MP3DIR" -type f ! -iname *.mp3
}

function h {
	if [ -z $1 ] ; then
		history | less
	else
		history | grep -i "$*" | head -n -1
	fi
}

function p {
	if [ -z $1 ] ; then
		ps ax
	else
		ps ax | grep -i "$*" | head -n -1
	fi
}

function permfix {
	find "$PWD" -type d -exec chmod 755 "{}" \;
	find "$PWD" -type f -exec chmod 644 "{}" \;
}

function privatepermfix {
	find "$PWD" -type d -exec chmod 700 "{}" \;
	find "$PWD" -type f -exec chmod 600 "{}" \;
}

function unp {
	if [ -f "$*" ] ; then
		case "$*" in
			*.tar.bz2) tar vxjf "$*";;
			*.tar.gz)  tar vxzf "$*";;
			*.bz2)     bunzip2 "$*";;
			*.rar)     unrar x "$*";;
			*.gz)      gunzip "$*";;
			*.tar)     tar vxf "$*";;
			*.tbz2)    tar vxjf "$*";;
			*.tgz)     tar vxzf "$*";;
			*.zip)     unzip "$*";;
			*.Z)       uncompress "$*";;
			*.7z)      7z x "$*";;
			*)
				echo "'$*' cannot be extracted via unp."
			;;
		esac
	else
		echo "'$*' is not a valid file."
	fi
}

