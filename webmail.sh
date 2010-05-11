#!/usr/bin/env sh

set -x

url=${1:?}
host=${2:?}
email=${3:?}

cmd="wget -q -O - $url | uuencode doc.html | \
	{ echo $url; echo; cat -; } | \
	mailx -s $url $email"
ssh $host $cmd
