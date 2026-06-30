# Single-purpose modern CLI tools.

# zoxide — a smarter cd that learns your habits.
#   `z <partial>`  jump to the best-matching frequently-used dir
#   `zi`           interactive pick via fzf
# (To make plain `cd` use zoxide, change the init line to: `zoxide init zsh --cmd cd`.)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# starship — the prompt (git status, dirs, language versions, etc.).
export STARSHIP_CONFIG="$ZSH_CONFIG_DIR/starship.toml"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
