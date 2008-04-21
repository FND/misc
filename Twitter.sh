# To Do
# * concatenate parameters $2-$n (i.e. no need for quotes)
# * prompt for confirmation when >140 chars

if [ ${#2} -le 0 ]; then
	echo "Error: missing password"	
elif [ ${#2} -gt 140 ]; then
	echo "Error: message too long (${#2} characters)"
else
	echo "Posting: $2 (${#2} characters)"
	curl -u FND:$1 -d status="$2" http://twitter.com/statuses/update.xml
fi
