# jonathan-dale dotfiles

Your dotfiles are how you personalize your system. These are mine.

They're so personal I copied much of them from https://github.com/pauldambra/dotfiles/blob/main/README.md including the approach to install them.

## Install

Run this:

```sh
git clone git@github.com:jonathan-dale/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will:

1. Generate `git/gitconfig.local.symlink` from `git/gitconfig.local.symlink.template`
   (it asks for your name, email and optional SSH signing key, reusing anything already
   in your `~/.gitconfig`). That file is gitignored because it holds your identity.
2. Symlink every `*.symlink` file into your home directory, e.g. `git/gitconfig.symlink`
   becomes `~/.gitconfig` and `zsh/zshrc.symlink` becomes `~/.zshrc`.
3. On macOS run `bin/dot`, which sets macOS defaults, updates Homebrew and runs every
   `*/install.sh` (Homebrew, oh-my-zsh and its plugins, iTerm2 integration, Chrome...).
   On other systems it just runs `script/install`.

Everything is configured and tweaked within `~/.dotfiles`. If you move the checkout,
re-run `script/bootstrap` to fix the symlinks (broken ones are replaced automatically).

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that sets sane macOS defaults, updates Homebrew and runs the
installers. Tweak it, and run `dot` from time to time to keep your environment fresh.
It lives in `bin/`, which `zsh/zshrc.symlink` puts on your `PATH` (along with `~/bin`).

## Git config

- `git/gitconfig.symlink` is the shared config, tracked in this repo.
- `git/gitconfig.local.symlink` is generated per machine (name, email, credential helper,
  optional commit signing) and included from the bottom of the shared file.
- Anything that runs `git config --global` (e.g. `gh auth setup-git`) writes into the
  tracked file, because `~/.gitconfig` is a symlink. Check `git diff` before committing.
- Commit signing uses an SSH key. To verify signatures locally:
  `git config --global gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers`, with your
  public key listed in that file.

## Brewfile

The Brewfile is **not** applied by `bootstrap` or `dot`. It's a big list (databases,
Kubernetes tooling, VS Code extensions), so run it by hand when you want it.

```bash
# Install everything in the Brewfile
brew bundle install --file=~/.dotfiles/Brewfile

# See what's missing without installing anything
brew bundle check --file=~/.dotfiles/Brewfile --verbose

# List things installed on this machine that aren't in the Brewfile
brew bundle cleanup --file=~/.dotfiles/Brewfile

# Regenerate the Brewfile from what's installed now (overwrites it, review the git diff)
brew bundle dump --file=~/.dotfiles/Brewfile --force
```

`brew bundle cleanup` only lists by default. Add `--force` to actually uninstall.

## oh-my-zsh

Installed by `zsh/install.sh`, along with the terragrunt plugin. It runs unattended and
keeps the `~/.zshrc` that bootstrap linked. `zsh-autosuggestions` and
`zsh-syntax-highlighting` come from Homebrew (see the Brewfile) and are sourced directly
from `zsh/zshrc.symlink`.
