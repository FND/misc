#!/bin/bash
#./waterping.sh 0 0
#If you want to ping the coordinates x0, y0
dbus-send --type=method_call --dest=org.freedesktop.compiz /org/freedesktop/compiz/water/allscreens/point org.freedesktop.compiz.activate string:'root' int32:`xwininfo -root | grep id: | awk '{ print $4 }'` string:'amplitude' double:1 string:'x' int32:$1 string:'y' int32:$2
