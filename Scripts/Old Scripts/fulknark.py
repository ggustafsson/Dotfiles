#!/usr/bin/env python
# coding=utf-8

# Göran Gustafsson <gustafsson.g@gmail.com>

import ftplib
import os
import sys

server = 'fulknark.se'
username = ''
password = ''

arguments = len(sys.argv)
clipboardProgram = 'xclip -selection primary >& /dev/null'
counter = 0

def status(block):
  global counter
  counter += 1

  if counter <= 10:
    print('==', end='')
    sys.stdout.flush()

def usage():
  print('usage: ' + os.path.basename(sys.argv[0]) + ' [-p] <file>')

if arguments is 2:
  filepath = sys.argv[1]
  filename = os.path.basename(filepath)
  fixedFilename = filename.replace(' ', '%20')

  url = 'http://' + server + '/files/' + fixedFilename

  if os.path.isfile(filepath):
    filesize = os.path.getsize(filepath)
    filesizeMb = round(filesize / (1024 * 1024), 2)
    splitSize = int(filesize / 10)

    print('Uploading ' + filename + ' (' + str(filesizeMb) + 'Mb) to ' + server)

    ftp = ftplib.FTP(server, username, password)
    #ftp.set_debuglevel(2)

    print('\033[0;37m\n_____________________ <- fully erect penis size\033[1;32m')

    ftp.storbinary('STOR files/' + filename, open(filepath, 'rb'), splitSize, status)

    if splitSize is 0:
      print('====================', end='')

    print('D \033[0m~~\n\033[1;32m_))\033[0m\n\nURL: ' + url)
    os.system('echo ' + url + ' | ' + clipboardProgram)

    ftp.quit()
  else:
    print(filepath + ' doesn\'t exist!')
elif arguments is 3:
  flag = sys.argv[1]

  if flag == '-p':
    filepath = sys.argv[2]
    filename = os.path.basename(filepath)
    fixedFilename = filename.replace(' ', '%20')

    url = 'http://paste.' + server + '/' + fixedFilename

    if os.path.isfile(filepath):
      print('Uploading ' + filename + ' to ' + server)

      ftp = ftplib.FTP(server, username, password)
      #ftp.set_debuglevel(2)
      ftp.storbinary('STOR paste/' + filename, open(filepath, 'rb'))

      os.system('echo ' + url + ' | ' + clipboardProgram)

      ftp.quit()
    else:
      print(filepath + ' doesn\'t exist!')
  else:
    usage()
else:
  usage()

