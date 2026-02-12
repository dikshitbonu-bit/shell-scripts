#!/bin/bash
#
############# This is a shell script for backup and 14 day rotation #######

src="$1"
dst="$2"
time=$( date '+%Y-%m-%d-%H-%M-%S')

# Check if src exists or not
if [ ! -d "$src" ]; then
	echo "source doesn't exist"
	exit 1
fi
# Make the dst if it doesn't exist
#
if [ ! -d "$dst" ]; then
	mkdir -p "$dst"
fi


# do the backup
#
#
backup="$dst/backup-$time.tar.gz"
tar -czf "$backup" "$src" 2>/dev/null

# Verify if backup exists or not
#
#
if [ ! -f "$backup" ]; then
	exit 1
fi

#Show size of backup

du -h "$backup"

#delete old backups (older than 14 days)
find "$dst" -name "backup-*.tar.gz" -mtime +14 -delete

