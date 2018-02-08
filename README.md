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

- [ ] Try to seperate all backup methods.
- [ ] Check Application folder for some specific apps like iTerm2.
- [ ] Check the input parameters and related command like basename.
- [ ] Try to concentrate same package tool installation.
- [ ] Add prompt message to let user manually configure the sync folder in applications like Alfred.
- [ ] Try to use which command to replace command-exist.
- [ ] Try to merge function name push-git-repository and check-git-repository to one function.
- [ ] Add vscode backup like code --list-extensions
- [ ] Try to use homebrew cask to substitute download applications.
- [ ] Unify shell script's return way, like '''echo 0''' or '''exit 0'''.
