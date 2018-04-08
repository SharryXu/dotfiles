#!/bin/bash

# This program is used to install the entire repository.

function main() {
  echo '  _____   _____   _____   _____   _   _       _____   _____   '
  echo ' |  _  \ /  _  \ |_   _| |  ___| | | | |     | ____| /  ___/  '
  echo ' | | | | | | | |   | |   | |__   | | | |     | |__   | |___   '
  echo ' | | | | | | | |   | |   |  __|  | | | |     |  __|  \___  \  '
  echo ' | |_| | | |_| |   | |   | |     | | | |___  | |___   ___| |  '
  echo ' |_____/ \_____/   |_|   |_|     |_| |_____| |_____| /_____/  '
  echo ''
  echo 'If you have any question, feel free to email: sharry.r.xu@gmail.com.'
  echo ''
  echo "Installing dotfiles to $(pwd)..."

  hash git >/dev/null 2>&1 || {
    echo "Please install git."
    exit 1
  }

  local_folder="$(realpath .)/dotfiles"
  git clone --depth 1 https://github.com/SharryXu/dotfiles "$local_folder"

  export INITIALIZE_DOTFILE=true

  # Install custom commands
  chmod +x "$local_folder"/bin/install-custom-commands && "$local_folder"/bin/install-custom-commands "$local_folder"

  if $TRAVIS; then
		if /bin/bash -x "$local_folder/bin/dotfile" -n -i "$local_folder"; then
			exit 0
		else
			exit 1
		fi
  else
		if "$local_folder/bin/dotfile" -i "$local_folder"; then
		  exit 0
    else
		  exit 1
    fi
  fi
}

main
