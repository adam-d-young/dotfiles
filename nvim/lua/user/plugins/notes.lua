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
      return {
        home = home,
        dailies = home .. "/daily",
        weeklies = home .. "/weekly",
        templates = vim.fn.stdpath("config") .. "/templates",
        template_new_note = "zettel.md",
        template_new_daily = "daily.md",
        template_new_weekly = "weekly.md",
        plug_into_calendar = true,
        media_previewer = "viu-previewer",
        media_extensions = { "png", "jpg", "jpeg", "gif", "webp" },
      }
    end,
    config = function(_, opts)
      require("telekasten").setup(opts)
      -- Telescope extension for media files
      pcall(require("telescope").load_extension, "media_files")
    end,
  },
}
