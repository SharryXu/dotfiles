#!/bin/bash

# This program is used to install the entire repository.

function main() {
  if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    NORMAL=""
  fi

  echo '  _____   _____   _____   _____   _   _       _____   _____   '
  echo ' |  _  \ /  _  \ |_   _| |  ___| | | | |     | ____| /  ___/  '
  echo ' | | | | | | | |   | |   | |__   | | | |     | |__   | |___   '
  echo ' | | | | | | | |   | |   |  __|  | | | |     |  __|  \___  \  '
  echo ' | |_| | | |_| |   | |   | |     | | | |___  | |___   ___| |  '
  echo ' |_____/ \_____/   |_|   |_|     |_| |_____| |_____| /_____/  '
  echo ''
  echo 'If you have any question, feel free to email: sharry.r.xu@gmail.com.'

  echo -e '\nInstalling dotfiles to current folder...\n'

  hash git >/dev/null 2>&1 || {
    echo "Please install git."
    exit 1
  }

  local_folder="$(realpath .)/dotfiles"
  git clone --depth 1 https://github.com/SharryXu/dotfiles "$local_folder"

  # Install custom commands
  chmod +x "$local_folder"/bin/install-custom-commands && "$local_folder"/bin/install-custom-commands "$local_folder"

  if "$local_folder/bin/dotfile" -i "$local_folder"; then
    printf "%s" "${GREEN}"
    echo -e '\nInstallation finished successfully.'
    printf "%s" "${NORMAL}"
  else
    printf "%s" "${RED}"
    echo -e '\nSomething wrong happended inside the installation.'
    printf "%s" "${NORMAL}"
  fi
}

main
