# .mac

Dotfiles and easy setup for my personal Mac.

- **[GNU Stow][stow]** manages symlinks for dotfiles.
- **[Homebrew Bundle][brew bundle]** manages installation of apps and tools.

## Includes

- Apps, tools, and toolchains via Homebrew
- Editor and terminal configurations
- Shell customizations
	- Shell prompt with [Starship](https://starship.rs)
	- _fzf_ interactive fuzzy commands
		- `^G` = Interactive _cd_
		- `^T` = File finder
		- `^R` = Command history
	- Navigation conveniences
	- Case-insensitive path completions and globs
	- Tool aliases
	- SSH keys quietly auto-load from Keychain on first shell open
- Other configuration and utilities (Java, Git)

## Setup

```sh
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/iLynxcat/mac/HEAD/update.zsh)"
```

This repository is only maintained for my own personal use. Please don't expect anything to work
nicely on your system.

## License/Usage

Feel free to use, remix, and distribute parts of, or the whole of, this config however you see fit. 

[stow]: https://www.gnu.org/software/stow/
[brew bundle]: https://docs.brew.sh/Brew-Bundle-and-Brewfile
