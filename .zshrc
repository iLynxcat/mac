source <(fzf --zsh) # fuzzy integration

# ctrl-t: fuzzy file search
export FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git'
# ctrl-g: fuzzy cd (default: alt+c)
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
bindkey '^G' fzf-cd-widget

alias lg="lazygit"
alias lazycontainer="lazydocker"
alias lc="lazydocker"

# Prepare custom prompt
eval "$(starship init zsh)"

# Add SSH keys if the agent is empty (simplest way to effectively do it "on first use")
ssh-add -l &>/dev/null || ssh-add --apple-load-keychain ~/.ssh/id_*
