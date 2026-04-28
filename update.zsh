#!/usr/bin/env zsh
set -euo pipefail

# Install Homebrew if no `brew` in path
# (if we somehow catch a false positive the installer will handle it just fine;
#  completely acceptable failure mode)
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure we have stow so we can symlink our dotfiles
if ! command -v stow &>/dev/null; then
    echo '`stow` installing via `brew`'
    brew install stow
fi

# Clone dotfiles if not present
PROFILE_DIR="$HOME/.profile"
if [[ ! -d "$PROFILE_DIR/.git" ]]; then
    git clone https://tangled.org/ilynxcat.me/mac.git "$PROFILE_DIR"
fi

# Make our symlinks
stow --no-folding -Rv -d "$PROFILE_DIR" .
echo '`stow` OK'

# Install casks and formulae from Brewfile
echo '`brew bundle` checking...' # the check command takes a while, log to explain the delay
if ! brew bundle check --file="$PROFILE_DIR/.homebrew/Brewfile" &>/dev/null; then
    brew bundle install --file="$PROFILE_DIR/.homebrew/Brewfile"
fi

if [[ ! -e "$HOME/.docker/cli-plugins/docker-compose" ]]; then
    echo 'Installing docker-compose CLI plugin'
    mkdir -p "$HOME/.docker/cli-plugins"
    ln -s /opt/homebrew/bin/docker-compose "$HOME/.docker/cli-plugins/docker-compose"
fi

echo 'Done'
