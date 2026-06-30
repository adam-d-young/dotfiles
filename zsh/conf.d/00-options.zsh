# Core shell behavior
setopt AUTO_CD                # bare `dir` means `cd dir`
setopt AUTO_PUSHD             # cd pushes the old dir onto the stack
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt INTERACTIVE_COMMENTS   # allow `# comments` at the interactive prompt
setopt EXTENDED_GLOB          # #, ~, ^ in globs
setopt NO_BEEP
setopt COMPLETE_IN_WORD       # complete from both ends of a word
