#!/usr/bin/env sh

# send a web page as e-mail attachment
#
# Usage:
#  ./webmail.sh URL host recipient sender

set -e
set -x

url=${1:?}
host=${2:?}
email=${3:?}
sender=${4:?}

tempdir="/tmp/mail$$.tmp"
attachment="doc.html"

recipient=$email
subject="[read] $url"
body=$url

boundary="GvXjxJ+pjyke8COw"

mkdir -p $tempdir
cd $tempdir
wget -q -O $attachment $url

# use page title if available
title=`grep -o "<title>.*</title>" $attachment | head -n1 | \
	sed -e "s#</\?title>##g" -e "s/^\s*\|\s*$//g" -e "s/[^0-9a-zA-Z]/_/g" | \
	cut -c 1-72` # XXX: brittle; breaks for multi-line titles, uppercase tags
if [ -n "$title" ]; then
	subject="[read] $title"
	newfile="doc_${title}.html"
	mv $attachment "$newfile"
	attachment="$newfile"
fi

{
	echo "From: $sender";
	echo "To: $recipient";
	echo "Subject: $subject";
	echo "Mime-Version: 1.0";
	echo "Content-Type: multipart/mixed; boundary=\"$boundary\"";
	echo "Content-Disposition: inline";
	echo "";
	echo "This is a multi-part message in MIME format.";
	echo "--$boundary";
	echo "Content-Type: text/plain";
	echo "Content-Disposition: inline";
	echo "";
	echo "$body";
	echo "";
	echo "";
	echo "--$boundary";
	echo "Content-Type: text/html";
	echo "Content-Disposition: attachment; filename=\"$attachment\"";
	echo "";
	echo "";
	cat $attachment;
	echo "";
	echo "--$boundary";
} | ssh $host /usr/lib/sendmail -t

rm -r $tempdir
