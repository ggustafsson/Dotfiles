setopt no_global_rcs # Don't use config files from /etc.
umask 077


if [[ $OSTYPE == darwin* ]]; then
  # Swedish sorting order under macOS is wrong because of broken locale files,
  # picking the least messed up option.
  #
  # macOS 11.6.2 Big Sur:
  #   en_US.UTF-8     - 1 2 3 A Å Ä B C Ö U V W a å ä b c ö u v w
  #   sv_SE.UTF-8     - 1 2 3 A B C U V W a b c u v w Ä Å Ö ä å ö
  #   sv_SE.ISO8859-1 - 1 2 3 A B C U V W Å Ä Ö a b c u v w å ä ö
  #                     + v & w are treated as the same letter.
  export LC_COLLATE=sv_SE.ISO8859-1
else
  # Swedish sorting order under Linux is almost correct, letters are treated
  # correctly but "." is ignored so directory listing is messy.
  #
  # Ubuntu Desktop 20.04.3 LTS:
  #   en_US.UTF-8     - 1 2 3 a A å Å ä Ä b B c C ö Ö u U v V w W
  #   sv_SE.UTF-8     - 1 2 3 a A b B c C u U v V w W å Å ä Ä ö Ö
  #   sv_SE.ISO8859-1 - 1 2 3 a A Ä Ö Å ö ä å b B c C u U v V w W
  #   + dot is ignored so hidden files and directories are mixed.
  export LC_COLLATE=sv_SE.UTF-8
fi

export GOPATH=~/Golang
export LANG=en_US.UTF-8

if [[ $OSTYPE == darwin* ]]; then
  # TODO: Adjust path after moving over to new MacBook Pro.
  path=(
    ${GOPATH}/bin(N)
    ~/Scripts/macOS(N)
    ~/Scripts(N)
    #/opt/homebrew/bin(N)
    #/opt/homebrew/sbin(N)
    #/opt/homebrew/opt/curl/bin(N)
    /usr/local/bin(N)
    /usr/local/sbin(N)
    /usr/local/opt/curl/bin(N)
    /usr/bin
    /usr/sbin
    /bin
    /sbin
  )
else
  # TODO: Double check this after playing around with Docker.
  path=(
    ${GOPATH}/bin(N)
    ~/Scripts/Linux(N)
    ~/Scripts(N)
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /usr/sbin
    /usr/games
    /bin
    /sbin
  )
fi
