# Homebrew config
export HOMEBREW_REQUIRE_TAP_TRUST=1
export HOMEBREW_AUTO_UPDATE_SECS=43200

eval "$(/opt/homebrew/bin/brew shellenv zsh)"    # Homebrew path
export PATH="/opt/homebrew/opt/rustup/bin:$PATH" # cargo path
export PATH="$HOME/.local/bin:$PATH"             # .local bin path

source "$HOME/.zsh/jdk.zsh"  # JDK switcher
