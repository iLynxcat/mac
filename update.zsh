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
  brew install stow
fi

# Clone dotfiles if not present
PROFILE_DIR="$HOME/.profile"
if [[ ! -d "$PROFILE_DIR/.git" ]]; then
  git clone https://github.com/iLynxcat/dotmac "$PROFILE_DIR"
fi

# Make our symlinks
stow --no-folding -d "$HOME/.profile" .
