# check backup drive
if mount | grep 'on /mnt/backup' >/dev/null; then
	echo "starting backup process"
else
	echo "ERROR: backup drive not mounted"
	exit
fi

# log start time
STARTTIME=$(date +"%Y-%m-%d %H:%M:%S")

cd ~/Scripts/backup/
rsync -a -e -v --progress ~ /mnt/backup/fnd/rsync/ --exclude-from="exclude.lst"

# output duration
echo "started: $STARTTIME"
echo "ended  : $(date +'%Y-%m-%d %H:%M:%S')"

