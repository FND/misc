# check backup drive
if mount | grep 'on /mnt/backup' >/dev/null; then
	echo "starting backup process"
else
	echo "ERROR: backup drive not mounted"
	exit
fi

# log start time
STARTTIME=$(date +"%Y-%m-%d %H:%M:%S")

# rotate backup directories
BACKUPDIR="/mnt/backup/backup/fnd"
mv $BACKUPDIR/current $BACKUPDIR/tmp
mv $BACKUPDIR/alt $BACKUPDIR/current
mv $BACKUPDIR/tmp $BACKUPDIR/alt

# start sync'ing
cd ~/Scripts/backup/
rsync -a -e -v --progress ~ $BACKUPDIR/current/ --exclude-from="exclude.lst"

# log end time and duration
STARTTIME=$(date +"%Y-%m-%d %H:%M:%S")
echo "started: $STARTTIME"
echo "ended  : $(date +'%Y-%m-%d %H:%M:%S')"
echo "start: $STARTTIME - end: $ENDTIME" >> $BACKUPDIR/backup.log
