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
  local shell_rc
  shell_rc="$HOME/.zshrc"
  if [[ -n "${BASH:-}" ]]; then shell_rc="$HOME/.bashrc"; fi

  grep -q "NVIM_APPNAME=nvim-notes" "$shell_rc" || echo "alias nvim-notes='NVIM_APPNAME=nvim-notes nvim'" >>"$shell_rc"
  grep -q "NVIM_APPNAME=nvim-dev" "$shell_rc" || echo "alias nvim-dev='NVIM_APPNAME=nvim-dev nvim'" >>"$shell_rc"
  grep -q "nvim -u \$KICKSTART_PATH/init.lua" "$shell_rc" || echo "alias nvim-learn='nvim -u $KICKSTART_PATH/init.lua'" >>"$shell_rc"
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

main() {
  info "Setting up aliases"
  setup_aliases

  info "Linking dev profile"
  link_profile "nvim-dev"

  info "Linking notes profile"
  link_profile "nvim-notes"

  check_optional_media_previewer
  check_clipboard_tools
  check_glow_cli

  info "Done. Open with 'nvim-dev' or 'nvim-notes'"
}

main "$@"
