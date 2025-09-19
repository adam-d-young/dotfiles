-- Sensible defaults and UI
local o = vim.opt

-- Encoding and files
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- UI
o.number = true
o.relativenumber = true
o.cursorline = true
o.termguicolors = true
o.signcolumn = 'yes'
o.wrap = false

-- Indentation
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true

-- Search
o.ignorecase = true
o.smartcase = true

-- Performance
o.updatetime = 250

-- Splits
o.splitbelow = true
o.splitright = true

-- Clipboard
if vim.fn.has('mac') == 1 then
  o.clipboard = 'unnamedplus'
end

-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
