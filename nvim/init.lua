-- Neovim entrypoint for this configuration
-- Leader keys must be set before plugins
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Core settings
require("user.core.options")
require("user.core.keymaps")

-- Plugin manager and plugins
require("user.lazy")

-- LSP setup (after plugins are loaded)
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function()
    require("user.core.lsp").setup()
  end,
})
