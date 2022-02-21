if [[ $OSTYPE == darwin* ]]; then
  if ! pgrep -q ssh-agent; then
    # TODO: Check if things have changed in macOS Monterey.
    /usr/bin/ssh-add -K -q ~/.ssh/id_ed25519
  fi
else
  text=$(hostname | sed $'s/-/\t/')
  figlet -c -f ~/.figlet/bigmoney-nw.flf $text 2> /dev/null
fi
