
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# added by travis gem
[ -f /Users/sxu204/.travis/travis.sh ] && source /Users/sxu204/.travis/travis.sh

source $HOME/.bin/custom-variables

eval "$(pyenv init -)"
