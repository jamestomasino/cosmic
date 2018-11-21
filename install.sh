#!/bin/sh

# Get Path to script folder
DIR="$( cd "$( dirname "$0" )" && pwd )"
# Fix path in case of symlinks
DIR=$(cd "$DIR" && pwd -P)

if [ ! -L "/usr/local/bin/cosmicuser" ]; then
  ln -s "${DIR}/cosmicuser" "/usr/local/bin/cosmicuser"
fi

if [ ! -L "/etc/welcomemail.tmpl" ]; then
  ln -s "${DIR}/welcomemail.tmpl" "/etc/welcomemail.tmpl"
fi
