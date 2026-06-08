export HOMEBREW_REQUIRE_TAP_TRUST=1

# Homebrew path
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

export PATH="$(brew --prefix rustup)/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

# JDK switcher
source "$HOME/.zsh/jdk.zsh"
