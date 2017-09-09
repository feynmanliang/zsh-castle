set -o vi

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export BROWSER='chromium'
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

export LESS=' -g -i -M -R -S -w -z-4'
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

export ZPLUG_HOME="${HOME}/.zplug"

if [[ ! -d "${ZPLUG_HOME}" ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source "${ZPLUG_HOME}/init.zsh" && zplug update
else
    source "${ZPLUG_HOME}/init.zsh"
fi

zplug "zplug/zplug", hook-build:'zplug --self-manage'

zplug "mafredri/zsh-async", on:denysdovhan/spaceship-zsh-theme
zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh, from:github, as:theme, defer:3

zplug "lib/history", from:oh-my-zsh
export HISTORY_IGNORE="(ls|cd|pwd|exit|cd ..|date|* --help)"

zplug "junegunn/fzf", use:"shell/*.zsh", defer:3, if:"[[ (( $+commands[fzf] )) ]]"
if (( $+commands[fzf] )); then
    if (( $+commands[rg] )); then
        export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!{.git,node_modules}/*" 2> /dev/null'
        export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!{.git,node_modules}/*" 2> /dev/null'
    fi
    if (( $+commands[bfs] )); then
        export FZF_ALT_C_COMMAND="bfs -type d -nohidden"
    fi
fi

zplug "modules/editor", from:prezto
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:editor' dot-expansion 'yes'

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "modules/utility", from:prezto
zstyle ':prezto:*:*' color 'yes'
zplug "supercrabtree/k"

zplug "djui/alias-tips"

zplug "plugins/common-aliases", from:oh-my-zsh
[[ -f "${HOME}/.aliases" ]] && source "${HOME}/.aliases"

zplug "modules/git", from:prezto, if:"[[ (( $+commands[git] )) ]]"
zplug "tj/git-extras", use:"bin/*", as:command, hook-build:"make install PREFIX=$HOME/.git-extras", if:"[[ (( $+commands[git] )) ]]"
zplug "tj/git-extras", use:"etc/git-extras-completion.zsh", defer:3, if:"[[ (( $+commands[git] )) ]]"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if (( $+commands[pyenv] )); then eval "$(pyenv init -)"; fi
if (( $+commands[pyenv-virtualenv-init] )); then eval "$(pyenv virtualenv-init -)"; fi

# zplug "creationix/nvm", use:nvm.sh, if:"[[ (( $+commands[nvm] )) ]]"

if (( $+commands[rbenv] )); then
    eval "$(rbenv init -)"
fi
zplug "tmuxinator/tmuxinator", use:"completion/tmuxinator.zsh", defer:3, if:"[[ (( $+commands[tmuxinator] )) ]]"

# [[ -f "${HOME}/.completions" ]] && source "${HOME}/.completions"
# [[ -f "${HOME}/.extra" ]] && source "${HOME}/.extra"


zplug check || zplug install
zplug load
