#!/usr/bin/env zsh

case $OSTYPE in
	darwin*)
		brew update
		brew upgrade
	;;
	linux*) pacu ;;
	freebsd*)
		less /usr/ports/UPDATING
		# ask + do something ;;
	openbsd*) # do something ;;
esac

if ! $(type -p gem > /dev/null); then
	gem update
fi

if ! $(type -p gem > /dev/null); then
	cheat --new
fi

