# Sourced on all invocations of the shell, unless the -f option is set.
# It should contain exported variables that should be available to
# other programs. For example, $PATH, $EDITOR, and $PAGER.
# It should not contain commands that produce output or assume the shell is
# attached to a tty.
#
# The ultimate order:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes]

# Treat top-level shells as "login" shells.
# See https://github.com/sorin-ionescu/prezto/pull/500#issuecomment-29144246
if [[ $SHLVL == 1 && ! -o LOGIN ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi
