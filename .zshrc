# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export TERM=xterm-256color

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dereks"

# case-sensitive completion.
CASE_SENSITIVE="true"

# disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# disable command auto-correction.
DISABLE_CORRECTION="true"

# display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# ~/.oh-my-zsh/custom/plugins/
plugins=(git)

source $ZSH/oh-my-zsh.sh

export PSQL_EDITOR=vim
export LESS="-F -X -R"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/X11R6/bin:/idealist/sbin:/var/lib/gems/1.8/bin"

export PYTHON_CONFIGURE_OPTS="--enable-framework"
PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
pyenv virtualenvwrapper

alias gf='git fetch'
alias gst='git stash'
alias .=source

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/derekhurley/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/derekhurley/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/derekhurley/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/derekhurley/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
