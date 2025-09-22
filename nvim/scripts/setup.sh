#!/usr/bin/env bash
set -euo pipefail

# Manage multiple NVIM_APPNAME profiles and dependencies

OS="$(uname -s)"

need() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing dependency: $1" >&2
    return 1
  }
}

info() { echo -e "\033[1;34m==>\033[0m $*"; }
warn() { echo -e "\033[1;33m==>\033[0m $*"; }

setup_aliases() {
  # Update both zsh and bash rc files idempotently
  local rc_files=("$HOME/.zshrc" "$HOME/.bashrc")

  local add_line
  add_line() {
    local file="$1"; shift
    local line="$*"
    mkdir -p "$(dirname "$file")"
    touch "$file"
    grep -Fq "$line" "$file" || echo "$line" >>"$file"
  }

  # Aliases to add
  local a_notes="alias nvim-notes='NVIM_APPNAME=nvim-notes nvim'"
  local a_learn="alias nvim-learn='nvim -u \$KICKSTART_PATH/init.lua'"
  local a_neovide_notes="alias neovide-notes='NVIM_APPNAME=nvim-notes neovide'"
  local a_neovide_learn="alias neovide-learn='neovide -- -u \$KICKSTART_PATH/init.lua'"
  local a_tk="alias tk='NVIM_APPNAME=nvim-notes neovide'"

  local f
  for f in "${rc_files[@]}"; do
    add_line "$f" "$a_notes"
    add_line "$f" "$a_learn"
    if command -v neovide >/dev/null 2>&1; then
      add_line "$f" "$a_neovide_notes"
      add_line "$f" "$a_neovide_learn"
      add_line "$f" "$a_tk"
    fi
  done
}

link_profile() {
  local name="$1"
  local target_dir="$HOME/.config/$1"

  mkdir -p "$target_dir"
  rsync -a --delete --exclude ".git" --exclude "tests" --exclude "scripts" ./ "$target_dir"/
}

check_optional_media_previewer() {
  if command -v viu >/dev/null 2>&1; then
    info "Using 'viu' for media preview"
  elif command -v catimg >/dev/null 2>&1; then
    info "Using 'catimg' for media preview"
  else
    warn "No terminal image previewer (viu/catimg) found; media preview disabled"
  fi
}

check_clipboard_tools() {
  case "$OS" in
    Darwin)
      need pbcopy || warn "pbcopy missing (should be available on macOS)" ;;
    Linux)
      command -v xclip >/dev/null 2>&1 || command -v wl-copy >/dev/null 2>&1 || warn "Install xclip or wl-clipboard for image paste" ;;
  esac
}

check_glow_cli() {
  if command -v glow >/dev/null 2>&1; then
    info "Glow CLI found for markdown preview"
  else
    warn "Glow CLI not found; install from https://github.com/charmbracelet/glow"
  fi
}

check_marksman() {
  if command -v marksman >/dev/null 2>&1; then
    info "Marksman LSP found for markdown support"
  else
    warn "Marksman LSP not found; install from https://github.com/artempyanykh/marksman"
    case "$OS" in
      Darwin)
        warn "On macOS, install with: brew install marksman"
        ;;
      Linux)
        warn "On Linux, download from: https://github.com/artempyanykh/marksman/releases"
        ;;
    esac
  fi
}

main() {
  info "Setting up aliases"
  setup_aliases

  info "Linking default dev profile to ~/.config/nvim"
  link_profile "nvim"

  info "Linking notes profile"
  link_profile "nvim-notes"

  check_optional_media_previewer
  check_clipboard_tools
  check_glow_cli
  check_marksman

  info "Done. Open with 'nvim' (dev) or 'nvim-notes' (notes). For GUI, use 'neovide' or 'neovide-notes' if available."
}

main "$@"
