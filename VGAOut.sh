function VGAOut() {
	if [ $1 = true ]; then
		echo "enabling VGA-Out"
		xrandr --output VGA --auto --right-of LVDS
	elif [ $1 = false ]; then
		echo "disabling VGA-Out"
		xrandr --output VGA --off
	fi
}

# command-line parameter
if [ $1 = "e" ]; then
	VGAOut true
	exit
elif [ $1 = "d" ]; then
	VGAOut false
	exit
fi

# selection menu
PS3="Secondary screen (VGA out)"
OPTIONS="enable disable"
select i in $OPTIONS; do
	if [ "$i" = "enable" ]; then
		VGAOut true
		exit
	elif [ "$i" = "disable" ]; then
		VGAOut false
		exit
	fi
done
