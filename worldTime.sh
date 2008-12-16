#!/bin/sh

date_format="+%Y-%m-%d %H:%M:%S %Z"

tz_UTC=`env TZ=UTC date "$date_format"`
tz_GMT=`env TZ=GMT date "$date_format"`
tz_UK=`env TZ=Europe/London date "$date_format"`
tz_DE=`env TZ=Europe/Paris date "$date_format"`
tz_AU=`env TZ=Australia/Melbourne date "$date_format"`
tz_USE=`env TZ=US/Eastern date "$date_format"`
tz_USP=`env TZ=US/Pacific date "$date_format"`

echo "UTC               $tz_UTC"
echo "GMT               $tz_GMT"
echo "London            $tz_UK"
echo "Berlin            $tz_DE"
echo "U.S. (Eastern)    $tz_USE"
echo "U.S. (Pacific)    $tz_USP"
echo "Melbourne         $tz_AU"

