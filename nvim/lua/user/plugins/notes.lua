local profile = require("user.utils.profile")

return {
  -- Telekasten setup only if in notes profile
  {
    "renerocksai/telekasten.nvim",
    cond = function()
      return profile.is_notes()
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "renerocksai/calendar-vim",
      "nvim-telescope/telescope-media-files.nvim",
    },
    opts = function()
      -- Use vim.fn.expand() for better portability and Neovim integration
      local env_home = vim.env.TELEKASTEN_HOME or vim.env.ZK_HOME
      local home = env_home and vim.fn.expand(env_home) or vim.fn.expand("~/.zk")
      local templates_path = home .. "/templates"

      return {
        home = home,
        dailies = home .. "/daily",
        weeklies = home .. "/weekly",
        monthlies = home .. "/monthly",
        zettels = home .. "/zettels",
        templates = templates_path,
        template_new_note = templates_path .. "/zettel.md",
        template_new_daily = templates_path .. "/daily.md",
        template_new_weekly = templates_path .. "/weekly.md",
        plug_into_calendar = true,
        media_previewer = "viu-previewer",
        media_extensions = { "png", "jpg", "jpeg", "gif", "webp" },
        -- Simple filenames: use the title as filename
        new_note_filename = "title",
        -- Still generate a UUID (datetime) for templates/frontmatter
        uuid_type = "%Y%m%d%H%M%S",
        uuid_sep = "-",
        -- Keep spaces in filenames; set to "-" if you prefer hyphens
        filename_space_subst = nil,
        -- Keep links clean (no subdir prefixes in [[links]])
        subdirs_in_links = false,
        follow_creates_nonexisting = true,
      }
    end,
    config = function(_, opts)
      -- Ensure templates and content directories exist (should be set up by setup script)
      local templates_dir = opts.templates
      if vim.fn.isdirectory(templates_dir) == 0 then
        vim.fn.mkdir(templates_dir, "p")
        vim.notify(
          "Telekasten templates directory created: "
            .. templates_dir
            .. " (run setup script to install templates)",
          vim.log.levels.WARN
        )
      end
      if opts.zettels and vim.fn.isdirectory(opts.zettels) == 0 then
        vim.fn.mkdir(opts.zettels, "p")
      end

      local tk = require("telekasten")
      tk.setup(opts)

      -- Telekasten highlight groups (reapply on colorscheme change)
      local function apply_tk_highlights()
        local set = vim.api.nvim_set_hl
        set(0, "tkLink",        { fg = "#4ea4ff", bold = true, underline = true })
        set(0, "tkAliasedLink", { fg = "#a0a0a0" })
        set(0, "tkBrackets",    { fg = "#888888" })
        set(0, "tkTag",         { fg = "#c0a000", bold = true })
        set(0, "tkHighlight",   { bg = "#333333", bold = true })
        -- Optional: calendar navigation button
        pcall(set, 0, "CalNavi", { fg = "#4ea4ff", bold = true })
      end
      apply_tk_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("TelekastenHighlights", { clear = true }),
        callback = apply_tk_highlights,
        desc = "Reapply Telekasten highlight overrides",
      })
      -- Auto-insert quarter progress for new monthly notes
      local monthly_pattern = opts.monthlies .. "/*.md"
      vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = monthly_pattern,
        callback = function()
          -- Only add if not present yet
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          local exists = false
          for _, l in ipairs(lines) do
            if l:match("^## Quarter Progress") then
              exists = true
              break
            end
          end
          if exists then
            return
          end
          local m = tonumber(os.date("%m"))
          local q = math.floor((m - 1) / 3) + 1
          local month_in_q = ((m - 1) % 3) + 1 -- 1..3
          local bar = string.rep("#", month_in_q) .. string.rep("-", 3 - month_in_q)
          local block = {
            "",
            "## Quarter Progress",
            string.format("Quarter: Q%d (month %d of 3)", q, month_in_q),
            string.format("[%s]", bar),
            "",
          }
          vim.api.nvim_buf_set_lines(0, #lines, #lines, false, block)
        end,
      })
      -- Telescope extension for media files
      pcall(require("telescope").load_extension, "media_files")
    end,
  },
}
