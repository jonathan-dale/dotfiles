#!/bin/sh
#
# zsh setup: oh-my-zsh, its custom plugins, and iTerm2 shell integration.
#
# The ~/.zshrc itself is linked by script/bootstrap (zsh/zshrc.symlink).

# oh-my-zsh
# KEEP_ZSHRC stops the installer from replacing the ~/.zshrc we symlinked;
# --unattended skips changing the login shell and launching zsh.
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "oh-my-zsh already installed."
else
    echo "Installing oh-my-zsh..."
    KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || exit 1
fi

# Custom plugin listed in the plugins=() array in zsh/zshrc.symlink
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ -d "$ZSH_CUSTOM_DIR/plugins/terragrunt" ]; then
    echo "terragrunt plugin already installed."
else
    echo "Installing terragrunt oh-my-zsh plugin..."
    git clone https://github.com/jkavan/terragrunt-oh-my-zsh-plugin "$ZSH_CUSTOM_DIR/plugins/terragrunt" || exit 1
fi

# iTerm2 shell integration
if [ -f "$HOME/.iterm2_shell_integration.zsh" ]; then
    echo "iTerm2 shell integration already installed."
else
    echo "Installing iTerm2 shell integration..."
    curl -fsSL https://iterm2.com/shell_integration/zsh -o "$HOME/.iterm2_shell_integration.zsh"
fi
