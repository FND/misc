#!/usr/bin/env sh

set -x

url=${1:?}
host=${2:?}
email=${3:?}

cmd="wget -q -O - $url | uuencode doc.html | /bin/mailx -s $url $email"
ssh $host $cmd
