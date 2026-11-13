#!/bin/sh
#
# Point iTerm2 at the preferences stored in this repo (iterm2/).
# iTerm2 loads com.googlecode.iterm2.plist from that folder on next launch.
#
# Keeping it current: 
# iTerm2 can write setting changes back into the repo file. 
# Go to Settings → General → Settings and choose "Save changes: Automatically" (or "Manually"). 
# After that, a git diff shows your changes and you can commit them.

if test ! "$(uname)" = "Darwin"
  then
  exit 0
fi

ITERM2_DIR="$(cd "$(dirname "$0")" && pwd -P)"

echo "› configuring iTerm2 to load preferences from $ITERM2_DIR"
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$ITERM2_DIR"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

if pgrep -x iTerm2 >/dev/null 2>&1; then
  echo "  iTerm2 is running; quit and reopen it to pick up the new settings."
fi
