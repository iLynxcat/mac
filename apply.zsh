#!/usr/bin/env zsh
set -euo pipefail

# This is currently unused but the `platform` variable will be used for platform-specific
# packages in the future!
case "$(uname -s)" in
	Darwin) platform='mac' ;;
	# TODO: support for linux
	*)
		printf 'Unsupported operating system: %s\n' "$(uname -s)" >&2
		exit 1
		;;
esac

# Package managers
brew_available=0    # Homebrew
port_available=0    # MacPorts
apt_available=0     # Debian/Ubuntu
pacman_available=0  # Arch

if command -v brew &>/dev/null; then
	brew_available=1
fi
if [[ "$platform" == mac ]] && command -v port &>/dev/null; then
	port_available=1
fi
if [[ "$platform" == linux ]] && command -v apt &>/dev/null; then
	apt_available=1
fi
if [[ "$platform" == linux ]] && command -v pacman &>/dev/null; then
	pacman_available=1
fi

# Check for Stow, it's required to apply packages
if ! stow_bin=$(command -v stow); then
	echo '`stow` command not found.'
	if (( $brew_available )); then
		echo 'Install it with Homebrew:'
		echo '  brew install stow'
	elif [[ "$platform" == mac ]]; then
		echo '`brew` not found. Install Homebrew: https://brew.sh/'
	fi
	if (( $port_available )); then
		echo 'Install it with MacPorts:'
		echo '  sudo port install stow'
	fi
	if (( $apt_available )); then
		echo 'Install it with apt:'
		echo '  sudo apt install stow'
	fi
	if (( $pacman_available )); then
		echo 'Install it with pacman:'
		echo '  sudo pacman -S stow'
	fi

	exit 2
fi

profile="$HOME/.profile"
profile_repo="https://github.com/iLynxcat/mac.git"

if [[ ! -d "$profile/.git" ]]; then
	printf 'Profile repository metadata not found: %s\nClone profile now? (%s) [Y/n] ' "$profile/.git" "$profile_repo"
	read -r answer
	if [[ -z "$answer" ]] || [[ "$answer" == [yY] ]]; then
		git clone "$profile_repo" "$profile"
	fi
fi

available_packages=()

for path in "$profile"/*/; do
	[[ -d "$path" ]] || continue # filter: subpath is directory
	name="${path%/}"             # strip trailing slash
	name="${name##*/}"           # strip preceding segments (i.e. /Users/name/.profile/)

	available_packages+=("$name")
done

# Read requested package names, fall back to all available
if (($#)); then
  packages=("$@")
else
  printf 'Available packages:\n  %s\nContinue with all? [Y/n] ' "$available_packages"
  read -r answer
  if [[ -z "$answer" ]] || [[ "$answer" == [yY] ]]; then
  	packages=("${available_packages[@]}")
  else
  	echo 'Please rerun the script specifying which packages to install.'
  	exit 1
  fi
fi

for package in "${packages[@]}"; do
  if [[ ! -d "$profile/$package" ]]; then
    printf 'Error: unknown package: %s\n' "$package" >&2
    printf 'Available packages:\n  %s\n' "${available_packages[*]}" >&2
    exit 2
  fi
done

echo 'Previewing Stow changes for:'
echo "  ${packages[*]}"
"$stow_bin" --simulate --verbose --target="$HOME" --dir="$profile" "${packages[@]}"

printf 'Apply these symlinks? [y/N] '
read -r answer
[[ "$answer" == [yY] ]] || exit 1

"$stow_bin" --target="$HOME" --dir="$profile" "${packages[@]}"

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/state"

if (( ${packages[(Ie)shell]} )); then
	mkdir -p "$HOME/.local/state/zsh"
fi

echo 'Done'
