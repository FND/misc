#!/usr/bin/env bash

# Usage:
#   $ rsync.sh <full|minimal> <device>
#
# To Do:
# * sort out directory structure
# * optimizations

#set -e
set -x

# check mode
if [ "$1" = "full" ]; then
	MODE=$1
	BACKUPDIR="/mnt/backup/backup/fnd"
elif [ "$1" = "minimal" ]; then
	MODE=$1
	BACKUPDIR="/mnt/backup/backup/fnd_minimal"
else
	echo "ERROR: no mode specified"
	exit 1
fi

# mount backup drive
DEVICE="$2"
sudo umount $DEVICE
sudo mount $DEVICE /mnt/backup || {
	echo "ERROR: could not mount device";
	exit 1; }

# check backup drive
if mount | grep "on /mnt/backup" >/dev/null; then
	echo "starting backup process"
else
	echo "ERROR: backup drive not mounted"
	exit 1
fi

# log start time
STARTTIME=$(date +"%Y-%m-%d %H:%M:%S")

# rotate backup directories -- XXX: potentially unsafe/confusing
mv $BACKUPDIR/current $BACKUPDIR/tmp
mv $BACKUPDIR/alt $BACKUPDIR/current
mv $BACKUPDIR/tmp $BACKUPDIR/alt

# start sync'ing
SOURCEDIR="/home/fnd"
cd $SOURCEDIR/Scripts/backup/
if [ "$1" = "full" ]; then
	rsync -a -e -v --progress $SOURCEDIR $BACKUPDIR/current/ --exclude-from="exclude.lst"
else
	rsync -a -e -v --progress $SOURCEDIR $BACKUPDIR/current/ --include-from="include.lst"
fi

# log end time and duration
ENDTIME=$(date +"%Y-%m-%d %H:%M:%S")
echo "started: $STARTTIME"
echo "ended  : $ENDTIME"
echo "start: $STARTTIME - end: $ENDTIME" >> $BACKUPDIR/backup.log

# unmount prompt
PS3="Unmount backup device?"
OPTIONS="yes no"
select i in $OPTIONS; do
	if [ "$i" = "yes" ]; then
		sudo umount $DEVICE
	fi
	exit
done
