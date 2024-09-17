# dotfiles

## Setup
```bash
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
```

## Unlink
```bash
unlink ~/.zshrc
unlink ~/.gitconfig
```

## Brewfile
```bash
# Creating a brew file
brew bundle dump --file=~/dotfiles/Brewfile --force  
# Installing a Brewfile
brew bundle install --file=~/dotfiles/Brewfile
```

