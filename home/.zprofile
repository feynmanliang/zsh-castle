# `.zlogin' is sourced in login shells. It should contain commands that should
# be executed only in login shells. `.zlogout' is sourced when login shells
# exit.
#
# `.zprofile' is similar to `.zlogin', except that it is sourced before
# `.zshrc'. `.zprofile' is meant as an alternative to `.zlogin' for ksh fans;
# the two are not intended to be used together.
#
# `.zlogin' is not the place for alias definitions, options, environment
# variable settings, etc.; as a general rule, it should not change the shell
# environment at all. Rather, it should be used to set the terminal type and
# run a series of external commands (fortune, msgs, etc).
#
# The ultimate order:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes]
#
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

export BROWSER='chromium'

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

export PATH=$HOME/bin:$PATH

export PATH=$HOME/.pyenv/bin:$PATH

if (( $+commands[yarn] )); then
    export PATH=$PATH:$HOME/config/yarn/global/node_modules/.bin
fi

if (( $+commands[cargo] )); then
    export PATH=$PATH:$HOME/.cargo/bin
fi

if (( $+commands[go])); then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
fi

export LESS=' -g -i -M -R -S -w -z-4'
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

if [[ -n "$TMUX" ]]; then
    export TERM=screen-256color
else
    export TERM=xterm-256color
fi

# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
if (( $+commands[gpg-connect-agent] )); then
  gpg-connect-agent updatestartuptty /bye >/dev/null
fi

# use gpg-agent to replace ssh-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
