std = "luajit"
globals = {
  vim = {
    other_fields = true,
    fields = {
      g = { read_only = false, other_fields = true },
      opt = { read_only = false, other_fields = true },
      env = { read_only = false, other_fields = true },
      keymap = { other_fields = true },
      fn = { other_fields = true },
      api = { other_fields = true },
      loop = { other_fields = true },
      cmd = { other_fields = true },
      notify = { other_fields = true },
      log = { other_fields = true, fields = { levels = { other_fields = true } } },
      lsp = { other_fields = true, fields = { protocol = { other_fields = true } } },
    },
  },
}
ignore = {
  "631", -- line is too long
}
