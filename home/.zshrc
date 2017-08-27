set -o vi

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

# Load zplug
source ~/.zplug/init.zsh

zplug "mafredri/zsh-async", on:denysdovhan/spaceship-zsh-theme
zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh, from:github, as:theme, defer:3


zplug "plugins/git", from:oh-my-zsh, if:"[[ $(command -v git) ]]"
zplug "tj/git-extras", use:"etc/git-extras-completion.zsh", defer:3, if:"[[ $(command -v git) ]]"
zplug "paulirish/git-open", as:plugin, if:"[[ $(command -v git) ]]"

zplug "plugins/tmux", from:oh-my-zsh, if:"[[ $(command -v tmux) ]]"
zplug "tmuxinator/tmuxinator", use:"completion/tmuxinator.zsh", defer:3, if:"[[ $(command -v tmuxinator) ]]"

zplug "plugins/docker",            from:oh-my-zsh
zplug "plugins/docker-compose",    from:oh-my-zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/common-aliases",    from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "creationix/nvm", use:nvm.sh
zplug "junegunn/fzf", use:"shell/*.zsh"

zplug "djui/alias-tips"

zplug "ogham/exa", \
    as:command, \
    rename-to:"exa", \
    from:gh-r

zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq

zplug 'BurntSushi/ripgrep', \
    from:gh-r, \
    as:command, \
    rename-to:"rg"

zplug check || zplug install
zplug load

if zplug check "creationix/nvm" && [[ $(nvm current) == "system" ]]; then
    echo "Installting nvm latest node.js verion"
    nvm install node
    nvm alias default node
fi

if command -v rbenv &> /dev/null; then
    eval "$(rbenv init - zsh --no-rehash)"
fi

[[ -f "${HOME}/.aliases" ]] && source "${HOME}/.aliases"
# [[ -f "${HOME}/.completions" ]] && source "${HOME}/.completions"
# [[ -f "${HOME}/.extra" ]] && source "${HOME}/.extra"

export HISTFILE="$HOME/.zhistory"
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

export EDITOR="nvim"

export PATH="$PATH:$HOME/bin:$HOME/.fzf/bin"
