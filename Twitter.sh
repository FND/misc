# To Do
# * prompt for confirmation when >140 chars
# * handle special chars (e.g. quotes, plus etc.)

uri="http://twitter.com/statuses/update.json"

username=$1
shift
password=$1
shift
msg=$@

if [ ${#msg} -le 0 ]; then
	echo "Error: missing username/password"
	exit
elif [ ${#msg} -gt 140 ]; then
	echo "Error: message too long (${#msg} characters)"
	PS3="Post anyway? "
    select choice in yes no; do
		if [ $choice = yes ]; then
			break
		else
			exit
		fi
    done
fi
echo "Posting: $msg (${#msg} characters)"
curl -u $username:$password -d status="$msg" $uri | python -m json.tool
