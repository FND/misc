#!/usr/bin/env sh

set -e

# optionally monitor a directory, automatically converting PDF files dumped within
if [ "$1" = "--monitor" ]; then
	watch_dir="${2:?}"
	watch_dir="`echo $watch_dir | sed 's#/\+$##'`" # strip trailing slashes
	target_dir="$watch_dir/converted"
	mkdir -p "$target_dir"
	inotifywait -e create -e moved_to -m --format '%w%f' "$watch_dir/" | \
			while read filepath; do \
				"$0" "$filepath" "$target_dir" | xargs xdg-run
			done
	exit 0
fi

source_file="${1:?}"
target_dir="${2:?}"

if [ ! -f "$source_file" ]; then
	echo "ERROR: $source_file is not a file"
	exit 1
fi
if [ ! -d "$target_dir" ]; then
	echo "ERROR: $target_dir is not a directory"
	exit 1
fi

target_dir="`echo $target_dir | sed 's#/\+$##'`" # strip trailing slashes
temp_file="$target_dir/`basename $source_file .pdf`.ps"
target_file="$target_dir/`basename $temp_file .ps`.pdf"

pdf2ps -sDEVICE=psgray "$source_file" "$temp_file"
ps2pdf "$temp_file" "$target_file"
rm "$temp_file"
echo "$target_file"
