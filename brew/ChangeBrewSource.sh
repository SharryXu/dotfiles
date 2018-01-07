#!/bin/bash

function restore() {
    cd '$(brew --repo)'
    git remote set-url origin https://github.com/Homebrew/brew.git
    cd '$(brew --repo)/Library/Taps/homebrew/homebrew-core'
    git remote set-url origin https://github.com/Homebrew/homebrew-core.git
}

function replace() {
    cd '$(brew --repo)'
    git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
    cd '$(brew --repo)/Library/Taps/homebrew/homebrew-core'
    git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
}

manual="Usage: ChangeBrewSource [Options]\n\n
[Options]:\n
-c  Change the brew source to USTC.\n
-r  Change the brew source to offical."

# main program
if [ $# -lt 1 -o $# -gt 1 ]
then
    echo -e $manual
elif [ "$1" = "-c" ]
then
    replace
elif [ "$1" = "-r" ]
then
    restore
else
    echo "Wrong parameters. Please check following instructions."
    echo -e $manual
fi
