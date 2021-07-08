#!/bin/bash
#
# Import dotfiles to repo from source

# Declare color variables to enable color logging
export COLOR_RED='\033[0;31m'
export COLOR_YELLOW='\033[0;33m'
export COLOR_GREEN='\033[0;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_MAGENTA='\033[0;36m'
export COLOR_BLUE='\033[0;34m'
export COLOR_GRAY='\033[0;90m'
export COLOR_BLACK='\033[0;30m'
export COLOR_NC='\033[0m'

logg() {
  DATE_NOW=$(date +%H:%M:%S)
  printf "${COLOR_CYAN}[${COLOR_BLACK}$(date +%H:%M:%S)${COLOR_CYAN}]${COLOR_NC}: ${@}"
}

df:pull() {
  for _DF in $(cat ./meta/map.json | jq -r '.dotfiles[].path'); do
    logg "Importing ${COLOR_CYAN}${_DF}${COLOR_NC}... "
    cp ${HOME}/${_DF} ./dotfiles/${_DF}
    printf "done.\n"
  done
}

# Goes in the other direction
df:install() {
  for _DF in $(cat ./meta/map.json | jq -r '.dotfiles[].path'); do
    logg "Installing ${COLOR_CYAN}${_DF}${COLOR_NC}... "
    cp ./dotfiles/${_DF} ${HOME}/${_DF}
    printf "done.\n"
  done
}

# Prompts for confirmation (Y/y)
confirm() {
  read -p "$1" -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    logg "Declined. Exiting.\n"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit
  fi  
}

if [[ $# -ne 0 ]] ; then
  if [[ $1 == "pull" ]] ; then
    df:pull && exit 0
    # PROMPT_MESSAGE="This will pull local dotfiles into this project. Continue? (y/n): "
    # confirm "$PROMPT_MESSAGE" && df:pull
  elif [[ $1 == "install" ]] ; then
    df:install && exit 0
    # PROMPT_MESSAGE="This will install project dotfiles to your machine at their respective paths. Continue? (y/n): "
    # confirm "$PROMPT_MESSAGE" && df:install
  else
    logg "Couldn't find a command for '${@}'. Exiting.\n"
    exit 1
  fi
fi
