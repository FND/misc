#!/usr/bin/env sh

uri="http://definr.com/definr/show/"
#uri="http://wordnetweb.princeton.edu/perl/webwn?sub=Search+WordNet&o0=1&o1=1&s="
#uri="http://www.google.com/search?q=define%3A"

term="$@"
if [ -z "$term" ]; then
	term=$(~/Scripts/todotxt/todo.sh ls @vocab | shuf -n1 | \
		sed -e "s/@[^ ][^ ]*//g" -e "s/[0-9 ]*\(.*\) */\1/")
fi

uri="$uri$term" # XXX: assumes term is always at the end

echo "looking up $term"
echo "$uri"
w3m -no-cookie -dump "$uri" #| less
