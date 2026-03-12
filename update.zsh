#!/usr/bin/env zsh
set -euo pipefail

# Install Homebrew if no `brew` in path
# (if we somehow catch a false positive the installer will handle it just fine;
#  completely acceptable failure mode)
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo 'OK: Homebrew already installed'
fi

# Ensure we have stow so we can symlink our dotfiles
if ! command -v stow &>/dev/null; then
    brew install stow
else
    echo 'OK: stow already installed'
fi

# Clone dotfiles if not present
PROFILE_DIR="$HOME/.profile"
if [[ ! -d "$PROFILE_DIR/.git" ]]; then
    git clone https://github.com/iLynxcat/dotmac "$PROFILE_DIR"
else
    echo 'OK: ~/.profile already cloned'
fi

# Make our symlinks
stow --no-folding -R -d "$PROFILE_DIR" .
echo 'OK: stowed files from profile'

# Install casks and formulae from Brewfile
if ! brew bundle check --file="$PROFILE_DIR/.homebrew/Brewfile" &>/dev/null; then
    brew bundle install --file="$PROFILE_DIR/.homebrew/Brewfile"
else
    echo 'OK: brew bundle already satisfied'
fi

# Register docker-compose CLI plugin
if [[ ! -e "$HOME/.docker/cli-plugins/docker-compose" ]]; then
    mkdir -p "$HOME/.docker/cli-plugins"
    ln -s /opt/homebrew/bin/docker-compose "$HOME/.docker/cli-plugins/docker-compose"
else
    echo 'OK: docker-compose plugin already linked'
fi
