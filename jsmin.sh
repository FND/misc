#!/usr/bin/env bash

SOURCE=$1
shift
TARGET=$1 # TODO: $SOURCE.min.js

# TODO: error messages
[ -z $SOURCE ] && exit 1
[ -z $TARGET ] && exit 1
[ -f $TARGET ] && exit 1

STARTPATTERN="\/\*"
ENDPATTERN="\*\/"
HEADER=`cat $SOURCE \
	| sed -e "/$ENDPATTERN/q" \
	| sed -n "/^$STARTPATTERN/,/$ENDPATTERN/ p"`

echo "$HEADER" > $TARGET # TODO: should be optional
java -jar yuicompressor-*.jar $SOURCE >> $TARGET
