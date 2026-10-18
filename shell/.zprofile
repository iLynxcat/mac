export PATH="$HOME/.local/bin:$PATH"

# Homebrew config
export HOMEBREW_REQUIRE_TAP_TRUST=1
export HOMEBREW_AUTO_UPDATE_SECS=43200

# Homebrew, if installed
if [[ -x /opt/homebrew/bin/brew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv zsh)"
elif [[ -x /usr/local/bin/brew ]]; then
	eval "$(/usr/local/bin/brew shellenv zsh)"
fi

# MacPorts, if installed
if [[ -x /opt/local/bin/port ]]; then
	export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
fi

# JDK switcher
if [[ -r "$HOME/.zsh/jdk.zsh" ]]; then
	source "$HOME/.zsh/jdk.zsh"
fi

# Rust & Cargo
if [[ -r "$HOME/.cargo/env" ]]; then
	source "$HOME/.cargo/env"
fi
