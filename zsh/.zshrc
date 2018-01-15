system_name=$(uname -n)

if [[ $system_name == 'mac' ]]; then
  source $HOME/.bin/custom-variables
  export EMACSPATH=/usr/local/Cellar/emacs-plus/25.3/bin
  export PYTHONPATH=$HOME/.emacs.d/.cache/anaconda-mode/0.1.9
  export PATH=$HOME/.bin:/usr/local/bin:$EMACSPATH:$PYTHONPATH:$PATH

  if [[ $(command-exist pyenv) == 0 ]]; then
    eval "$(pyenv init -)"
    pyenv shell 3.5.4
  fi

  # Config homebrew
  export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
  export HOMEBREW_NO_AUTO_UPDATE=true

	# Clang aliases
	alias clo='clang -o a.out '
	# Mongo aliases
	alias mongod2='/usr/local/Cellar/mongodb@2.6/2.6.12/bin/mongod'
	# Emacs without GUI
	alias emacs-term='emacs -nw'
	# Vim aliases
	alias vim='nvim'
	# Tmux
	alias tmux='tmux -2'
fi

if [[ $system_name == 'ubuntu' ]]; then
  export PATH=$HOME/.bin:/usr/local/bin:$PATH
	alias mongod='mongod'
	alias emacs='emacs'
	alias vim='nvim'
	alias tmux='tmux -2'
fi

export ZSH=$HOME/.oh-my-zsh

# Do not enable auto-correct.
unsetopt correct_all
# set -o vi

ZSH_THEME="sharry"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"
# HIST_STAMPS="mm/dd/yyyy"

export UPDATE_ZSH_DAYS=1
export LANG=en_US.UTF-8
export EDITOR='nvim'
export SSH_KEY_PATH="~/.ssh/rsa_id"

plugins=(
  brew
  osx
  git
  tmux
)

# Config tmux
ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_AUTOQUIT=false

source $ZSH/oh-my-zsh.sh

# Config node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
