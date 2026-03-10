# dotfiles

## Setup
```bash
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
```

## install oh-my-zsh
https://github.com/ohmyzsh/ohmyzsh/tree/master?tab=readme-ov-file
```bash
https://github.com/ohmyzsh/ohmyzsh/tree/master?tab=readme-ov-file
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
rest
