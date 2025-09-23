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
  if ok and ext then
    ext.frecency()
  end
end, "Telescope: frecency")
map("n", "<leader>tb", function()
  local ok, ext = pcall(function()
    return require("telescope").extensions.bibtex
  end)
  if ok and ext then
    ext.bibtex()
  end
end, "Telescope: bibtex")
map("n", "<leader>ts", function()
  local ok, builtin = pcall(require, "telescope.builtin")
  if ok then
    builtin.symbols({})
  end
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

-- Quick Telekasten search (most common use case)
map("n", "<leader>fd", function()
  local telekasten_home = vim.env.TELEKASTEN_HOME or vim.env.ZK_HOME or vim.fn.expand("~/.zk")

  require("telescope.builtin").find_files({
    search_dirs = { telekasten_home },
    file_ignore_patterns = {
      "%.git/",
      "%.obsidian/",
      "node_modules/",
      "%.DS_Store",
    },
  })
end, "Find files (Telekasten)")

-- Quick Telekasten grep (most common use case)
map("n", "<leader>gd", function()
  local telekasten_home = vim.env.TELEKASTEN_HOME or vim.env.ZK_HOME or vim.fn.expand("~/.zk")

  require("telescope.builtin").live_grep({
    search_dirs = { telekasten_home },
    file_ignore_patterns = {
      "%.git/",
      "%.obsidian/",
      "node_modules/",
      "%.DS_Store",
    },
  })
end, "Live grep (Telekasten)")

-- Advanced ripgrep search with arguments
map("n", "<leader>ga", function()
  require("telescope").extensions.live_grep_args.live_grep_args()
end, "Live grep with args (ripgrep)")

-- Timestamp insertion for daily notes
map("i", "<C-g><C-t>", function()
  local timestamp = os.date("%H:%M")
  vim.api.nvim_put({ timestamp }, "c", true, true)
end, "Insert current time")

-- Telekasten (these will be no-ops unless notes profile/plugins are enabled)
map("n", "<leader>zn", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    local cfg = require("telekasten").CONFIG
    local zdir = (cfg and cfg.zettels) or nil
    if zdir and #zdir > 0 then
      tk.new_templated_note({ template = "zettel", dir = zdir })
    else
      tk.new_note()
    end
  end
end, "Telekasten: new note")
map("n", "<leader>zd", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.goto_today()
  end
end, "Telekasten: today")
map("n", "<leader>zz", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.panel()
  end
end, "Telekasten: panel")

-- Telekasten: insert/link existing (picker supports create-on-confirm)
map("n", "<leader>zl", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.insert_link()
  end
end, "Telekasten: insert link")

-- Telekasten: follow link under cursor (creates if missing)
map("n", "<leader>zf", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.follow_link()
  end
end, "Telekasten: follow link")

-- Telekasten templates
map("n", "<leader>zp", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.new_templated_note({ template = "project" })
  end
end, "Telekasten: new project")
map("n", "<leader>za", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.new_templated_note({ template = "area" })
  end
end, "Telekasten: new area")
map("n", "<leader>zw", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.goto_thisweek()
  end
end, "Telekasten: new weekly")
map("n", "<leader>zm", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.goto_thismonth()
  end
end, "Telekasten: new monthly")
-- Removed quarterly creation keymap
map("n", "<leader>zy", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    local default_year = os.date("%Y")
    vim.ui.input({ prompt = "Year (YYYY): ", default = default_year }, function(input_year)
      if not input_year or input_year == "" then
        return
      end
      local match = tostring(input_year):match("^%d%d%d%d$")
      if not match then
        vim.notify("Invalid year: " .. tostring(input_year), vim.log.levels.WARN)
        return
      end
      tk.new_templated_note({ template = "yearly", title = match, no_prompt = true })
    end)
  end
end, "Telekasten: new yearly")
