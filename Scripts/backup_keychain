#!/usr/bin/env zsh

device_name=Keychain
encrypted_image=/Volumes/Keychain/Backup.sparseimage
backup_destination=/Volumes/Backup

directories=(
	Development
	Documents
	Dropbox
	"Library/Application Support/Adium 2.0"
	Movies/Recorded
	"Music/iPhone Ringtones"
	Pictures
	Projects
	Scripts
	Sites
	Storage
	"Web Archives"
)

hdiutil attach -noverify $encrypted_image

for directory in $directories; do
	rsync -ah --progress --delete ~/$directory $backup_destination
done

hdiutil detach $backup_destination
diskutil eject $device_name

