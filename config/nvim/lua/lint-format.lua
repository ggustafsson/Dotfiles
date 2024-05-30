local null_ls = require "null-ls"

local sources = {
  require("none-ls.diagnostics.flake8"),

  null_ls.builtins.diagnostics.pylint,
  null_ls.builtins.diagnostics.tidy,
  null_ls.builtins.diagnostics.yamllint,
  null_ls.builtins.diagnostics.zsh,

  null_ls.builtins.formatting.goimports,
}

null_ls.setup {
  sources = sources,
}
