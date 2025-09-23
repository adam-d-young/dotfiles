return {
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "moon", transparent = false },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- UI niceties
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { options = { theme = "auto" } },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {},
  },

  -- Telescope and dependencies
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-telescope/telescope.nvim", version = "0.1.*", cmd = "Telescope" },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable("make") == 1,
  },

  -- Diagnostics list
  { "folke/trouble.nvim", cmd = { "Trouble" }, opts = {} },

  -- Git signs
  { "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },

  -- Better commenting
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },

  -- Indentation guides
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", event = "VeryLazy", opts = {} },

  -- Which key
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },

  -- List management and bullet points
  {
    "dkarter/bullets.vim",
    ft = { "markdown", "text", "gitcommit", "scratch" },
    config = function()
      vim.g.bullets_enabled_file_types = {
        "markdown",
        "text", 
        "gitcommit",
        "scratch",
      }
      vim.g.bullets_auto_indent_after_colon = 1
      vim.g.bullets_renumber_on_change = 1
      vim.g.bullets_delete_last_bullet_if_empty = 1
    end,
  },

  -- Snippets for template injection
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    event = "VeryLazy",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      
      -- Custom snippets for markdown/telekasten
      luasnip.add_snippets("markdown", {
        luasnip.snippet("meeting", {
          luasnip.text_node({
            "## 📝 Meeting Notes",
            "",
            "**With**: ",
            "",
            "### 📝 Notes",
            "- ",
            "",
            "### ✅ Action Items",
            "- [ ] ",
            "",
          }),
        }),
      })
    end,
  },
}
