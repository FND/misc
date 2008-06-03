function relocate() {
	mv "$1" "$2"
	ln -s "$2" "$1"
}

# command-line parameter
if [ $2 ]; then
	relocate $1 $2
	exit
else
	echo "Usage: ./relocate.sh source target";
	exit
fi
