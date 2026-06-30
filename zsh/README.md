# zsh

A modern, fully-local zsh setup — a "Warp-like" experience at the shell layer,
with zero network calls. No Oh-My-Zsh, no plugin manager; plugins come from
Homebrew and are sourced directly.

## What's in it

| Tool | Role | Key |
|---|---|---|
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Ghost text — inline suggestion from history as you type | → / End accepts |
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | Live command coloring (typos red, valid green, etc.) | — |
| [fzf](https://github.com/junegunn/fzf) + [fzf-tab](https://github.com/Aloxaf/fzf-tab) | Fuzzy interactive **Tab** completion + Ctrl-T / Alt-C | Tab, Ctrl-T, Alt-C |
| [atuin](https://github.com/atuinsh/atuin) | Searchable shell history (dir, exit code, duration) | Ctrl-R |
| [starship](https://starship.rs) | The prompt | — |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter cd that learns your habits | `z <partial>`, `zi` |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Fast content search; fzf's file source | `rg` |

## Install

```bash
zsh/scripts/setup.sh          # installs brew deps + symlinks ~/.zshrc -> zsh/zshrc
chsh -s /usr/bin/zsh          # make zsh your login shell (asks for your password)
exec zsh                      # or just open a new terminal
```

`~/.zshrc` becomes a symlink to `zsh/zshrc`. Machine-local, un-versioned tweaks
go in `~/.zshrc.local` (sourced automatically, never committed).

## Layout

```
zsh/
  zshrc              entry point; sources conf.d/* then the order-sensitive tail
  conf.d/
    00-options.zsh   shell options
    10-history.zsh   history settings
    15-ghost-text.zsh  zsh-autosuggestions config (plugin sourced later)
    20-completion.zsh  compinit (daily-cached) + fzf-tab
    30-fzf.zsh       fzf key bindings + ripgrep as the file source
    40-tools.zsh     zoxide + starship init
    50-aliases.zsh   general aliases
  Brewfile           the dependency list
  scripts/setup.sh   installer (brew bundle + symlink)
```

**Load order matters** and is enforced in `zshrc`: the bulk loads from `conf.d/`,
then the tail runs `autosuggestions → fast-syntax-highlighting → atuin` last
(highlighting must wrap the final buffer; atuin rebinds Ctrl-R).

## Optional: local AI command generation

The NPU server at `127.0.0.1:8081` (FastFlowLM / `flm-npu.service`) can power a
Warp-style "describe a command in English → get the command" widget, fully on-box.
Drop a `conf.d/60-npu-llm.zsh` that binds a key (e.g. `Ctrl-X Ctrl-A`) to a ZLE
widget which POSTs the current buffer to `/v1/chat/completions` and replaces it
with the model's answer. Not installed by default.

## Notes

- **No Warp.** Warp routes AI through its US cloud (even with a "local" model it
  requires a public tunnel and sends your terminal context off-box), so it's a
  poor fit for a local/privacy-first setup. This stack reproduces everything
  except literal command *blocks*, which are terminal-level only.
- The flat `~/.zsh_history` is kept as atuin's import source and a fallback.
