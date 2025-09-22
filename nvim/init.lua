-- Neovim entrypoint for this configuration
-- Leader keys must be set before plugins
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Core settings
require("user.core.options")
require("user.core.keymaps")

-- Plugin manager and plugins
require("user.lazy")
