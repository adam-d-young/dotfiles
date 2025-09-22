describe("user.utils.profile", function()
  local saved_env = {}

  local function save_env()
    saved_env.NVIM_PROFILE = vim.env.NVIM_PROFILE
    saved_env.NVIM_APPNAME = vim.env.NVIM_APPNAME
  end

  local function restore_env()
    vim.env.NVIM_PROFILE = saved_env.NVIM_PROFILE
    vim.env.NVIM_APPNAME = saved_env.NVIM_APPNAME
  end

  before_each(function()
    save_env()
    vim.env.NVIM_PROFILE = nil
    vim.env.NVIM_APPNAME = nil
    package.loaded["user.utils.profile"] = nil
  end)

  after_each(function()
    restore_env()
    package.loaded["user.utils.profile"] = nil
  end)

  it("defaults to dev when no env vars set", function()
    local profile = require("user.utils.profile")
    assert.are.equal("dev", profile.get_profile())
    assert.is_true(profile.is_dev())
  end)

  it("respects NVIM_PROFILE explicitly", function()
    vim.env.NVIM_PROFILE = "notes"
    local profile = require("user.utils.profile")
    assert.are.equal("notes", profile.get_profile())
    assert.is_true(profile.is_notes())
  end)

  it("infers from NVIM_APPNAME when NVIM_PROFILE unset", function()
    vim.env.NVIM_APPNAME = "nvim-notes"
    local profile = require("user.utils.profile")
    assert.is_true(profile.is_notes())

    package.loaded["user.utils.profile"] = nil
    vim.env.NVIM_APPNAME = "nvim-dev"
    profile = require("user.utils.profile")
    assert.is_true(profile.is_dev())
  end)
end)
