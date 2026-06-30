# Ghost text (zsh-autosuggestions) settings.
# The plugin itself is sourced near the END of zshrc (after all widgets exist),
# but its config vars must be set beforehand — hence here.
#
# Accept the suggestion with Right-arrow / End; accept one word with Ctrl-Right.
ZSH_AUTOSUGGEST_STRATEGY=(history completion)   # prefer history, fall back to completion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'          # dim gray ghost text
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20              # skip suggesting on very long buffers
