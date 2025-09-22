local function read_file(path)
  local fd = assert(io.open(path, "r"))
  local content = fd:read("*a")
  fd:close()
  return content
end

local function has_yaml_frontmatter(s)
  -- naive check: starts with --- and contains closing ---
  return s:match("^%-%-%-\n") ~= nil and s:match("\n%-%-%-\n") ~= nil
end

describe("templates", function()
  local templates = {
    "templates/zettel.md",
    "templates/daily.md",
    "templates/weekly.md",
    "templates/monthly.md",
    "templates/quarterly.md",
    "templates/yearly.md",
  }

  it("all template files exist", function()
    for _, path in ipairs(templates) do
      local ok = vim.loop.fs_stat(path)
      assert.is_truthy(ok, path .. " should exist")
    end
  end)

  it("each template begins with YAML frontmatter", function()
    for _, path in ipairs(templates) do
      local content = read_file(path)
      assert.is_true(has_yaml_frontmatter(content), path .. " must have YAML frontmatter")
    end
  end)
end)
