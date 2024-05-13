# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

alias k=kubectl
alias c=clear

echo "----- neofetch -----"
neofetch

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/jonathandale/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

############################
# History file configuration
############################
# https://martinheinz.dev/blog/110

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"

### OTHER OPTIONS ####
# https://zsh.sourceforge.io/Doc/Release/Options.html (16.2.4 History)

## setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
## setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
## setopt SHARE_HISTORY         # Share history between all sessions.
## setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
## setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
## setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
## setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
## setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
## setopt APPEND_HISTORY        # append to history file (Default)
## setopt HIST_NO_STORE         # Don't store history commands
## setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.

