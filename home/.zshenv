# Sourced on all invocations of the shell, unless the -f option is set.
# It should contain exported variables that should be available to
# other programs. For example, $PATH, $EDITOR, and $PAGER.
# It should not contain commands that produce output or assume the shell is
# attached to a tty.
#
# The ultimate order:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes]

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

# Set GPG TTY
export GPG_TTY=$(tty)

