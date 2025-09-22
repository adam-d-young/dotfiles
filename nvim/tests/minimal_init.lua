-- Minimal init for running plenary tests in CI/local
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Add repo root and plenary to runtimepath
vim.opt.rtp:append(".")
vim.opt.rtp:append("tests/site/pack/vendor/start/plenary.nvim")

-- Load plenary's busted test harness
require("plenary.busted")

-- Load only what tests need (avoid full plugin/bootstrap for speed)
require("user.core.options")
require("user.core.keymaps")
