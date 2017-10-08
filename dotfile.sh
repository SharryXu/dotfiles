#!/bin/bash
# This program is used to backup or restore dot files.

manual="Usage: dotfile [Options]\n\n
        [Options]:\n
        -i  Install dot files to this machine.\n
        -b  Backup dot files."

ohmyzsh='https://github.com/robbyrussell/oh-my-zsh'
spacemacs='https://github.com/SharryXu/spacemacs'

#==============================
# Make backup
function backup() {
    echo 'Backup'
}

function isProgramExisted() {
    if [ $# -eq 1 ]; then
        if command -v $1 > /dev/null 2>&1; then
            echo 1;
        else
            echo 0;
        fi
    else
        echo -1;
    fi
}

function installProgramUsingBrew() {
    if [ $# -eq 2 ]; then
        result=$(isProgramExisted $2)
        if [ $result -eq 1 ]; then
            echo $1 "has already existed"
       elif [ $result -eq 0 ]; then
            brew install $1
        else
            echo "Please indicate the program name to install" $1
        fi
    fi
}

function gitCloneOrUpdate() {
    currentFolder=$PWD
    if [ $# -eq 2 ]; then
        if [ -d $1 ]; then
            echo $1 "existed and now will pull the latest version."
            cd $1
            git pull
            cd $currentFolder
        else
            echo $1 "doesn't existed and now will download it."
            git clone $2 $1
        fi
    fi
}

#==============================
# Restore backup
function install() {
    # install brew
    result=$(isProgramExisted 'brew')
    if [ $result -eq 0 ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo 'brew' "has already existed"
    fi

    installProgramUsingBrew 'git' 'git'
    installProgramUsingBrew 'mongodb' 'mongo'
    installProgramUsingBrew 'mariadb' 'mysql'

    # config zsh
    gitCloneOrUpdate $HOME/.oh-my-zsh $ohmyzsh
    cp ./Zsh/.zshrc ~
    cp ./Zsh/sharry.zsh-theme ~/.oh-my-zsh/themes/

    # config spacemacs
    gitCloneOrUpdate $HOME/.emacs.d $spacemacs
    cp ./Emacs/.spacemacs ~

    # config mongo database
    cp ./MongoDB/.mongorc.js ~

    # Remove this file to avoid the strange characters in the Spacemacs' terminal mode.
    if [ -f "$HOME/.iterm2_shell_integration.zsh" ]; then
        rm ~/.iterm2_shell_integration.zsh
    fi
}

# main program
if [ $# -lt 1 -o $# -gt 1 ]
then
    echo -e $manual
elif [ "$1" = "-b" ]
then
    backup
elif [ "$1" = "-i" ]
then
    install
fi
