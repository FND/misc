#!/usr/bin/env bash

# Usage:
#   ./jsmin.sh source [target]

srcfile=$1
shift
outfile=$1

function quit {
	echo "aborting: $1"
	exit 1
}

[ -z $srcfile ] && quit "source file not specified"
if [ -z $outfile ]; then
	outfile="${srcfile:0:${#srcfile}-3}.min.js"
fi
[ -f $outfile ] && quit "target file already exists"
[ -f yuicompressor*.jar ] || quit "YUICompressor not found"

startpattern="\/\*"
endpattern="\*\/"
header=`cat $srcfile \
	| sed -e "/$endpattern/q" \
	| sed -n "/^$startpattern/,/$endpattern/ p"`

echo "$header" > $outfile # TODO: should be optional
java -jar yuicompressor-*.jar $srcfile >> $outfile
