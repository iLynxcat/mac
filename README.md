# .mac

Dotfiles and easy setup for my personal Mac.

- **[GNU Stow][stow]** manages symlinks for dotfiles.
- **[Homebrew Bundle][brew bundle]** manages installation of apps and tools.

## Includes

- Apps, tools, and toolchains (see _Brewfile_ in _.homebrew_)
- Automatic package updates (see _me.ilynxcat.brew-bundle.plist_ in _Library/LaunchAgents_)
- Zed configuration (see _.config/zed_)
- Ghostty configuration (see _config.ghostty_ in _.config/ghostty_)
- zsh customizations
	- [Starship](https://starship.rs) prompt that emulates the oh-my-zsh _apple_ theme
	- _fzf_ interactive fuzzy commands
		- `^G` = Interactive _cd_
		- `^T` = File finder
		- `^R` = Command history
	- Case-insensitive path completions
	- Case-insensitive globs
	- Custom aliases (see _.zshrc_)
	- JDK version switcher (see _jdk.zsh_ in _.zsh_)
	- SSH keys quietly auto-load from Keychain on first shell open

## Setup

```sh
/bin/zsh -c "$(curl -fsSL https://tangled.org/ilynxcat.me/mac/raw/main/update.zsh)"
```

This repository is only maintained for my own personal use. Please don't expect anything to work
nicely on your system.

## License/Usage

Feel free to use, remix, and distribute parts of, or the whole of, this config however you see fit. 

[stow]: https://www.gnu.org/software/stow/
[brew bundle]: https://docs.brew.sh/Brew-Bundle-and-Brewfile
