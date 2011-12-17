#!/usr/bin/env bash

BACKUPDIR=Backup
TARGZFILE=backup.tar.gz

SERVER="fulknark.se"
USERNAME="fulknark.se"
PASSWORD=""

cd ~

echo "Removing old backup files."
rm -rf $BACKUPDIR
mkdir $BACKUPDIR

echo "Copying files to backup dir."
cp /boot/grub/menu.lst $BACKUPDIR/boot_grub_menu.lst
cp /etc/X11/xdm/Xresources $BACKUPDIR/etc_X11_xdm_Xresources
cp /etc/X11/xdm/popasmurf.xpm $BACKUPDIR/etc_X11_xdm_popasmurf.xpm
cp /etc/bitlbee/bitlbee.conf $BACKUPDIR/etc_bitlbee_bitlbee.conf
cp /etc/crypttab $BACKUPDIR/etc_crypttab
cp /etc/fstab $BACKUPDIR/etc_fstab
cp /etc/inittab $BACKUPDIR/etc_inittab
cp /etc/iptables/iptables.rules $BACKUPDIR/etc_iptables_iptables.rules
cp /etc/kismet.conf $BACKUPDIR/etc_kismet.conf
cp /etc/kismet_drone.conf $BACKUPDIR/etc_kismet_drone.conf
cp /etc/lighttpd/lighttpd.conf $BACKUPDIR/etc_lighttpd_lighttpd.conf
cp /etc/motd $BACKUPDIR/etc_motd
cp /etc/proftpd.conf $BACKUPDIR/etc_proftpd.conf
cp /etc/rc.conf $BACKUPDIR/etc_rc.conf
cp /etc/rc.d/ninja_encrypt $BACKUPDIR/etc_rc.d_ninja_crypt
cp /etc/syslog-ng.conf $BACKUPDIR/etc_syslog-ng.conf
cp /etc/udev/rules.d/10-sdcard.rules $BACKUPDIR/etc_udev_rules.d_10-sdcard.rules
cp /home/twiggy/.Xdefaults $BACKUPDIR/home_Xdefaults
cp /home/twiggy/.xbindkeysrc $BACKUPDIR/home_xbindkeysrc
cp /home/twiggy/.bashrc $BACKUPDIR/home_bashrc
cp /home/twiggy/.config/chromium/Default/Bookmarks $BACKUPDIR/home_config_chromium_Default_Bookmarks
cp /home/twiggy/.ratpoisonrc $BACKUPDIR/home_ratpoisonrc
cp /home/twiggy/.screenrc $BACKUPDIR/home_screenrc
cp /home/twiggy/.vimrc $BACKUPDIR/home_vimrc
cp /home/twiggy/.xinitrc $BACKUPDIR/home_xinitrc
cp -R /etc/proftpd $BACKUPDIR/etc_proftpd
cp -R /home/twiggy/.irssi $BACKUPDIR/home_irssi
cp -R /home/twiggy/.mpd $BACKUPDIR/home_mpd
cp -R /home/twiggy/Shell\ Scripts $BACKUPDIR/home_Shell\ Scripts

echo "Writing down date of backup."
date > $BACKUPDIR/backup_date.txt

echo -e "Creating $TARGZFILE.\n"
tar -zcvf $TARGZFILE $BACKUPDIR/*

echo -e "\nEncrypting $TARGZFILE with GnuPG.\n"
gpg2 --batch --passphrase backup69 -c $TARGZFILE

echo -e "Uploading $TARGZFILE.gpg to $SERVER."
curl -T $TARGZFILE.gpg -u $USERNAME:$PASSWORD ftp://$SERVER

echo -e "\nDeleting $TARGZFILE and $TARGZFILE.gpg file."
rm $TARGZFILE*

