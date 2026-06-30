# History — the flat HISTFILE remains as a fallback and as atuin's import source;
# atuin (loaded last in zshrc) is the primary Ctrl-R history UI.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt SHARE_HISTORY          # share history across running sessions
setopt EXTENDED_HISTORY       # record command start time + duration
setopt INC_APPEND_HISTORY     # write as you go, not just on exit
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE      # a leading space keeps a command out of history
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY            # show, don't immediately run, an expanded `!!`
