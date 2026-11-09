export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
## ZSH_THEME="bira"
## ZSH_THEME="candy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
###  plugins=(git asdf aws szh-autosuggestions)
plugins=(
  aws
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  terragrunt
)

# auto suggest
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=9"

# terragrunt
# If you add terragtunt to the plugins list:
# git clone https://github.com/jkavan/terragrunt-oh-my-zsh-plugin ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/terragrunt


source $ZSH/oh-my-zsh.sh

# Path Entries are added repeatedly, so duplicates pile up.
typeset -U path PATH

### Important:
### Enable mouse scrolling in iterm
## Preference -> Advanced -> Mouse Tab 
## Change: "Scroll wheel sends arrow keys when in alternate screen mode" to "yes" 

# Used for fuzy finding with kubectx/kubens
# https://github.com/ahmetb/kubectx#interactive-mode
# https://github.com/junegunn/fzf
# brew install fzf

# Age key configuration
# Create the directory if it doesn't exist, and generate the key pair
## mkdir -p ~/.config/sops/age
## age-keygen -o ~/.config/sops/age/key.txt

#####################
#####################
#
# User configuration
#
#####################
#####################

alias c=clear
alias k=kubectl
alias ktx=kubectx
alias kns=kubens
alias random="openssl rand -base64 20 | sed -E 's/(.)\1+/\1/g'"


## just for fun...
# echo "----- neofetch -----"
# neofetch

## You can install many versions of kubectl: `brew install kubernetes-cli@1.35`
## Switch between kubectl versions using brew (make sure Rancher Desktop's path wrapper in disabled)
alias use-kube134="brew unlink kubernetes-cli && brew link --overwrite kubernetes-cli@1.34 && kubectl version --client"
alias use-kube135="brew unlink kubernetes-cli && brew link --overwrite kubernetes-cli@1.35 && kubectl version --client"
alias use-kube136="brew unlink kubernetes-cli && brew link --overwrite kubernetes-cli@1.36 && kubectl version --client"
alias use-kube137="brew unlink kubernetes-cli && brew link --overwrite kubernetes-cli@1.37 && kubectl version --client"


## GPG
export GPG_TTY=$TTY

## age
export SOPS_AGE_KEY_FILE=~/.config/sops/age/key.txt

##############
## completion
##############
## For each installed tool: generate ~/.completion/<tool>.zsh if missing, then source them all with (N) so an empty directory doesn't cause an error.
## To refresh after upgrading a tool: rm ~/.completion/<tool>.zsh
mkdir -p ~/.completion
for tool in kubectl helm k3d sops astro uv; do
  command -v $tool >/dev/null || continue
  [[ -f ~/.completion/$tool.zsh ]] && continue
  ## uv uses a different subcommand than the other tools
  if [[ $tool == uv ]]; then
    uv generate-shell-completion zsh > ~/.completion/uv.zsh || rm -f ~/.completion/uv.zsh
  else
    $tool completion zsh > ~/.completion/$tool.zsh || rm -f ~/.completion/$tool.zsh
  fi
done
for f in ~/.completion/*.zsh(N); do source $f; done

## terraform uses bash-style completion (no generated file)
complete -o nospace -C /opt/homebrew/bin/terraform terraform
##############
## /completion
##############


## add bin directory to my path
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin/


## ssh-agent: use macOS's built-in agent (ssh-add --apple-use-keychain ~/.ssh/id_ed25519, or AddKeysToAgent yes in ~/.ssh/config)
ssh-add --apple-use-keychain ~/.ssh/id_ed25519


## git log --show-signature -1
## Check for "Hidden" Error Messages - "error: gpg.ssh.allowedSignersFile needs to be configured..."
##
## To fix above error message, tell git to trust your own key only run one time to sign git commits
#  touch ~/.ssh/allowed_signers
#  echo "$(git config user.email) namespaces=\"git\" $(cat ~/.ssh/id_ed25519.pub)" >> ~/.ssh/allowed_signers
#  git config --global gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers
## Test again: git log --show-signature -1
# To see if the signature exists independently of the verification logic, run:
# git show --pretty=raw -1


## openssl
export PATH="/opt/homebrew/opt/openssl/bin:$PATH"

## VS code
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

## Postgres
export PATH=$PATH:/opt/homebrew/opt/postgresql@17/bin

## shasum256, either one of these work https://unix.stackexchange.com/a/426838
function sha256sum() { openssl sha256 "$@" | awk '{print $2}'; } 
## function sha256sum() { shasum -a 256 "$@" ; } && export -f sha256sum

### pip zsh completion start
#compdef -P pip[0-9.]#
__pip() {
  compadd $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$((CURRENT-1)) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null )
}
if [[ $zsh_eval_context[-1] == loadautofunc ]]; then
  # autoload from fpath, call function directly
  __pip "$@"
else
  # eval/source/. command, register function for later
  compdef __pip -P 'pip[0-9.]#'
fi
### pip zsh completion end


export PATH="/opt/homebrew/bin/:$PATH"

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

############################
# END History configuration
############################


# Syntax Highlighting: it should be sourced after oh-my-zsh.sh, but before the prompt is set.
# It is important to source it last, so that it can override any other settings.
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

