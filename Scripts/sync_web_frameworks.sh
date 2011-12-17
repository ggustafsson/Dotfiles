#!/usr/bin/env bash

# Göran Gustafsson <gustafsson.g@gmail.com>

rm -rf ~/Sites/Frameworks\ Backups

mv ~/Sites/Frameworks ~/Sites/Frameworks\ Backups
mkdir ~/Sites/Frameworks
cd ~/Sites/Frameworks

git clone git://github.com/dawanda/jquery-rss.git; echo
git clone git://github.com/imakewebthings/deck.js.git; echo
git clone git://github.com/twitter/bootstrap.git; echo

mkdir ~/Sites/Frameworks/jQuery
mkdir ~/Sites/Frameworks/MediaWiki

open 'http://docs.jquery.com/Downloading_jQuery#Current_Release'
open 'http://www.mediawiki.org/wiki/Download'

date > ~/Sites/Frameworks/latest_update.txt

