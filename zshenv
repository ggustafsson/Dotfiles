setopt no_global_rcs # Don't use config files from /etc.
umask 077


if [[ $OSTYPE == darwin* ]]; then
  export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

  # XXX: Swedish sorting order under macOS is wrong because of broken locale
  # files, picking the least messed up option.
  #
  # macOS 12.4 Monterey:
  #   en_US.UTF-8     - 1 2 3 A Å Ä B C Ö U V W a å ä b c ö u v vb w wa
  #   sv_SE.UTF-8     - 1 2 3 A B C U V W a b c u v vb w wa Ä Å Ö ä å ö
  #   sv_SE.ISO8859-1 - 1 2 3 A B C U V W Å Ä Ö a b c u v w wa vb å ä ö
  #                     + v & w are treated as the same letter.
  export LC_COLLATE=sv_SE.ISO8859-1
else
  # XXX: Swedish sorting order under Linux is almost correct, letters are
  # treated correctly but "." is ignored so directory listing is messy.
  #
  # Ubuntu 22.04 LTS:
  #   en_US.UTF-8     - 1 2 3 a A å Å ä Ä b B c C ö Ö u U v V vb w W wa
  #   sv_SE.UTF-8     - 1 2 3 a A b B c C u U v V vb w W wa å Å ä Ä ö Ö
  #   sv_SE.ISO8859-1 - 1 2 3 a A Ä Ö Å ö ä å b B c C u U v V vb w W wa
  #   + dot is ignored so hidden files and directories are mixed.
  export LC_COLLATE=sv_SE.UTF-8
fi

export GOPATH=~/Golang
export LANG=en_US.UTF-8

if [[ $OSTYPE == darwin* ]]; then
  path=(
    ~/.local/bin(N)
    ~/.rd/bin(N)
    ~/Scripts/macOS(N)
    ~/Scripts(N)
    ~/Projects/Kjell/macOS(N)
    ~/Projects/Kjell(N)
    ~/Projects/Pyttipanna/macOS(N)
    ~/Projects/Pyttipanna(N)
    ${GOPATH}/bin(N)
    /opt/homebrew/opt/curl/bin(N)
    /opt/homebrew/opt/ruby/bin(N)
    /opt/homebrew/opt/python/libexec/bin(N)
    /opt/homebrew/bin(N)
    /opt/homebrew/sbin(N)
    /usr/local/bin(N)
    /usr/local/sbin(N)
    /usr/bin
    /usr/sbin
    /bin
    /sbin
  )
else
  path=(
    ~/.local/bin(N)
    ~/Scripts/Linux(N)
    ~/Scripts(N)
    ~/Projects/Kjell/Linux(N)
    ~/Projects/Kjell(N)
    ~/Projects/Pyttipanna/Linux(N)
    ~/Projects/Pyttipanna(N)
    ${GOPATH}/bin(N)
    /home/linuxbrew/.linuxbrew/bin(N)
    /home/linuxbrew/.linuxbrew/sbin(N)
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /usr/sbin
    /usr/games
    /bin
    /sbin
  )
fi
