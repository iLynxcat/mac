# Homebrew path
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

export PATH="$(brew --prefix rustup)/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

# JDK switcher
source "$HOME/.zsh/jdk.zsh"
# Tangled helpers
source "$HOME/.zsh/tangled.zsh"
