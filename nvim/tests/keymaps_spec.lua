describe("core keymaps", function()
  it("defines <leader>w to write", function()
    local keys = vim.api.nvim_get_keymap("n")
    local found = false
    for _, k in ipairs(keys) do
      if k.lhs == " w" then  -- <leader> is space, so <leader>w becomes " w"
        found = true
        break
      end
    end
    assert.is_true(found)
  end)

  it("defines <leader>e for explorer", function()
    local keys = vim.api.nvim_get_keymap("n")
    local found = false
    for _, k in ipairs(keys) do
      if k.lhs == " e" then  -- <leader> is space, so <leader>e becomes " e"
        found = true
        break
      end
    end
    assert.is_true(found)
  end)

  it("defines <leader>mp for glow preview", function()
    local keys = vim.api.nvim_get_keymap("n")
    local found = false
    for _, k in ipairs(keys) do
      if k.lhs == " mp" then  -- <leader> is space, so <leader>mp becomes " mp"
        found = true
        break
      end
    end
    assert.is_true(found)
  end)
end)
