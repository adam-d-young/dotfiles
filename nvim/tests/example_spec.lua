local eq = assert.are.equal

describe("profile utils", function()
  it("detects dev by default", function()
    package.loaded["user.utils.profile"] = nil
    local profile = require("user.utils.profile")
    eq("dev", profile.get_profile())
  end)
end)
