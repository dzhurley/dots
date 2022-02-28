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

# disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# ~/.oh-my-zsh/custom/plugins/
plugins=(git)

source $ZSH/oh-my-zsh.sh

eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ENV_HINTS=true

export EDITOR=nvim
export PSQL_EDITOR=nvim
export LESS="-F -X -R"

export PYTHON_CONFIGURE_OPTS="--enable-framework"
export PATH="$HOME/.pyenv/shims:/usr/local/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias gst='git stash'
alias .=source

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

# export LDFLAGS="-L/usr/local/opt/openssl@1.0/lib"
# export CPPFLAGS="-I/usr/local/opt/openssl@1.0/include"
# export PATH="/usr/local/opt/openssl@1.0/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/derekhurley/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/derekhurley/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/derekhurley/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/derekhurley/google-cloud-sdk/completion.zsh.inc'; fi

# M1 spatial affordances
export SPATIALINDEX_C_LIBRARY="/opt/homebrew/Cellar/spatialindex/1.9.3/lib/"
export DYLD_LIBRARY_PATH="/opt/homebrew/opt/geos/lib/"
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=true
