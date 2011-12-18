#!/usr/bin/env zsh

case $OSTYPE in
	darwin*)
		brew update
		brew upgrade
	;;
	linux*) pacu ;;
	freebsd*)
		less /usr/ports/UPDATING
		echo "Do you want to update? [y/n]"
		read update
		if [[ $update == y ]] || [[ $update == yes ]]; then
			# do something
		else
			echo "Skipping update."
		fi
	;;
	openbsd*)
		# do something
	;;
esac

type gem >& /dev/null && gem update
type cheat >& /dev/null && cheat --new

