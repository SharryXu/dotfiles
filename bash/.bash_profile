# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export NVM_DIR="$HOME/.nvm"
export PATH="/usr/local/bin:$PATH:$HOME/.rvm/bin"

if [[ -f $HOME/.bin/custom-variables ]]; then
  source $HOME/.bin/custom-variables
fi

eval "$(pyenv init -)"

function load-nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm use default 1>/dev/null 2>&1
}

function load-travis() {
  [ -f /Users/sxu204/.travis/travis.sh ] && source /Users/sxu204/.travis/travis.sh
}

# Custom parameters
declare -r true=0
declare -r false=1
