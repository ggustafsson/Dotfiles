# Script created by William Snow Orvis:
#   <http://blog.aedifice.org/2010-02-01-use-mac-os-xs-keychain-for-password-retrieval-in-offlineimap.html>.

# Description: This script fetches a password from Keychain so it can be used
# with offlineimap.
#
# To use this script put something like this inside of offlineimaprc:
#
# [general]
# pythonfile = ~/.offlineimap.py
#
# [Repository Gmail-Remote]
# type = Gmail
# remoteuser = someuser@gmail.com
# remotepasseval = get_keychain_pass(account="someuser@gmail.com", server="imap.gmail.com")

import re, commands

def get_keychain_pass(account=None, server=None):
    params = {
        "security": "/usr/bin/security",
        "command":  "find-internet-password",
        "account":  account,
        "server":   server
    }

    command = "%(security)s %(command)s -g -a %(account)s -s %(server)s" % params
    outtext = commands.getoutput(command)
    return re.match(r'password: "(.*)"', outtext).group(1)
