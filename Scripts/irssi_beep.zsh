#!/usr/bin/env zsh

# Written by Göran Gustafsson <gustafsson.g@gmail.com>.

FILE=~/.irssi/beep.wav

if [[ $OSTYPE == darwin* ]]; then
	afplay $FILE
else
	aplay $FILE
fi

