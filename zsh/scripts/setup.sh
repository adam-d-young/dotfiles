#!/usr/bin/env bash
set -euo pipefail
# Deploy the zsh config: install Homebrew deps and symlink ~/.zshrc -> this repo.
# Clean and idempotent. Does NOT append to or rewrite existing rc files — the
# repo's zsh/zshrc IS your ~/.zshrc (via symlink); machine-local additions go in
# ~/.zshrc.local.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"     # .../dotfiles/zsh

info(){ printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn(){ printf '\033[1;33m==>\033[0m %s\n' "$*"; }

# 1) Homebrew dependencies
if command -v brew >/dev/null 2>&1; then
  info "installing brew deps (Brewfile)"
  brew bundle --file="$ZSH_DIR/Brewfile"
else
  warn "Homebrew not found — install the tools in $ZSH_DIR/Brewfile manually"
fi

# 2) symlink ~/.zshrc -> repo zshrc (back up any existing real file once)
target="$HOME/.zshrc"
src="$ZSH_DIR/zshrc"
if [[ -L "$target" ]]; then
  info "~/.zshrc already a symlink -> $(readlink "$target")"
elif [[ -e "$target" ]]; then
  warn "backing up existing ~/.zshrc -> ~/.zshrc.pre-dotfiles"
  mv "$target" "$HOME/.zshrc.pre-dotfiles"
fi
ln -sfn "$src" "$target"
info "linked ~/.zshrc -> $src"

# 3) login-shell hint (zsh is already in /etc/shells on this box)
if [[ "${SHELL:-}" != *zsh ]]; then
  warn "Login shell is ${SHELL:-unknown}. To switch: chsh -s /usr/bin/zsh  (asks for your password)"
fi

info "Done. Start a new session or run:  exec zsh"
