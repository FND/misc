#! /bin/bash

# log.sh - based on todo.sh and done.sh (http://todotxt.com)

# NOTE: log.sh requires the .log configuration file to run.
# Place the .log file in your home directory or use the -d option for a custom location.

version() { sed -e 's/^    //' <<EndVersion
        LOG.TXT Manager
        Version 1.0
        Author:  Gina Trapani (ginatrapani@gmail.com)
        Release date:  10/20/2007
        Last updated:  10/20/2007
        License:  GPL, http://www.gnu.org/copyleft/gpl.html
        More information and mailing list at http://todotxt.com
EndVersion
    exit 1
}

usage()
{
    sed -e 's/^    //' <<EndUsage 
    Usage: log.sh [-dhqvV] task_description
    Try 'log.sh -h' for more information.    
EndUsage
    exit 1
}


help()
{ 
    sed -e 's/^    //' <<EndHelp
      Usage:  log.sh [-dhqvV] task_description

      Options:
        -d CONFIG_FILE
            Use a configuration file other than the default ~/.log
        -h
            Display this help message
        -q
            Quiet mode turns off all output
        -v 
            Verbose mode turns on confirmation messages
        -V 
            Displays version, license and credits
EndHelp

    exit 1
}

die()
{
    echo "$*"
    exit 1
}

cleanup()
{
    [ -f "$TMP_FILE" ] && rm "$TMP_FILE"
    exit 0
}


# == PROCESS OPTIONS ==
# defaults
VERBOSE=0
PLAIN=0
CFG_FILE=$HOME/.log
FORCE=0

while getopts ":dhqvV:" Option
do
  case $Option in
    d)  
	CFG_FILE=$OPTARG
	;;
	h)
	help
	;;
    q ) 
	QUIET=1
	;;
    v ) 
	VERBOSE=1
	;;
    V)
	version
	;;
  esac
done
shift $(($OPTIND - 1))

# === SANITY CHECKS (thanks Karl!) ===
[ -r "$CFG_FILE" ] || die "Fatal error:  Cannot read configuration file $CFG_FILE"

. "$CFG_FILE"

[ -z "$1" ]         && usage
[ -d "$LOG_DIR" ]  || die "Fatal Error: $LOG_DIR is not a directory"  
cd "$LOG_DIR"      || die "Fatal Error: Unable to cd to $LOG_DIR"

echo '' > "$TMP_FILE" || die "Fatal Error:  Unable to write in $LOG_DIR"  
[ -f "$LOG_FILE" ] || cp /dev/null "$LOG_FILE"
[ -f "$REPORT_FILE" ] || cp /dev/null "$REPORT_FILE"


if [ $PLAIN = 1 ]; then
	PRI_A=$NONE
	PRI_B=$NONE
	PRI_C=$NONE
	PRI_X=$NONE
	DEFAULT=$NONE
fi

# === HEAVY LIFTING ===
shopt -s extglob

# === ACTION ===
input=$*
now=`date '+%Y-%m-%d %H:%M'`
line="$now $input"
echo "$line" >> "$LOG_FILE"
#[[ $VERBOSE = 1 ]] && echo "LOGGED: $line"
echo "LOGGED: $line"

cleanup
