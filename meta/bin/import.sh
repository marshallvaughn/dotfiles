#!/bin/bash
#
# Import dotfiles to repo from source

# Declare color variables to enable color logging
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_GREEN='\033[0;32m'
COLOR_CYAN='\033[0;36m'
COLOR_MAGENTA='\033[0;36m'
COLOR_BLUE='\033[0;34m'
COLOR_GRAY='\033[0;90m'
COLOR_BLACK='\033[0;30m'
COLOR_NC='\033[0m'

for _DF in $(cat ./meta/map.json | jq -r '.dotfiles[].path'); do
  printf "- Importing ${COLOR_CYAN}${_DF}${COLOR_NC}... "
  cp ${HOME}/${_DF} ./dotfiles/${_DF}
  printf "done.\n"
done
