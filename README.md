# Dotfiles ![Build Status](https://travis-ci.org/SharryXu/dotfiles.svg?branch=master)

This repository contains some user settings and dotfiles.

# Usage

## Basic installation

1. You can install this via the commandline with either ```curl``` or ```wget```.

### via curl

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/SharryXu/dotfiles/master/install.sh)"
```

### via wget

```shell
sh -c "$(wget https://raw.githubusercontent.com/SharryXu/dotfiles/master/install.sh -O -)"
```

## Manually installation

1. Clone this repository to your local folder.
1. Run `./previous-folder/bin/dotfile -i .` to install all those userful settings and dotfiles.
1. Restart the terminal and enjoy!

:eyes: **Notice:** If you don't want to provide the path of dotfile folder, you can append `export DOTFILES_PATH=<path>` to `~/.bashrc` and `~/.zshrc` or edit the value if the property already exist.

## TODOs

- [ ] Try to seperate all backup methods.
- [ ] Try to concentrate same package tool installation.
- [ ] Add vscode backup like code --list-extensions
