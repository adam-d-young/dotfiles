describe("core keymaps", function()
  it("defines <leader>w to write", function()
    local keys = vim.api.nvim_get_keymap("n")
    local found = false
    for _, k in ipairs(keys) do
      if k.lhs == "<leader>w" then found = true break end
    end
    assert.is_true(found)
  end)

  it("defines <leader>e for explorer", function()
    local keys = vim.api.nvim_get_keymap("n")
    local found = false
    for _, k in ipairs(keys) do
      if k.lhs == "<leader>e" then found = true break end
    end
    assert.is_true(found)
  end)

  it("defines <leader>mp for glow preview", function()
    local keys = vim.api.nvim_get_keymap("n")
    local found = false
    for _, k in ipairs(keys) do
      if k.lhs == "<leader>mp" then found = true break end
    end
    assert.is_true(found)
  end)
end)
