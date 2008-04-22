# To Do
# * automatically detect running process and toggle

DIR="/tmp"

function XAMPP() {
	if [ $1 = true ]; then
		echo "starting XAMPP"
		sudo /opt/lampp/lampp start
	elif [ $1 = false ]; then
		echo "stopping XAMPP"
		sudo /opt/lampp/lampp stop
	fi
}

# command-line parameter
if [ $1 = "e" ]; then
	XAMPP true
	exit
elif [ $1 = "d" ]; then
	XAMPP false
	exit
fi

# selection menu
PS3="XAMPP - Select action: "
OPTIONS="start stop"
select i in $OPTIONS; do 
	if [ "$i" = "start" ]; then
		XAMPP true
	elif [ "$i" = "stop" ]; then
		XAMPP false
	fi
	exit
done
