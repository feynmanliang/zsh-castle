#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Include personal settings (customize ~/.secrets as needed)
if [ -e ~/.secrets/zsh_env ]; then
  source ~/.secrets/zsh_env
fi

# Aliases
if [ -e ~/.aliases ]; then
  source ~/.aliases
fi

# Bind ctrl-r and ctrl-s to history search
if (( $+widgets[history-incremental-pattern-search-backward] )); then
  bindkey "^r" history-incremental-pattern-search-backward
  bindkey "^s" history-incremental-pattern-search-forward
else
  bindkey "^r" history-incremental-search-backward
  bindkey "^s" history-incremental-search-forward
fi

#
# PacMatic - don't let pacman clobber the system!
#
export warn_time="86400"  # (seconds)
export pacman_program="aura"

#
# homeshick and mr
#
source ~/.homesick/repos/homeshick/homeshick.sh
PATH=$PATH:~/.homesick/repos/myrepos/

# Node Modules
export NODE_PATH=/usr/lib/node_modules:$NODE_PATH

# Set Java Home
export JAVA_HOME=/usr/lib/jvm/default-runtime/

# Set Go path and add GOPATH/bin to path
export GOPATH=~/go
export PATH=$PATH:~/go/bin

# Add pipsi/stack binaries to path
export PATH=~/.local/bin:~/bin:$PATH

# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
if type "gpg-connect-agent" &> /dev/null; then
  gpg-connect-agent updatestartuptty /bye >/dev/null
fi

# hub
if type "hub" &> /dev/null; then
  eval "$(hub alias -s)"
fi

# aws competions
test -s "/usr/bin/aws_zsh_completer.sh" && source /usr/bin/aws_zsh_completer.sh

# fuzzy finder
# Use ag instead of the default find command for listing candidates.
# - The first argument to the function is the base path to start traversal
# - Note that ag only lists files not directories
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  ag -g "" "$1"
}

# Fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# NVM
nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
  nvm $@
}

# pyenv
pyenv() {
  export PATH="/home/feynman/.pyenv/bin:$PATH"
  eval "$(command pyenv init -)"
  eval "$(command pyenv virtualenv-init -)"
  pyenv $@
}

# rbenv
rbenv() {
  eval "$(command rbenv init -)"
  rbenv $@
}

# kubectl completions
if type "kubectl" &> /dev/null; then
  source <(kubectl completion zsh)
fi

# kiex - elixir version manager
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"


# Print system info
if [ "$PS1" ] && type "alsi" &> /dev/null; then
  alsi
fi

