# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.
#
# CREDIT: https://github.com/holman/dotfiles/blob/master/macos/set-defaults.sh
# CREDIT: https://github.com/pauldambra/dotfiles/blob/main/macos/set-defaults.sh



# ------------------------------------------------------ Keyboard settings

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Set a really fast key repeat. 
# Verify the current setting: defaults read -g KeyRepeat
defaults write NSGlobalDomain KeyRepeat -int 1

# reduce the initial delay before repeating starts, setting below 10 causes accidental double-typing
# verify the current setting: defaults read -g InitialKeyRepeat
defaults write -g InitialKeyRepeat -int 13



# ------------------------------------------------------ Finder settings

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show hidden files in Finder.
defaults write com.apple.finder AppleShowAllFiles -bool true

# permanently show the path bar at the bottom of Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show the Status Bar (displays item count and remaining disk space at the bottom)
defaults write com.apple.finder ShowStatusBar -bool true

# Keep Folders at the Top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true



#  Restart any open finder windows to apply all changes
killall Finder


# ------------------------------------------------------ Dock settings

# Set the doc size smaller than normal
defaults write com.apple.dock tilesize -int 30
# get the current size: defaults read com.apple.dock tilesize

# Lock the Dock Size
defaults write com.apple.dock size-immutable -bool true

# Automatically hide and show the Dock: This is a personal preference, but I like to have the Dock hidden most of the time.
defaults write com.apple.dock autohide -bool true


# Instant Auto-Hide: Removes the annoying half-second lag before the Dock slides out
defaults write com.apple.dock autohide-delay -float 0

# Makes the Dock slide into view significantly faster (0.15 seconds instead of 0.5)
defaults write com.apple.dock autohide-time-modifier -float 0.15

# Hide "Recent" Applications: Stops unpinned, recently closed apps from cluttering the right side of the Dock
defaults write com.apple.dock show-recents -bool false

# Show Only Active Apps in the Dock: only show whats currently running
defaults write com.apple.dock static-only -bool true



# Restart the Dock to apply all changes instantly
killall Dock