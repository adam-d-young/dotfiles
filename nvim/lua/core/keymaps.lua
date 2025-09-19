local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better movement in wrapped lines
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Save/Quit
map({'n','i','v'}, '<C-s>', '<cmd>w<cr>', opts)
map('n', '<leader>qq', '<cmd>qa<cr>', opts)

-- Clear search
map('n', '<esc>', '<cmd>nohlsearch<cr>', opts)

-- Window management
map('n', '<leader>sv', '<C-w>v', opts)
map('n', '<leader>sh', '<C-w>s', opts)
map('n', '<leader>se', '<C-w>=', opts)
map('n', '<leader>sx', '<cmd>close<cr>', opts)

-- Buffers
map('n', '<S-l>', '<cmd>bnext<cr>', opts)
map('n', '<S-h>', '<cmd>bprevious<cr>', opts)

-- Diagnostics
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)
map('n', '<leader>e', vim.diagnostic.open_float, opts)
