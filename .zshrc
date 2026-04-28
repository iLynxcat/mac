autoload -Uz compinit && compinit

# Case-insensitive tab completion & glob matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt no_case_glob

# Navigation
setopt pushdminus # use intuitive order for relative cd (- backwards, + forwards)
setopt auto_cd    # skip typing `cd` to change cwd

setopt auto_pushd        # push to history automatically when navigating
setopt pushd_ignore_dups # ignore dupe paths in history

alias -- -='cd -'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# Commands
setopt share_history     # share command history between sessions
setopt hist_ignore_dups  # ignore sequential dupe commands in history
setopt hist_ignore_space # skip appending command to history when prefixed with a space
                         #   (useful when juggling secrets)

source <(fzf --zsh) # load fuzzy integration

# ctrl-t: fuzzy file search
export FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git'
# ctrl-g: fuzzy cd (default: alt+c)
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
bindkey '^G' fzf-cd-widget

# Tool aliases
alias lg='lazygit'
alias lazycontainer='lazydocker'
alias lc=lazycontainer
alias intellij='open -a "IntelliJ IDEA"'
alias ij=intellij

# Prepare custom prompt
eval "$(starship init zsh)"

# Add SSH keys if the agent is empty (simplest way to effectively do it "on first use")
ssh-add -l &>/dev/null || ssh-add --apple-load-keychain ~/.ssh/id_*
