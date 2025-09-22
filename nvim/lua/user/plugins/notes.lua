local profile = require("user.utils.profile")

return {
  -- Telekasten setup only if in notes profile
  {
    "renerocksai/telekasten.nvim",
    cond = function()
      return profile.is_notes()
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "renerocksai/calendar-vim",
      "nvim-telescope/telescope-media-files.nvim",
    },
    opts = function()
      -- Allow overriding Telekasten home via env vars
      local env_home = vim.env.TELEKASTEN_HOME or vim.env.ZK_HOME or nil
      local home = env_home and vim.fn.expand(env_home) or vim.fn.expand("~/.zk")
      local templates_path = home .. "/templates"
      
      return {
        home = home,
        dailies = home .. "/daily",
        weeklies = home .. "/weekly",
        templates = templates_path,
        template_new_note = templates_path .. "/zettel.md",
        template_new_daily = templates_path .. "/daily.md",
        template_new_weekly = templates_path .. "/weekly.md",
        plug_into_calendar = true,
        media_previewer = "viu-previewer",
        media_extensions = { "png", "jpg", "jpeg", "gif", "webp" },
      }
    end,
    config = function(_, opts)
      -- Debug telekasten configuration
      vim.notify("Telekasten config - home: " .. opts.home, vim.log.levels.INFO)
      vim.notify("Telekasten config - templates: " .. opts.templates, vim.log.levels.INFO)
      vim.notify("Telekasten config - daily template: " .. opts.template_new_daily, vim.log.levels.INFO)
      
      -- Check if templates exist
      vim.notify("Looking for daily template at: " .. opts.template_new_daily, vim.log.levels.INFO)
      vim.notify("Daily template exists: " .. tostring(vim.fn.filereadable(opts.template_new_daily) == 1), vim.log.levels.INFO)
      
      -- Ensure templates directory exists (templates should be set up by setup script)
      local templates_dir = opts.templates
      if vim.fn.isdirectory(templates_dir) == 0 then
        vim.fn.mkdir(templates_dir, "p")
        vim.notify("Telekasten templates directory created: " .. templates_dir .. " (run setup script to install templates)", vim.log.levels.WARN)
      end
      
      require("telekasten").setup(opts)
      -- Telescope extension for media files
      pcall(require("telescope").load_extension, "media_files")
    end,
  },
}
