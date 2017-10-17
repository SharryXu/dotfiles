#!/bin/bash
# This program is used to backup or restore dot files.

manual="Usage: dotfile [Options]\n\n
        [Options]:\n
        -i  Install dot files to this machine.\n
        -b  Backup dot files."

ohmyzsh='https://github.com/robbyrussell/oh-my-zsh'
spacemacs='https://github.com/SharryXu/spacemacs'
zshgitprompt='https://github.com/olivierverdier/zsh-git-prompt'

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
        local result=$(isProgramExisted $2)
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
    local currentFolder=$PWD
    if [ $# -eq 2 ]; then
        if [ -d $1 ]; then
            echo $1 "existed and now will pull the latest version."
            cd $1
            # TODO: Try to redirect the git output to shell itself
            git pull
            cd $currentFolder
        else
            echo $1 "doesn't existed and now will download it."
            git clone $2 $1
        fi
    fi
}

function install() {
    # install or update brew
    local result=$(isProgramExisted 'brew')
    if [ $result -eq 0 ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        brew upgrade
        brew update
    fi

    installProgramUsingBrew 'git' 'git'
    installProgramUsingBrew 'mongodb' 'mongo'
    installProgramUsingBrew 'mariadb' 'mysql'
    installProgramUsingBrew 'tree' 'tree'

    # config zsh
    gitCloneOrUpdate $HOME/.oh-my-zsh $ohmyzsh
    gitCloneOrUpdate $HOME/.zsh-git-prompt $zshgitprompt
    cp ./Zsh/.zshrc ~
    cp ./Zsh/sharry.zsh-theme ~/.oh-my-zsh/themes/

    # config tmux
    installProgramingUsingBrew 'tmux' 'tmux'
    cp ./Other/.tmux.conf ~

    # config spacemacs
    gitCloneOrUpdate $HOME/.emacs.d $spacemacs
    cp ./Emacs/.spacemacs ~

    # config clang-format tool
    installProgramUsingBrew 'clang-format' 'clang-format'
    cp ./Other/.clang-format ~

    #TODO: Configure the all-the-icons

    # configure the nodejs
    installProgramUsingBrew 'node' 'node'
    installProgramUsingBrew 'npm' 'npm'

    # configure hexo
    npm install -g hexo-cli

    # config mongo database
    cp ./MongoDB/.mongorc.js ~

    # config MySQL database
    cp ./MySQL/.my.cnf ~

    # Remove this file to avoid the strange characters in the Spacemacs' terminal mode.
    if [ -f "$HOME/.iterm2_shell_integration.zsh" ]; then
        rm ~/.iterm2_shell_integration.zsh
    fi
}

function backup() {
    # backup oh my zsh
    cp ~/.zshrc ./Zsh/
    cp ~/.oh-my-zsh/themes/sharry.zsh-theme ./Zsh/

    # backup spacemacs
    cp ~/.spacemacs ./Emacs/

    # backup mongo database
    cp ~/.mongorc.js ./MongoDB/

    # backup MySQL database
    cp ~/.my.cnf ./MySQL/

    # backup clang format
    cp ~/.clang-format ./Other/

    # backup tmux
    cp ~/.tmux.conf ./Other/
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
