if [[ $OSTYPE == darwin* ]]; then
  if ! pgrep -q ssh-agent; then
    # TODO: Replace after legacy decom.
    /usr/bin/ssh-add -K -q ~/.ssh/id_ed25519
    #/usr/bin/ssh-add --apple-use-keychain -q ~/.ssh/id_ed25519
  fi
else
  text=$(hostname | sed $'s/-/\t/')
  print -P "%F{yellow}"
  figlet -c -f ~/.figlet/bigmoney-nw.flf $text 2> /dev/null
  print -Pn "%f"
fi
