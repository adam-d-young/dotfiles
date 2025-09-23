-- Extended UX plugins: markdown preview, citations, symbols, frecency
return {
  -- Markdown preview with Glow CLI
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    ft = { "markdown" },
    opts = {
      style = "dark",
      width = 120,
      border = "rounded",
    },
  },

  -- Telescope extensions
  {
    "nvim-telescope/telescope-bibtex.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      pcall(require("telescope").load_extension, "bibtex")
    end,
  },
  {
    "nvim-telescope/telescope-symbols.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "kkharji/sqlite.lua" },
    config = function()
      pcall(require("telescope").load_extension, "frecency")
    end,
  },

  -- Ripgrep-powered search extensions
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      pcall(require("telescope").load_extension, "live_grep_args")
    end,
  },
}
