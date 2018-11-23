#!/bin/sh

# Get Path to script folder
DIR="$( cd "$( dirname "$0" )" && pwd )"
# Fix path in case of symlinks
DIR=$(cd "$DIR" && pwd -P)

if [ ! -L "/usr/local/bin/cosmic-user" ]; then
  ln -s "${DIR}/cosmic-user" "/usr/local/bin/cosmic-user"
fi

if [ ! -L "/usr/local/bin/cosmic-rss" ]; then
  ln -s "${DIR}/cosmic-rss" "/usr/local/bin/cosmic-rss"
fi

if [ ! -L "/usr/local/bin/cosmic-ship" ]; then
  ln -s "${DIR}/cosmic-ship" "/usr/local/bin/cosmic-ship"
fi

if [ ! -L "/usr/local/bin/log" ]; then
  ln -s "${DIR}/log" "/usr/local/bin/log"
fi

if [ ! -L "/etc/welcomemail.tmpl" ]; then
  ln -s "${DIR}/welcomemail.tmpl" "/etc/welcomemail.tmpl"
fi

if [ ! -L "/etc/newship.tmpl" ]; then
  ln -s "${DIR}/newship.tmpl" "/etc/newship.tmpl"
fi

if [ ! -L "/etc/motd" ]; then
  ln -s "${DIR}/motd" "/etc/motd"
fi
