# uncomment to benchmark, results in `zprof` command
# zmodload zsh/zprof

export ZPLUG_HOME="$HOME/.zplug"
export PATH="$PATH:$ZPLUG_HOME/bin"
if [[ ! -d "$ZPLUG_HOME" ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source "$ZPLUG_HOME/init.zsh" && zplug update
else
    source "$ZPLUG_HOME/init.zsh"
fi
zplug "zplug/zplug", hook-build:'zplug --self-manage'

# NOTE: this is a hack to prevent _-zplug::log::write::info taking up time
# see __zplug::io::file::load()
[[ ! -f $ZPLUG_LOADFILE ]] && touch $ZPLUG_LOADFILE

zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh, as:theme
SPACESHIP_TIME_SHOW=true
SPACESHIP_EXIT_CODE_SHOW=true

zplug "modules/history", from:prezto
export HISTORY_IGNORE="(ls|cd|pwd|exit|cd ..|date|* --help)"

# Set vi keymaps,
zplug "modules/editor", from:prezto
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:editor' dot-expansion 'yes'

zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"

export PATH="$PATH:$HOME/.fzf/bin"
zplug "junegunn/fzf", use:"shell/*.zsh", defer:2
if (( $+commands[fzf] )); then
    if (( $+commands[rg] )); then
        export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!{.git,node_modules}/*" 2> /dev/null'
        export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!{.git,node_modules}/*" 2> /dev/null'
    fi
    if (( $+commands[bfs] )); then
        export FZF_ALT_C_COMMAND="bfs -type d -nohidden"
    fi
fi

zplug "rupa/z", use:z.sh

zplug "supercrabtree/k"

zplug "djui/alias-tips"
zplug "simnalamburt/cgitc"

zplug "stedolan/jq", \
  from:gh-r, \
  as:command, \
  rename-to:jq
zplug "fiatjaf/jiq", \
  on:"stedolan/jq", \
  as:command, \
  hook-build:"cd cmd/jiq && go get -d && go build && cd ../..", \
  use:"cmd/jiq/jiq", \
  rename-to:jiq

zplug "asdf-vm/asdf", \
  at:v0.4.0,\
  use:asdf.sh

zplug load

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if (( $+commands[pyenv] )); then eval "$(pyenv init -)"; fi

if (( $+commands[rbenv] )); then
    eval "$(rbenv init -)"
fi

[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
