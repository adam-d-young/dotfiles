-- General purpose coding profile
-- Inspired by beginner-friendly single-file configs, but modularized.

-- Keymaps for common actions
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<leader>/', function()
  require('telescope.builtin').live_grep()
end, vim.tbl_extend('force', opts, { desc = 'Grep in project' }))

map('n', '<leader>p', function()
  require('telescope.builtin').find_files()
end, vim.tbl_extend('force', opts, { desc = 'Find files' }))

-- Example: toggle relative number
map('n', '<leader>tr', function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, vim.tbl_extend('force', opts, { desc = 'Toggle relativenumber' }))

-- Additional beginner-help: show key hints after leader
local wk_ok, wk = pcall(require, 'which-key')
if wk_ok then
  wk.register({
    ['<leader>'] = {
      name = '+leader',
      f = { name = '+find' },
      z = { name = '+zettel' },
    }
  })
end
