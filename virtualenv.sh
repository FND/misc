#!/usr/bin/env bash

package=${1:?}
directory=${2:-xvirt}

echo "installing $package in $directory"

# automatically adjust relative path for tarballs in CWD
token=`echo $package | sed -e "s/^[^./].*\.tar\.gz$//"`
if [ -z $token ]; then
	package="../${package}"
fi

virtualenv --no-site-packages $directory && \
cd $directory && \
source bin/activate && \
pip -E . install -U $package
