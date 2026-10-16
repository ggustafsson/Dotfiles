local null_ls = require "null-ls"

local sources = {
  require("none-ls.diagnostics.flake8"), -- Part of none-ls-extras.nvim

  null_ls.builtins.diagnostics.pylint,
  null_ls.builtins.diagnostics.tidy,
  null_ls.builtins.diagnostics.yamllint,
  null_ls.builtins.diagnostics.zsh,

  null_ls.builtins.formatting.goimports,
}

null_ls.setup {
  sources = sources,
}

local group = vim.api.nvim_create_augroup("NullLsFormatting", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = {
    "*.go",
  },
  callback = function()
    vim.lsp.buf.format()
  end,
})
