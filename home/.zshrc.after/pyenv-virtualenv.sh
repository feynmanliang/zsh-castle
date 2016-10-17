export PYENV_VIRTUALENV_INIT=1;
_pyenv_virtualenv_hook() {
  local ret=$?
  if [ -n "$PYENV_ACTIVATE" ]; then
    if [ "$(pyenv version-name 2>/dev/null || true)" = "system" ]; then
      eval "$(pyenv sh-deactivate --no-error --verbose)"
      unset PYENV_DEACTIVATE
      return $ret
    fi
    if [ "$PYENV_ACTIVATE" != "$(pyenv prefix 2>/dev/null || true)" ]; then
      if eval "$(pyenv sh-deactivate --no-error --verbose)"; then
        unset PYENV_DEACTIVATE
        eval "$(pyenv sh-activate --no-error --verbose)" || unset PYENV_DEACTIVATE
      else
        eval "$(pyenv sh-activate --no-error --verbose)"
      fi
    fi
  else
    if [ -z "$VIRTUAL_ENV" ] && [ "$PYENV_DEACTIVATE" != "$(pyenv prefix 2>/dev/null || true)" ]; then
      eval "$(pyenv sh-activate --no-error --verbose)" || true
    fi
  fi
  return $ret
};
typeset -g -a precmd_functions
if [[ -z $precmd_functions[(r)_pyenv_virtualenv_hook] ]]; then
  precmd_functions=(_pyenv_virtualenv_hook $precmd_functions);
fi
