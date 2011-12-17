#!/bin/bash

# Göran Gustafsson <gustafsson.g@gmail.com>
# Last modified: Thu 17 Feb 18:59:26 CET 2011

if nc -z fulknark.se 21; then
	echo -ne "\033[1;36mUpload config files to fulknark.se [\033[1;32my/n\033[1;36m]:\033[0m "
	read configbackup

	echo

	case $configbackup in
		y|yes)
			BACKUPDIR=~/.configs

			SERVER="fulknark.se"
			USERNAME=""
			PASSWORD=""

			echo "Removing old config files from backup directory."
			rm -rf $BACKUPDIR
			mkdir $BACKUPDIR

			echo "Copying config files to backup directory."
			cp ~/.Xdefaults $BACKUPDIR/Xdefaults
			cp ~/.bashrc $BACKUPDIR/bashrc
			cp ~/.conkyrc $BACKUPDIR/conkyrc
			cp ~/.gtkrc-2.0 $BACKUPDIR/gtkrc-2.0
			cp ~/.ncmpcpp/config $BACKUPDIR/ncmpcpp_config
			cp ~/.ncmpcpp/keys $BACKUPDIR/ncmpcpp_keys
			cp ~/.ratpoisonrc $BACKUPDIR/ratpoisonrc
			cp ~/.screenrc $BACKUPDIR/screenrc
			cp ~/.vimrc $BACKUPDIR/vimrc

			chmod 755 $BACKUPDIR
			chmod 644 $BACKUPDIR/*

			for file in $BACKUPDIR/*; do
				FILES="$FILES,$file"
			done

			FILES="{$(echo $FILES | cut -c 2-)}"

			echo "Uploading backup directory to $SERVER."
			curl -s -T $FILES -u $USERNAME:$PASSWORD ftp://$SERVER/configs/

			echo
		;;
		*)
			echo -e "Skipping uploading config files to fulknark.se.\n"
		;;
	esac
else
	echo -e "Can't access FTP server! Skipping uploading config files to fulknark.se.\n"
fi


if nc -z yoda.lan 22; then
	echo -ne "\033[1;36mBackup files to yoda.lan? [\033[1;32my/n\033[1;36m]:\033[0m "
	read yodabackup

	echo

	case $yodabackup in
		y|yes)
			echo "Backing up /etc to yoda.lan."
			sudo rsync --delete -a /etc twiggy@yoda.lan:/srv/ftp/Backup

			echo "Backing up /home to yoda.lan."
			sudo rsync --delete --exclude 'twiggy/Downloads' -a /home twiggy@yoda.lan:/srv/ftp/Backup

			echo "Backing up /srv/http to yoda.lan."
			sudo rsync --delete -a /srv/http twiggy@yoda.lan:/srv/ftp/Backup

			echo
		;;
		*)
			echo -e "Skipping backing up to yoda.lan.\n"
		;;
	esac
else
	echo -e "Can't access SSH server! Skipping backing up to yoda.lan.\n"
fi


if [ -b /dev/backup2 ] ; then
	echo -ne "\033[1;36mBackup files to external drive? [\033[1;32my/n\033[1;36m]:\033[0m "
	read externalbackup

	echo

	case $externalbackup in
		y|yes)
			if [ ! -b /dev/mapper/backup ] ; then
				echo "Opening encrypted backup partition."
				sudo cryptsetup luksOpen /dev/backup2 backup > /dev/null 2> /dev/stdout
			else
				echo "/dev/mapper/backup already opened. Skipping opening encrypted backup partition."
			fi

			if [ ! "`mount | grep /dev/mapper/backup`" != "" ] ; then
				echo "Mounting encrypted backup partition."
				sudo mount -o defaults,noatime /dev/mapper/backup /media/backup
			else
				echo "/dev/mapper/backup already mounted. Skipping mounting encrypted backup partition."
			fi

			if [ "`mount | grep /dev/mapper/backup`" != "" ] ; then
				date > /media/backup/backup_date.txt

				echo -e "\nBacking up /etc to external drive."
				sudo rsync --delete -a /etc /media/backup

				echo "Backing up /home to external drive."
				sudo rsync --delete --exclude 'twiggy/Downloads' -a /home /media/backup

				echo "Backing up /srv/http to external drive."
				sudo rsync --delete -a /srv/http /media/backup

				echo -e "\nUnmounting encrypted backup partition."
				sudo umount /dev/mapper/backup
			else
				echo "/dev/mapper/backup not mounted! Skipping backing up to external drive."
			fi

			echo "Closing encrypted backup partition."
			sudo cryptsetup luksClose /dev/mapper/backup > /dev/null 2> /dev/stdout
		;;
		*)
			echo "Skipping backing up to external drive."
		;;
	esac
else
	echo -e "Can't access /dev/backup2! Skipping backing up to external drive."
fi

