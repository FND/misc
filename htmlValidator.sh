#!/usr/bin/env sh

filename=${1:?}

tmpfile="/tmp/validator$$.html"

echo "validating $filename..."
curl -X POST -F uploaded_file=@"$filename" -F charset="(detect automatically)" \
	-F doctype=inline -F group=0 -s http://validator.w3.org/check > $tmpfile # -F output=json
w3m $tmpfile
rm $tmpfile
