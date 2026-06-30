# fzf shell integration: Ctrl-T (paste a file path), Alt-C (cd into a dir).
# Ctrl-R is intentionally left to atuin, which is initialized later and overrides it.
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# Use ripgrep as fzf's file source — fast and respects .gitignore.
if command -v rg >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
export FZF_DEFAULT_OPTS='--height=50% --layout=reverse --border'
