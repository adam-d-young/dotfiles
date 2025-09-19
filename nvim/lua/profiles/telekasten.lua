-- Telekasten-focused profile
-- Enables Telekasten plugin and sets focused keymaps

-- Enable Telekasten plugin by toggling lazy's spec at runtime
-- lazy.nvim supports plugin.disable = true at spec time; to enable here, we can
-- call require('lazy').load for the module and set it enabled via module loader.
-- Simplest: trigger a manual load by requiring the module function using plugin name.

local ok_lazy, lazy = pcall(require, 'lazy')
if ok_lazy then
  -- try load plugins in the 'plugins.notes' import which contains telekasten
  lazy.load({ plugins = { 'telekasten.nvim' } })
end

local has_tk, tk = pcall(require, 'telekasten')
if not has_tk then return end

-- Default home structure
local home = vim.fn.expand('~/zettelkasten')

-- Ensure directories exist (non-blocking)
local function ensure_dir(path)
  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, 'p')
  end
end
ensure_dir(home)
ensure_dir(home .. '/daily')
ensure_dir(home .. '/weekly')
ensure_dir(home .. '/templates')

-- Keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<leader>zz', tk.home, opts)
map('n', '<leader>zf', tk.find_notes, opts)
map('n', '<leader>zg', tk.search_notes, opts)
map('n', '<leader>zd', tk.find_daily_notes, opts)
map('n', '<leader>zw', tk.find_weekly_notes, opts)
map('n', '<leader>zn', tk.new_note, opts)
map('n', '<leader>zc', tk.show_calendar, opts)
map('n', '<leader>zb', tk.backlinks, opts)
