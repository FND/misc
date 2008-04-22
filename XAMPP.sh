# To Do
# * automatically detect running process and toggle

DIR="/tmp"

PS3="XAMPP - Select action: "
OPTIONS="start stop"
select i in $OPTIONS; do 
	if [ "$i" = "start" ]; then
		/opt/lampp/lampp start
	elif [ "$i" = "stop" ]; then
		/opt/lampp/lampp start
	fi
	exit
done
