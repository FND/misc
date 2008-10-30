# check backup drive
if mount | grep 'on /mnt/backup' >/dev/null; then
	echo "starting backup process"
else
	echo "ERROR: backup drive not mounted"
	exit
fi

# log start time
date > /tmp/backup_log

cd ~/Scripts/backup/
rsync -a -e -v --progress ~ /mnt/backup/fnd/rsync/ --exclude-from="exclude.lst"

# log end time
date >> /tmp/backup_log

# output log
cat /tmp/backup_log
