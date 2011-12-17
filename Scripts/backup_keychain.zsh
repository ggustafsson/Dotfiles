#!/usr/bin/env zsh

sparsebundle=/Volumes/Keychain/Backup.sparseimage
backup_location=/Volumes/Backup

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

hdiutil attach -noverify $sparsebundle

for directory in $directories; do
	rsync -ah --progress --delete ~/$directory $backup_location
done

hdiutil detach $backup_location
diskutil eject Keychain

