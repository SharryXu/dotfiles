#!/bin/bash

# This program is used to install the entire repository.

function main() {
  local_folder="$(pwd)"/dotfiles

  echo '  _____   _____   _____   _____   _   _       _____   _____   '
  echo ' |  _  \ /  _  \ |_   _| |  ___| | | | |     | ____| /  ___/  '
  echo ' | | | | | | | |   | |   | |__   | | | |     | |__   | |___   '
  echo ' | | | | | | | |   | |   |  __|  | | | |     |  __|  \___  \  '
  echo ' | |_| | | |_| |   | |   | |     | | | |___  | |___   ___| |  '
  echo ' |_____/ \_____/   |_|   |_|     |_| |_____| |_____| /_____/  '
  echo ''
  echo 'If you have any question, feel free to email: sharry.r.xu@gmail.com.'

  if ! which git 1>/dev/null 2>&1; then
    echo "Please install git."
    exit 1
  else
    git clone --depth 1 https://github.com/SharryXu/dotfiles "$local_folder"

#    if $TRAVIS; then
#      /bin/bash -x "$local_folder"/bin/dotfile -i "$local_folder"
#    else
      "$local_folder"/bin/dotfile -i "$local_folder"
#    fi
  fi
}

main
