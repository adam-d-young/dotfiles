-- Utilities to determine active profile based on NVIM_APPNAME or NVIM_PROFILE
local M = {}

local function get_env(name, default_value)
  local value = vim.env[name]
  if value == nil or value == "" then
    return default_value
  end
  return value
end

function M.get_appname()
  return get_env("NVIM_APPNAME", "nvim")
end

function M.get_profile()
  -- Priority: explicit NVIM_PROFILE, then NVIM_APPNAME heuristic, else "dev"
  local explicit = get_env("NVIM_PROFILE", nil)
  if explicit then
    return explicit
  end
  local app = M.get_appname()
  if app == "nvim-notes" then
    return "notes"
  elseif app == "nvim-dev" then
    return "dev"
  end
  return "dev"
end

function M.is_notes()
  return M.get_profile() == "notes"
end

function M.is_dev()
  return M.get_profile() == "dev"
end

return M
