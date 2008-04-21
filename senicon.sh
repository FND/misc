#!/bin/bash
# requires waterping.sh
WINFO=`xwininfo -root -tree | egrep ' (1[2-9]|2[0-4])x(1[2-9]|2[0-4])\+0\+0' | grep "$1" | cut -d ')' -f 2-`
WIW=`echo $WINFO | cut -d 'x' -f 1`
WIH=`echo $WINFO | cut -d 'x' -f 2 | cut -d '+' -f 1`
WIX=`echo $WINFO | cut -d '+' -f 4`
WIY=`echo $WINFO | cut -d '+' -f 5`
let WAX=WIX+WIW/2
let WAY=WIY+WIH/2
waterping.sh $WAX $WAY 2>/dev/null
