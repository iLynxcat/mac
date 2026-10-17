# .mac (for macOS Monterey)

Dotfiles and easy setup for my setup on macOS Monterey.

- **[GNU Stow][stow]** manages symlinks for dotfiles.
- **[MacPorts][port]** manages installation of command-line tools.

## Includes

- Zed configuration (_.config/zed_)
- zsh customizations
	- Shell prompt with [Starship](https://starship.rs)
	- _fzf_ interactive fuzzy commands
		- `^G` = Interactive _cd_
		- `^T` = File finder
		- `^R` = Command history
	- Navigation conveniences
	- Case-insensitive path completions and globs
	- Tool aliases
	- JDK version switcher (_.zsh/jdk.zsh_)
	- SSH keys quietly auto-load from Keychain on first shell open

## Setup

1. Clone this repository:
    ```
    git clone --branch os/12-monterey https://github.com/iLynxcat/mac ~/.profile
    ```
2. Set all configuration files in place:
    ```
    cd ~/.profile
    stow -Rv --no-folding .
    ```

This repository is only maintained for my own personal use. Please don't expect anything to work
nicely on your system.

## License/Usage

Feel free to use, remix, and distribute parts of, or the whole of, this config however you see fit. 

[stow]: https://www.gnu.org/software/stow/
[port]: https://macports.org/
