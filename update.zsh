#!/usr/bin/env zsh
set -euo pipefail

all_packages=(ghostty git homebrew java shell zed)

# Install Homebrew if no `brew` in path
if ! command -v brew &>/dev/null; then
	brew_missing=1
fi

# Ensure we have stow so we can symlink our dotfiles
if ! command -v stow &>/dev/null; then
	printf '`stow` not found. '

	if ! brew_missing; then
		printf 'Install Stow via Homebrew? [Y/n] '
	    read -r answer
	    if [[ -z "$answer" || "$answer" == [Yy] ]]; then
	    	brew install stow
	    fi
	else
		# I'd rather not use sudo within this script, prompt the user to do it instead.
		echo 'Please install Stow to continue.'
		echo 'If you''re using MacPorts on this machine, use:'
		echo '    sudo port install stow'
		echo 'then rerun this script.'
		exit 1
    fi
fi

if (($#)); then
  packages=("$@")
else
  packages=("${all_packages[@]}")
fi

# Clone dotfiles if not present
profile="$HOME/.profile"
if [[ ! -d "$profile/.git" ]]; then
    git clone https://github.com/iLynxcat/mac.git "$profile"
fi

for package in "${packages[@]}"; do
  if [[ ! -d "$profile/$package" ]]; then
    printf 'Error: unknown package: %s\n' "$package" >&2
    printf 'Available packages: %s\n' "${all_packages[*]}" >&2
    exit 2
  fi
done

echo "Previewing Stow changes for: ${packages[*]}"
stow --simulate --verbose --target="$HOME" --dir="$profile" "${packages[@]}"

printf 'Apply these links? [y/N] '
read -r answer
[[ "$answer" == [yY] ]] || exit 0

stow --verbose --target="$HOME" --dir="$profile" "${packages[@]}"

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/state"

if [[ "$brew_missing" -eq 1 ]] && (( ${packages[(e)homebrew]} )); then
	printf '`brew` not found. Install Homebrew? [y/N] '
	read -r answer
	if [[ "$answer" == [Yy] ]]; then
	    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		brew_missing=0
	else
		echo "OK: Not installing Homebrew"
	fi
fi

if (( ${packages[(e)shell]} )); then
	mkdir -p "$HOME/.local/state/zsh"
fi

echo 'Done'
