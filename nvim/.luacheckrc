std = "luajit"
globals = {
  vim = {
    fields = {
      g = { read_only = false, other_fields = true },
      opt = { read_only = false, other_fields = true },
      env = { read_only = false, other_fields = true },
    },
  },
}
ignore = {
  "631", -- line is too long
}
