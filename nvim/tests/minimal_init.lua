-- Minimal init for running plenary tests in CI/local
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Add repo root and plenary to runtimepath
vim.opt.rtp:append(".")
-- Vendor plenary for tests from local cache (CI clones here)
vim.opt.rtp:append(".tests/site/pack/vendor/start/plenary.nvim")

-- Load plenary's busted test harness
require("plenary.busted")

-- Load core modules for testing
require("user.core.options")
require("user.core.keymaps")

-- Mock lazy.nvim for testing
if not package.loaded["lazy"] then
  package.loaded["lazy"] = {
    setup = function() end,
    plugins = function() return {} end,
  }
end

-- Mock common plugins for testing
local function mock_plugin(name)
  if not package.loaded[name] then
    package.loaded[name] = {
      setup = function() end,
      load_extension = function() end,
    }
  end
end

-- Mock plugins that might be missing
mock_plugin("telescope")
mock_plugin("none-ls")
mock_plugin("telekasten")

-- Don't let vendor tests under tests/ run by accident
vim.g._tests_vendor_disabled = true
