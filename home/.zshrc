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
if [ -e ~/.secrets ]; then
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
# homeshick
#
source ~/.homesick/repos/homeshick/homeshick.sh


# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Add algs4.cs.princeton.edu packages
test -r ~/algs4/bin/config.sh && source ~/algs4/bin/config.sh

# Node Modules
export NODE_PATH=/usr/lib/node_modules:$NODE_PATH

# Add Gems
export PATH=$PATH:/home/fliang/.gem/ruby/2.3.0/bin

# Set Java Home
export JAVA_HOME=/usr/lib/jvm/java-default-runtime/

# Add Torch
. /home/fliang/torch/install/bin/torch-activate

# Print system info
if [ "$PS1" ]; then
  alsi
fi
