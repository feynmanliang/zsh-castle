# Setup fzf
# ---------
if [[ ! "$PATH" == */home/fliang/.fzf/bin* ]]; then
  export PATH="$PATH:/home/fliang/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/fliang/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/fliang/.fzf/shell/key-bindings.bash"

