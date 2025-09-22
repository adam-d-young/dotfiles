-- Native LSP configuration using vim.lsp.start()
local M = {}

function M.setup()
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
  local marksman_path = "/opt/homebrew/bin/marksman"
  if vim.fn.executable(marksman_path) == 1 then
    setup_lsp_server("marksman", { marksman_path, "server" })
  elseif vim.fn.executable("marksman") == 1 then
    setup_lsp_server("marksman", { "marksman", "server" })
  else
    vim.notify(
      "Marksman LSP not found. Install with: brew install marksman",
      vim.log.levels.WARN
    )
  end
end

return M
