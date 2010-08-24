#!/usr/bin/env sh

term="$@"
if [ -z "$term" ]; then
	term=$(~/Scripts/todotxt/todo.sh ls @vocab | shuf -n1 | \
		sed -e "s/@[^ ][^ ]*//g" -e "s/[0-9 ]*\(.*\) */\1/")
fi

echo "looking up $term"
w3m -no-cookie -dump "http://definr.com/definr/show/$term"
