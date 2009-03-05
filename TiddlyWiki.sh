# To Do
# * ensure that files are not overwritten (timestamp?)
# * switches for target location (desktop, custom location)
# * extend

DIR="/tmp"

PS3="TiddlyWiki - Select action: "
OPTIONS="empty nightly"
select i in $OPTIONS; do
	if [ "$i" = "empty" ]; then
		wget http://www.tiddlywiki.com/empty.html -O $DIR/TiddlyWiki.html
		xdg-open $DIR/TiddlyWiki.html
	elif [ "$i" = "nightly" ]; then
		wget http://nightly.tiddlywiki.org/done/nightly.html -O $DIR/twnightly.html
		xdg-open $DIR/twnightly.html
	fi
	exit
done
