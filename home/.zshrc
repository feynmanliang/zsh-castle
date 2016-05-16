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
. $HOME/bachbot/torch/install/bin/torch-activate

# Add mlsalt local libraries
export PATH=$PATH:~/usr/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-7.0/lib64:~/usr/lib
export C_INCLUDE_PATH=$C_INCLUDE_PATH:~/usr/include
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:~/usr/include

# Add humdrum
export PATH=/remote/mlsalt-2015/fl350/bachbot/humdrum-tools/humdrum/bin:$PATH
export PATH=/remote/mlsalt-2015/fl350/bachbot/humdrum-tools/humextra/bin:$PATH

# Print system info
#if [ "$PS1" ]; then
#  alsi
#/fliangfi
