# To Do
# * concatenate parameters $3-$n (i.e. no need for quotes)
# * prompt for confirmation when >140 chars
# * handle special chars (e.g. quotes, plus etc.)

if [ ${#3} -le 0 ]; then
	echo "Error: missing password"	
elif [ ${#3} -gt 140 ]; then
	echo "Error: message too long (${#2} characters)"
else
	echo "Posting: $3 (${#3} characters)"
	curl -u $1:$2 -d status="$3" http://twitter.com/statuses/update.xml
fi
