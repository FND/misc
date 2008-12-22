# cf. https://answers.launchpad.net/ubuntu/+question/51440

check=`/etc/init.d/bluetooth status | grep "is running"`

if [ -z "$check" ]; then
	echo "Initializing bluetooth..."
	modprobe btusb
	hciconfig hci0 up
	/etc/init.d/bluetooth start
else
	echo "Stopping bluetooth..."
	/etc/init.d/bluetooth stop
	hciconfig hci0 down
	sleep 1
	rmmod btusb
fi
