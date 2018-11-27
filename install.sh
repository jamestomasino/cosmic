#!/bin/sh

# Get Path to script folder
DIR="$( cd "$( dirname "$0" )" && pwd )"
# Fix path in case of symlinks
DIR=$(cd "$DIR" && pwd -P)

# Admin commands
if [ ! -L "/usr/local/bin/cosmic-user" ]; then
  ln -s "${DIR}/bin/cosmic-user" "/usr/local/bin/cosmic-user"
fi
if [ ! -L "/usr/local/bin/cosmic-rss" ]; then
  ln -s "${DIR}/bin/cosmic-rss" "/usr/local/bin/cosmic-rss"
fi
if [ ! -L "/usr/local/bin/cosmic-web" ]; then
  ln -s "${DIR}/bin/cosmic-web" "/usr/local/bin/cosmic-web"
fi
if [ ! -L "/usr/local/bin/cosmic-ship" ]; then
  ln -s "${DIR}/bin/cosmic-ship" "/usr/local/bin/cosmic-ship"
fi

# User runnable commands
if [ ! -L "/usr/local/bin/cosmic-roster" ]; then
  ln -s "${DIR}/bin/cosmic-roster" "/usr/local/bin/cosmic-roster"
fi
if [ ! -L "/usr/local/bin/roster" ]; then
  ln -s "${DIR}/bin/cosmic-roster" "/usr/local/bin/roster"
fi
if [ ! -L "/usr/local/bin/motd" ]; then
  ln -s "${DIR}/bin/cosmic-motd" "/usr/local/bin/motd"
fi
if [ ! -L "/usr/local/bin/log" ]; then
  ln -s "${DIR}/bin/cosmic-log" "/usr/local/bin/log"
fi

# Files
if [ ! -L "/etc/welcomemail.tmpl" ]; then
  ln -s "${DIR}/templates/welcomemail.tmpl" "/etc/welcomemail.tmpl"
fi
if [ ! -L "/etc/newship.tmpl" ]; then
  ln -s "${DIR}/templates/newship.tmpl" "/etc/newship.tmpl"
fi
if [ ! -L "/etc/motd" ]; then
  ln -s "${DIR}/files/motd" "/etc/motd"
fi

# Manpages
if [ ! -L "/usr/share/man/man1/log.1" ]; then
  ln -s "${DIR}/man/cosmic-log.1" "/usr/share/man/man1/log.1"
fi
