#!/usr/bin/env bash
#
# Homebrew
#
# Installs Homebrew itself plus a few essentials.
#
# The full set of tools lives in the Brewfile and is applied out of band, see
# "Brewfile" in the README.

# Find an existing Homebrew and put it on PATH for the rest of this script.
# (Apple Silicon, Intel macOS, Linux)
load_brew () {
  local b
  for b in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    if [ -x "$b" ]; then
      eval "$("$b" shellenv)"
      return 0
    fi
  done
  return 1
}

if ! command -v brew >/dev/null 2>&1 && ! load_brew
then
  echo "  Installing Homebrew for you."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || exit 1
  load_brew || { echo "  Homebrew installed but brew was not found"; exit 1; }
fi

# install <name> [cask] [app-bundle]
#   cask:       "yes" to install as a cask
#   app-bundle: for casks, the .app name in /Applications. If it's already there
#               (e.g. installed by hand) brew would refuse, so skip it.
install() {
  local app=$1 cask=${2:-} bundle=${3:-}

  echo
  echo "-> Installing ${app}..."

  if [ -z "$cask" ]; then
    brew list "${app}" >/dev/null 2>&1 || brew install "${app}"
  elif brew list --cask "${app}" >/dev/null 2>&1; then
    :
  elif [ -n "$bundle" ] && [ -d "/Applications/${bundle}" ]; then
    echo "   ${bundle} already exists in /Applications, skipping."
    return 0
  else
    brew install --cask "${app}"
  fi

  echo
  echo "-> ${app} installed"
}

install iterm2 yes iTerm.app
install zsh

brew cleanup

exit 0
