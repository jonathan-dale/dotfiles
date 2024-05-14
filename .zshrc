
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
###  plugins=(git asdf aws)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

alias c=clear
alias k=kubectl
alias ktx=kubectx
alias kns=kubens

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

export GPG_TTY=$(tty)

## completion
#source ~/.completion/*
source <(kubectl completion zsh)
source <(helm completion zsh)
source <(k3d completion zsh)

helm completion zsh > "${fpath[1]/_helm"

## add bin directory to my path
export PATH=$PATH:~/bin

## add ssh agent
# ssh-add
# ssh-add -lq

complete -o nospace -C /usr/local/bin/terraform terraform

export PATH="${homebrewPrefix/opt/openssl/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

## shasum256, either one of these work https://unix.stackexchange.com/a/426838
function sha256sum() { openssl sha256 "$@" | awk '{print $2}'; } 
## function sha256sum() { shasum -a 256 "$@" ; } && export -f sha256sum





