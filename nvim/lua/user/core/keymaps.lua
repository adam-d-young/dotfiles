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

-- Telekasten link completion on [[
map("i", "[[", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.insert_link()
  else
    vim.api.nvim_put({ "[[" }, "c", true, true)
  end
end, "Telekasten: insert link on [[")

-- Telekasten (these will be no-ops unless notes profile/plugins are enabled)
-- Toggle Markdown checkbox on current line via Telekasten
map("n", "<leader>t", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.toggle_todo()
  end
end, "Telekasten: toggle todo")
map("n", "<leader>zn", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    local cfg = vim.g.__telekasten_last_opts or tk.cfg
    if cfg and cfg.template_new_note then
      tk.new_templated_note({
        template = cfg.template_new_note,
        no_prompt = false,
      })
    else
      tk.new_templated_note()
    end
  end
end, "Telekasten: new note from template")
-- Daily note navigation functions
local function get_daily_notes()
  local ok, tk = pcall(require, "telekasten")
  if not ok then
    return {}
  end

  local cfg = vim.g.__telekasten_last_opts or tk.cfg
  if not cfg or not cfg.dailies then
    return {}
  end

  local dailies_dir = cfg.dailies
  local files = vim.fn.globpath(dailies_dir, "*.md", false, true)
  local daily_notes = {}

  for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ":t")
    local date_str = filename:match("^(%d%d%d%d%-%d%d%-%d%d)")
    if date_str then
      table.insert(daily_notes, {
        file = file,
        date = date_str,
        filename = filename,
      })
    end
  end

  -- Sort by date
  table.sort(daily_notes, function(a, b)
    return a.date < b.date
  end)
  return daily_notes
end

local function goto_previous_daily()
  local daily_notes = get_daily_notes()
  if #daily_notes == 0 then
    vim.notify("No daily notes found", vim.log.levels.WARN)
    return
  end

  local current_file = vim.fn.expand("%:p")
  local current_date = nil

  -- Find current note's date
  for _, note in ipairs(daily_notes) do
    if note.file == current_file then
      current_date = note.date
      break
    end
  end

  -- If not in a daily note, find the most recent one before today
  if not current_date then
    local today = os.date("%Y-%m-%d")
    for i = #daily_notes, 1, -1 do
      if daily_notes[i].date < today then
        vim.cmd("edit " .. daily_notes[i].file)
        return
      end
    end
    vim.notify("No previous daily notes found", vim.log.levels.WARN)
    return
  end

  -- Find previous note
  for i, note in ipairs(daily_notes) do
    if note.date == current_date and i > 1 then
      vim.cmd("edit " .. daily_notes[i - 1].file)
      return
    end
  end

  vim.notify("No previous daily note found", vim.log.levels.WARN)
end

local function goto_next_daily()
  local daily_notes = get_daily_notes()
  if #daily_notes == 0 then
    vim.notify("No daily notes found", vim.log.levels.WARN)
    return
  end

  local current_file = vim.fn.expand("%:p")
  local current_date = nil

  -- Find current note's date
  for _, note in ipairs(daily_notes) do
    if note.file == current_file then
      current_date = note.date
      break
    end
  end

  -- If not in a daily note, find the oldest one after today
  if not current_date then
    local today = os.date("%Y-%m-%d")
    for _, note in ipairs(daily_notes) do
      if note.date > today then
        vim.cmd("edit " .. note.file)
        return
      end
    end
    vim.notify("No next daily notes found", vim.log.levels.WARN)
    return
  end

  -- Find next note
  for i, note in ipairs(daily_notes) do
    if note.date == current_date and i < #daily_notes then
      vim.cmd("edit " .. daily_notes[i + 1].file)
      return
    end
  end

  vim.notify("No next daily note found", vim.log.levels.WARN)
end

map("n", "<leader>zd", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.goto_today()
  end
end, "Telekasten: today")
map("n", "<leader>z<", goto_previous_daily, "Telekasten: previous daily note")
map("n", "<leader>z>", goto_next_daily, "Telekasten: next daily note")
map("n", "<leader>zz", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.panel()
  end
end, "Telekasten: panel")
map("n", "<leader>zt", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.show_tags()
  end
end, "Telekasten: show tags")

-- Alternative tag search that searches for tag patterns
map("n", "<leader>zT", function()
  local telekasten_home = vim.env.TELEKASTEN_HOME or vim.env.ZK_HOME or vim.fn.expand("~/.zk")
  require("telescope.builtin").live_grep({
    search_dirs = { telekasten_home },
    prompt_title = "Search for tags",
    default_text = "tags:",
    file_ignore_patterns = {
      "%.git/",
      "%.obsidian/",
      "node_modules/",
      "%.DS_Store",
      "templates/",
    },
  })
end, "Telekasten: search tags manually")

-- Telekasten: insert/link existing (picker supports create-on-confirm)
map("n", "<leader>zl", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    tk.insert_link()
  end
end, "Telekasten: insert link")
map("n", "<leader>zi", function()
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
-- Telekasten: follow link in vertical split
map("n", "<leader>zv", function()
  local ok, tk = pcall(require, "telekasten")
  if ok then
    vim.cmd("vsplit")
    tk.follow_link()
  end
end, "Telekasten: follow link (vertical split)")

-- Telekasten templates
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
