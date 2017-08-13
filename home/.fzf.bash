# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/feynman/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/feynman/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/feynman/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/feynman/.fzf/shell/key-bindings.bash"

