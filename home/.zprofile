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

if [[ -n "$TMUX" ]]; then
    export TERM=screen-256color
else
    export TERM=xterm-256color
fi

# Refresh gpg-agent tty in case user switches into an X session
if (( $+commands[gpg-connect-agent] )); then
  gpg-connect-agent updatestartuptty /bye >/dev/null
fi
