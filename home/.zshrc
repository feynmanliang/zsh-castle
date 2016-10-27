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
export JAVA_HOME=/usr/lib/jvm/java-default-runtime/

# Set Go path
export GOPATH=~/go

# Add pipsi binaries to path
export PATH=~/.local/bin:~/bin:$PATH

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

echo "UPDATESTARTUPTTY" | gpg-connect-agent > /dev/null 2>&1

# hub
eval "$(hub alias -s)"

# aws competions
source /usr/bin/aws_zsh_completer.sh

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
  [ -s "/usr/share/nvm/init-nvm.sh" ] && source "/usr/share/nvm/init-nvm.sh"
  nvm $@
}

# pyenv
pyenv() {
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
# source <(kubectl completion zsh)


# Print system info
if [ "$PS1" ]; then
  alsi
fi

