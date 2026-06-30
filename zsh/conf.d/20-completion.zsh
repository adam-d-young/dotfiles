# Completion system + fzf-tab (the interactive fuzzy completion menu).
autoload -Uz compinit
# Rebuild the compdump at most once per day so shell startup stays fast.
_zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -n "$_zcompdump"(#qN.mh+24) ]]; then
  compinit -d "$_zcompdump"        # cache is >24h old → full rebuild
else
  compinit -C -d "$_zcompdump"     # cache is fresh → skip the security check
fi
unset _zcompdump

zstyle ':completion:*' menu no                              # let fzf-tab own the menu
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # case-insensitive matching
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '[%d]'           # group headers fzf-tab can show

# fzf-tab — must be sourced AFTER compinit. Turns Tab into a fuzzy, previewable menu.
if [[ -r "$HOMEBREW_PREFIX/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh" ]]; then
  source "$HOMEBREW_PREFIX/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"
  zstyle ':fzf-tab:*' fzf-flags --height=50% --layout=reverse
  # preview a directory's contents when completing `cd`
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always -- "$realpath"'
fi
