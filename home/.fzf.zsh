# Setup fzf
# ---------
if [[ ! "$PATH" == */home/feynman/.fzf/bin* ]]; then
  export PATH="$PATH:/home/feynman/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/feynman/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/feynman/.fzf/shell/key-bindings.zsh"

