#!/bin/bash
# This program is used to backup or restore dot files.

ohmyzsh=('Oh-My-Zsh' 'https://github.com/robbyrussell/oh-my-zsh')
spacemacs=('Spacemacs' 'https://github.com/SharryXu/spacemacs')
zshgitprompt=('Zsh-prompt' 'https://github.com/olivierverdier/zsh-git-prompt')
nerdfonts=('Nerd-fonts' 'https://github.com/ryanoasis/nerd-fonts')
nvm=('Node Manager' 'https://github.com/creationix/nvm')

useremail="852083454@qq.com"
username="SharryXu"

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

function isServerAlive () {
    if [ $# -eq 1 ]; then
        local tryCounts = 3
        local result=`ping $1 -c $tryCounts | grep "^\w\{2\} bytes from .*ttl=[0-9]" -c`
        if [ $result -eq $tryCounts ]; then
            echo 1;
        else
            echo 0;
        fi
    else
        echo -1;
    fi
}

function npmInstallIfNotExist() {
    if [ $# -eq 2 ]; then
        local result=$(isProgramExisted $2)
        if [ $result -eq 1 ]; then
            echo $1 "has already existed"
        elif [ $result -eq 0 ]; then
            npm install -g $1@latest
            echo $1 "has successfully been installed."
        else
            echo "Please indicate the program name to install" $1
        fi
    else
        echo "Please check parameters."
    fi
}

function brewInstallIfNotExist() {
    if [ $# -eq 2 ]; then
        local result=$(isProgramExisted $2)
        if [ $result -eq 1 ]; then
            echo $1 "has already existed"
        elif [ $result -eq 0 ]; then
            brew install $1
            echo $1 "has successfully been installed."
        else
            echo "Please indicate the program name to install" $1
        fi
    else
        echo "Please check parameters."
    fi
}

function gitCloneOrUpdate() {
    local currentFolder=$PWD
    # Please notice if the parameter is an array, then the number should count the array's length.
    if [ $# -ge 3 ]; then
        local repoInfo=$2
        if [ -d $1 ]; then
            echo ${repoInfo[0]} "existed and now will pull the latest version."
            cd $1
            # TODO: Try to redirect the git output to shell itself
            # And if the repo is very large, just need to ge the first level.
            git pull
            cd $currentFolder
        else
            echo "Downloading " $1 "..."
            git clone --depth=1 ${repoInfo[1]} $1
            echo ${repoInfo[0]} "has been successfully downloaded."
        fi
    else
        echo "Please check parameters."
    fi
}

function rubyPackageInstall() {
    if [ $# -eq 1 ]; then
        local isExisted=0
        read -ra installedPackages <<< `gem list --local --no-version | sed -n '4,$p'`
        for ((i = 0; i < ${#installedPackages[@]}; i += 2)); do
            if [[ "${installedPackages[$i]}" == *"$1" ]]; then
                isExisted=1
                break
            fi
        done

        if [ $isExisted -eq 1 ]; then
            echo $1 "has already existed."
        else
            gem install $1
        fi
    else
        echo "Please check parameters."
    fi
}

function pythonPackageInstall() {
    if [ $# -eq 2 ]; then
        local isExisted=0
        read -ra installedPackages <<< `pip$2 list --format=columns | sed -n '3,$p'`
        for ((i = 0; i < ${#installedPackages[@]}; i += 2)); do
            if [[ "${installedPackages[$i]}" == *"$1" ]]; then
                isExisted=1
                break
            fi
        done

        if [ $isExisted -eq 1 ]; then
            echo $1 "has already existed."
        else
            pip$2 install --user $1
        fi
    else
        echo "Please check parameters."
    fi
}

function setupMacOS() {
    echo "Show full file path on the tile in Finder..."
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true;
    echo "Restart Finder..."
    killall Finder
}

function setupGit() {
    echo "Setup Git tool..."
    git config --global --add user.name $username
    git config --global --add user.email $useremail
    git config --global --add rerere.enabled 1

}

function install() {
    echo "Check brew..."
    local result=$(isProgramExisted 'brew')
    if [ $result -eq 0 ]; then
        result=$(isProgramExisted 'ruby')
        if [ $result -eq 0 ]; then
            echo "Please install Ruby first."
        else
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            echo "brew has been successfully installed."
        fi
    else
        brew upgrade
        brew update
        echo "brew has been successfully updated."
    fi

    echo "Check git..."
    brewInstallIfNotExist 'git' 'git'

    echo "Check python3..."
    brewInstallIfNotExist 'python3' 'python3'

    echo "Check mongo database..."
    brewInstallIfNotExist 'mongodb' 'mongo'
    cp ./MongoDB/.mongorc.js ~

    echo "Check mysql database..."
    brewInstallIfNotExist 'mariadb' 'mysql'
    cp ./MySQL/.my.cnf ~

    echo "Check tree tool..."
    brewInstallIfNotExist 'tree' 'tree'

    echo "Check Oh-My-Zsh..."
    gitCloneOrUpdate $HOME/.oh-my-zsh ${ohmyzsh[*]}
    gitCloneOrUpdate $HOME/.zsh-git-prompt ${zshgitprompt[*]}
    cp ./Zsh/.zshrc ~
    cp ./Zsh/sharry.zsh-theme ~/.oh-my-zsh/themes/

    echo "Check tmux tool..."
    brewInstallIfNotExist 'tmux' 'tmux'
    cp ./Other/.tmux.conf ~

    # config emacs (substitute the default emacs installed by Mac OS)
    echo "Check emacs..."
    brew install emacs --with-cocoa
    gitCloneOrUpdate $HOME/.emacs.d ${spacemacs[*]}
    cp ./Emacs/.spacemacs ~
    # Remove this file to avoid the strange characters in the Spacemacs' terminal mode.
    if [ -f "$HOME/.iterm2_shell_integration.zsh" ]; then
        rm ~/.iterm2_shell_integration.zsh
    fi

    # config fonts
    gitCloneOrUpdate $HOME/.fonts ${nerdfonts[*]}
    $HOME/.fonts/install.sh 1> /dev/null

    echo "Check Vim..."
    brew install vim --with-override-system-vim
    brewInstallIfNotExist 'neovim' 'nvim'
    rubyPackageInstall 'neovim'
    pythonPackageInstall 'neovim' '2'
    pythonPackageInstall 'neovim' '3'
    cp ./Vim/* ~/.SpaceVim.d/

    echo "Check ClangFormat tool..."
    brewInstallIfNotExist 'clang-format' 'clang-format'
    cp ./Other/.clang-format ~

    echo "Check htop tool..."
    brewInstallIfNotExist 'htop' 'htop'

    echo "Check NodeJS..."
    brewInstallIfNotExist 'node' 'node'
    brewInstallIfNotExist 'npm' 'npm'

    echo "Check Node Manager..."
    gitCloneOrUpdate $HOME/.nvm $nvm
    source $HOME/.nvm/nvm.sh

    echo "Check hexo..."
    npmInstallIfNotExist 'hexo-cli' 'hexo'
    # TODO: Need to use 'npm list -g' to determine if packages are existed or not. 
    npm install -g hexo-deployer-git

    echo "Done."
}

function backup() {
    echo "Backup Oh-My-Zsh..."
    cp ~/.zshrc ./Zsh/
    cp ~/.oh-my-zsh/themes/sharry.zsh-theme ./Zsh/

    echo "Backup emacs..."
    cp ~/.spacemacs ./Emacs/

    echo "Backup mongo database..."
    cp ~/.mongorc.js ./MongoDB/
    #TODO: backup mongo.conf file.

    echo "Backup mysql database..."
    cp ~/.my.cnf ./MySQL/

    echo "Backup clang format information..."
    cp ~/.clang-format ./Other/

    echo "Backup tmux tool's configuration..."
    cp ~/.tmux.conf ./Other/

    echo "Done."
}

manual="Usage: dotfile [Options]\n\n
[Options]:\n
-i  Install dot files to this machine.\n
-b  Backup dot files."

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
else
    echo "Wrong parameters. Please check following instructions."
    echo -e $manual
fi
