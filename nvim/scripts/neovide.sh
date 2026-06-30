#!/bin/bash
# Neovide launcher with proper font configuration

# Check if JetBrains Nerd Font is available
if fc-list | grep -q "JetBrains Nerd Font"; then
    FONT="JetBrains Nerd Font"
elif fc-list | grep -q "JetBrainsMono Nerd Font"; then
    FONT="JetBrainsMono Nerd Font Mono"
elif fc-list | grep -q "FiraCode Nerd Font"; then
    FONT="FiraCode Nerd Font Mono"
elif fc-list | grep -q "Cascadia Code"; then
    FONT="Cascadia Code"
else
    FONT="Monospace"
fi

# Launch Neovide with font configuration
neovide \
    --font "$FONT" \
    --fontsize 14 \
    --line-height 1.2 \
    --multigrid \
    --neovim-bin nvim \
    "$@"
