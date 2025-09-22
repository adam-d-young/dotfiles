-- Centralized keymaps. All custom maps are leader-prefixed to preserve Vim defaults.
local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Quality-of-life
map("n", "<leader>w", ":w<CR>", "Write buffer")
map("n", "<leader>q", ":q<CR>", "Quit window")
map("n", "<leader>h", ":nohlsearch<CR>", "Clear search highlight")

-- Telescope
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, "Find files")
map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, "Live grep")
map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, "Buffers")
map("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end, "Help tags")

-- Telescope extensions (guarded)
map("n", "<leader>fr", function()
  local ok, ext = pcall(function()
    return require("telescope").extensions.frecency
  end)
  if ok and ext then ext.frecency() end
end, "Telescope: frecency")
map("n", "<leader>tb", function()
  local ok, ext = pcall(function()
    return require("telescope").extensions.bibtex
  end)
  if ok and ext then ext.bibtex() end
end, "Telescope: bibtex")
map("n", "<leader>ts", function()
  local ok, builtin = pcall(require, "telescope.builtin")
  if ok then builtin.symbols({}) end
end, "Telescope: symbols")

-- File explorer (Neo-tree)
map("n", "<leader>e", ":Neotree toggle<CR>", "Toggle file explorer")

-- Trouble quick diagnostics
map("n", "<leader>xx", function()
  require("trouble").toggle()
end, "Toggle Trouble")
map("n", "<leader>xw", function()
  require("trouble").toggle("workspace_diagnostics")
end, "Workspace diagnostics")
map("n", "<leader>xd", function()
  require("trouble").toggle("document_diagnostics")
end, "Document diagnostics")

-- Markdown preview via Glow
map("n", "<leader>mp", ":Glow<CR>", "Markdown preview (Glow)")

-- Telekasten (these will be no-ops unless notes profile/plugins are enabled)
map("n", "<leader>zn", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then tk.new_note() end
end, "Telekasten: new note")
map("n", "<leader>zd", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then tk.goto_today() end
end, "Telekasten: today")
map("n", "<leader>zz", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then tk.panel() end
end, "Telekasten: panel")
