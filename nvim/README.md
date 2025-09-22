### Neovim Configuration (nvim)

A modular, lazy-loaded Neovim setup with two profiles using NVIM_APPNAME:
- nvim (default): General development (base UX, Treesitter, LSP, completion)
- nvim-notes: Notes-focused (adds Telekasten and related tools)

Plugins are managed by lazy.nvim and install automatically on first launch.

### Requirements
- Neovim 0.10+
- Git
- Optional build tools: make (for telescope-fzf-native)
- Optional CLIs:
  - Glow (Markdown preview)
  - viu or catimg (image previews in Telescope)
  - macOS: pbcopy; Linux: xclip or wl-clipboard (clipboard and image paste helpers)

### Quick start (recommended)
1) Run the setup script from this directory:
```bash
scripts/setup.sh
```
This will:
- Create aliases in your shell rc: `nvim` (default dev, no alias needed), `nvim-notes`, `nvim-learn`
- Link this config into per-profile directories: `~/.config/nvim` (default), `~/.config/nvim-notes`
- Check optional CLIs (glow, viu/catimg, clipboard tools)

2) Launch a profile:
```bash
nvim         # development profile (default)
nvim-notes   # notes profile (Telekasten enabled)
```

Neovide (GUI): if installed, use `neovide` for the default profile and `neovide-notes` for notes.

### Telekasten vault location
You can point Telekasten at any directory by setting one of these environment variables before launching Neovim:
- TELEKASTEN_HOME (preferred)
- ZK_HOME (fallback)

Examples:
```bash
# One-off for the current shell
TELEKASTEN_HOME="$HOME/Notes/zk" nvim-notes

# Persist in your shell rc (zsh)
echo 'export TELEKASTEN_HOME="$HOME/Notes/zk"' >> "$HOME/.zshrc"
```
If unset, the default is `~/.zk`.

The config uses templates from:
- `stdpath('config')/templates` (this repo's `templates/` folder once linked by setup)

### Profiles explained
- nvim (default)
  - Loads: base UX (tokyonight, lualine, neo-tree, telescope, trouble, gitsigns, which-key, indent guides), coding stack (Treesitter, LSP via mason + lspconfig, nvim-cmp, formatting/linting via none-ls)
- nvim-notes
  - Everything in nvim-dev, plus Telekasten, calendar, media previews
  - Telekasten templates: `zettel.md`, `daily.md`, `weekly.md`, `monthly.md`, `quarterly.md`, `yearly.md`

### Common keymaps
- <leader> is Space
- File search and navigation (Telescope):
  - `<leader>ff`: find files
  - `<leader>fg`: live grep
  - `<leader>fb`: buffers
  - `<leader>fr`: frecency (if installed)
  - `<leader>ts`: symbols
  - `<leader>tb`: bibtex (if installed)
- File explorer: `<leader>e`
- Diagnostics (Trouble):
  - `<leader>xx`: toggle
  - `<leader>xw`: workspace diagnostics
  - `<leader>xd`: document diagnostics
- Markdown preview (Glow): `<leader>mp`
- Telekasten (notes profile):
  - `<leader>zn`: new note
  - `<leader>zd`: today
  - `<leader>zz`: panel

### Updating / development
- Formatting (Stylua):
```bash
stylua --config-path ./.stylua.toml .
```
- Linting (Luacheck):
```bash
luacheck --config ./.luacheckrc .
```
- Tests (Plenary):
```bash
# From this directory
nvim --headless -u tests/minimal_init.lua \
  -c "PlenaryBustedDirectory tests/spec {minimal_init = 'tests/minimal_init.lua'}" \
  -c "qa!"
```

### Optional: learn profile
Set `KICKSTART_PATH` to a local kickstart.nvim clone to enable the `nvim-learn` alias (created by `scripts/setup.sh`).
```bash
echo 'export KICKSTART_PATH="$HOME/src/kickstart.nvim"' >> "$HOME/.zshrc"
```
Then:
```bash
nvim-learn
```

### Troubleshooting
- Missing Glow / viu / catimg: install via your package manager; the setup script will warn if they are not found.
- telescope-fzf-native not compiled: ensure `make` is available; lazy.nvim will build it when possible.
- Telekasten vault not found: set `TELEKASTEN_HOME` or `ZK_HOME` to your notes directory before launching `nvim-notes`.
- Clipboard issues on Linux: install `xclip` (X11) or `wl-clipboard` (Wayland).

### Uninstall
- Remove linked configs:
```bash
rm -rf ~/.config/nvim-dev ~/.config/nvim-notes
```
- Remove aliases from `~/.zshrc`/`~/.bashrc`.
