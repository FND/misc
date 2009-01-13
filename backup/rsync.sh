# Usage:
#  rsync.sh <full|minimal>
#
# To Do:
# * sort out directory structure
# * optimizations

# check mode
if [ "$1" = "full" ]; then
	MODE=$1
	BACKUPDIR="/mnt/backup/backup/fnd_minimal"
elif [ "$1" = "minimal" ];
	MODE=$1
	BACKUPDIR="/mnt/backup/backup/fnd"
else
	echo "ERROR: no mode specified"
	exit
fi

# check backup drive
if mount | grep 'on /mnt/backup' >/dev/null; then
	echo "starting backup process"
else
	echo "ERROR: backup drive not mounted"
	exit
fi

# log start time
STARTTIME=$(date +"%Y-%m-%d %H:%M:%S")

# rotate backup directories -- XXX: potentially unsafe/confusing
mv $BACKUPDIR/current $BACKUPDIR/tmp
mv $BACKUPDIR/alt $BACKUPDIR/current
mv $BACKUPDIR/tmp $BACKUPDIR/alt

# start sync'ing
SOURCEDIR="~"
cd ~/Scripts/backup/
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
