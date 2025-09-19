return {
  -- Telekasten for Zettelkasten notes
  {
    'renerocksai/telekasten.nvim',
    enabled = false, -- enabled by profile
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    opts = function()
      local home = vim.fn.expand('~/zettelkasten')
      return {
        home = home,
        dailies = home .. '/daily',
        weeklies = home .. '/weekly',
        templates = home .. '/templates',
        template_new_note = home .. '/templates/new_note.md',
        template_new_daily = home .. '/templates/daily.md',
        template_new_weekly = home .. '/templates/weekly.md',
      }
    end,
    keys = function()
      local tk = require('telekasten')
      return {
        { '<leader>zz', tk.home, desc = 'Telekasten Home' },
        { '<leader>zf', tk.find_notes, desc = 'Telekasten Find Notes' },
        { '<leader>zg', tk.search_notes, desc = 'Telekasten Search Grep' },
        { '<leader>zd', tk.find_daily_notes, desc = 'Telekasten Dailies' },
        { '<leader>zw', tk.find_weekly_notes, desc = 'Telekasten Weeklies' },
        { '<leader>zn', tk.new_note, desc = 'Telekasten New Note' },
        { '<leader>zc', tk.show_calendar, desc = 'Telekasten Calendar' },
        { '<leader>zb', tk.backlinks, desc = 'Telekasten Backlinks' },
      }
    end
  },
}
