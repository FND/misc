# To Do
# * prompt for confirmation when >140 chars
# * handle special chars (e.g. quotes, plus etc.)

username=$1
shift
password=$1
shift
message=$@

if [ ${#message} -le 0 ]; then
	echo "Error: missing username/password"
elif [ ${#message} -gt 140 ]; then
	echo "Error: message too long (${#message} characters)"
else
	echo "Posting: $message (${#message} characters)"
	#curl -u $username:$password -d status="$message" http://twitter.com/statuses/update.xml
fi
