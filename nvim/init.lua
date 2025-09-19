-- Profile-aware loader for modular Neovim config
-- Profiles live in lua/profiles/*.lua and can override/extend base
-- Select profile with NVIM_PROFILE env var or file ~/.config/nvim/profile

local function read_first_line(path)
  local f = io.open(path, 'r')
  if not f then return nil end
  local line = f:read('*l')
  f:close()
  return line
end

local function detect_profile()
  local env_profile = vim.env.NVIM_PROFILE
  if env_profile and #env_profile > 0 then
    return env_profile
  end
  local home = vim.loop.os_homedir()
  local marker = home .. "/.config/nvim/profile"
  local line = read_first_line(marker)
  if line and #line > 0 then
    return line
  end
  return "general"
end

local profile = detect_profile()
vim.g.nvim_profile = profile

-- Core bootstrap (options, keymaps, lazy.nvim)
require('core.options')
require('core.keymaps')
require('core.lazy')

-- Load profile last for overrides
local ok, err = pcall(function()
  require('profiles.' .. profile)
end)
if not ok then
  vim.schedule(function()
    vim.notify("Profile '" .. profile .. "' failed to load: " .. tostring(err), vim.log.levels.WARN)
  end)
end
