if [[ $OSTYPE == darwin* ]]; then
  if ! pgrep -q ssh-agent; then
    /usr/bin/ssh-add --apple-use-keychain -q ~/.ssh/id_ed25519
    if [[ -f ~/.ssh/ansiblebot_key ]]; then
      /usr/bin/ssh-add --apple-use-keychain -q ~/.ssh/ansiblebot_key
    fi
  fi
else
  print -P "\n%F{yellow}"
  figlet -c -f ~/.local/share/figlet/bigmoney-nw.flf ${HOST/-/ } 2> /dev/null
  print -Pn "%f"
fi
