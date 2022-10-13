local null_ls = require "null-ls"

local sources = {
  null_ls.builtins.diagnostics.flake8,
  null_ls.builtins.diagnostics.pylint,
  null_ls.builtins.diagnostics.tidy,
  null_ls.builtins.diagnostics.yamllint,
  null_ls.builtins.diagnostics.zsh,

  null_ls.builtins.formatting.goimports,
}

null_ls.setup {
  sources = sources,

  on_attach = function(client, bufnr)
    -- XXX: https://github.com/neovim/neovim/pull/19677
    vim.bo.formatexpr = ""

    local group = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end,
}
