#!/usr/bin/env bash

# This program is used to install the entire repository.

function main() {
  if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  printf "${GREEN}"
  echo '  _____   _____   _____   _____   _   _       _____   _____   '
  echo ' |  _  \ /  _  \ |_   _| |  ___| | | | |     | ____| /  ___/  '
  echo ' | | | | | | | |   | |   | |__   | | | |     | |__   | |___   '
  echo ' | | | | | | | |   | |   |  __|  | | | |     |  __|  \___  \  '
  echo ' | |_| | | |_| |   | |   | |     | | | |___  | |___   ___| |  '
  echo ' |_____/ \_____/   |_|   |_|     |_| |_____| |_____| /_____/  '
  echo ''
  echo 'If you have any question, feel free to email: sharry.r.xu@gmail.com.'

  printf "\n${BLUE}Installing dotfiles to current folder...${NORMAL}\n"
  printf "${NORMAL}"

  hash git >/dev/null 2>&1 || {
    echo "Please install git."
    exit 1
  }

  local_folder="$(realpath .)/dotfiles"
  git clone --depth 1 https://github.com/SharryXu/dotfiles "$local_folder"

  dotfile="$local_folder/bin/dotfile"
  sudo "$dotfile" -i "$local_folder"

  if [[ $? == 0 ]]; then
    printf "${GREEN}"
    echo '\nInstallation finished successfully.'
    printf "${NORMAL}"
  else
    printf "${RED}"
    echo '\nSomething wrong happended inside the installation.'
    printf "${NORMAL}"
  fi
}

set -e

main

