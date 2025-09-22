-- Core editor options
local opt = vim.opt

opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 8

opt.splitbelow = true
opt.splitright = true

opt.ignorecase = true
opt.smartcase = true

opt.updatetime = 200
opt.timeoutlen = 300

opt.clipboard = "unnamedplus"
opt.undofile = true
opt.completeopt = { "menu", "menuone", "noselect" }

-- Respect modelines but keep it safe
opt.modeline = true
opt.modelines = 1
