# Dotfiles

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

# TODOs

1. Try to seperate all backup methods.
1. Check Application folder for some specific apps like iTerm2.
1. Check the input parameters and related command like basename.
1. Try to concentrate same package tool installation.
1. Add prompt message to let user manually configure the sync folder in applications like Alfred.
1. Try to use which command to replace command-exist.
1. Try to merge function name push-git-repository and check-git-repository to one function.
1. Add vscode backup like code --list-extensions
