#!/usr/bin/env bash

_log() {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  local helplist
  helplist=$(log -z)
  mapfile -t COMPREPLY < <( compgen -W "$helplist" -- "$cur" )
}

# Detect if current shell is ZSH, and if so, load this file in bash
# compatibility mode.
if [ -n "$ZSH_VERSION" ]; then
  autoload bashcompinit
  bashcompinit
fi

complete -o default -o nospace -F _log log
