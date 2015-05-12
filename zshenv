setopt no_global_rcs # Don't use config files from /etc.
umask 022

if [[ $OSTYPE == darwin* ]]; then
  path=(
    ~/Scripts/OSX(N)
    ~/Scripts(N)
    /usr/local/bin(N)
    /usr/local/Cellar/curl/*/bin(N)
    /usr/bin
    /bin
    /usr/local/sbin(N)
    /usr/sbin
    /sbin
  )
else
  path=(
    ~/Scripts/Linux(N)
    ~/Scripts(N)
    /usr/local/bin
    /usr/bin
    /usr/bin/core_perl(N)
    /bin
    /usr/local/sbin
    /usr/sbin
    /sbin
  )
fi
