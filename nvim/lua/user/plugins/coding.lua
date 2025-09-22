return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = { "lua", "vim", "vimdoc", "markdown", "markdown_inline" },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- LSP (using native vim.lsp.start() instead of deprecated nvim-lspconfig)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "folke/neodev.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    event = "InsertEnter",
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Store capabilities globally for use in LSP setup
      vim.g.lsp_capabilities = capabilities
    end,
  },
  {
    -- Native LSP setup using vim.lsp.start()
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = vim.g.lsp_capabilities or vim.lsp.protocol.make_client_capabilities()

      -- Setup LSP servers using native vim.lsp.start()
      local function setup_lsp_server(name, cmd, config)
        local client_config = vim.tbl_deep_extend("force", {
          capabilities = capabilities,
          on_attach = function(_, bufnr)
            -- Set up keymaps when LSP attaches
            local opts = { buffer = bufnr, silent = true }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
          end,
        }, config or {})

        vim.lsp.start({
          name = name,
          cmd = cmd,
          root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
        }, client_config)
      end

      -- Setup lua_ls
      setup_lsp_server("lua_ls", { "lua-language-server" })

      -- Setup marksman if available
      if vim.fn.executable("marksman") == 1 then
        setup_lsp_server("marksman", { "marksman", "server" })
      else
        vim.notify(
          "Marksman LSP not found. Install with: brew install marksman",
          vim.log.levels.WARN
        )
      end
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Formatting & linting via null-ls successor
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local none = require("null-ls")
      none.setup({
        sources = {
          none.builtins.formatting.stylua,
          none.builtins.diagnostics.luacheck.with({ extra_args = { "--globals", "vim" } }),
        },
      })
    end,
  },
}
