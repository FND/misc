function VGAOut() {
	if [ $1 = true ]; then
		echo "enabling VGA-Out"
		xrandr --output VGA --auto --right-of LVDS
	elif [ $1 = false ]; then
		echo "disabling VGA-Out"
		xrandr --output VGA --off
	fi
}

function panelPos() {
	if [ $1 = true ]; then
		gconftool-2 -t int -s /apps/panel/toplevels/top_panel_screen0/monitor 1
		gconftool-2 -t int -s /apps/panel/toplevels/panel_2/monitor 1
	elif [ $1 = false ]; then
		gconftool-2 -t int -s /apps/panel/toplevels/top_panel_screen0/monitor 0
		gconftool-2 -t int -s /apps/panel/toplevels/panel_2/monitor 0
	fi
}


# command-line parameter
if [ $1 = "e" ]; then
	VGAOut true
	panelPos true
	exit
elif [ $1 = "d" ]; then
	VGAOut false
	panelPos false
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
