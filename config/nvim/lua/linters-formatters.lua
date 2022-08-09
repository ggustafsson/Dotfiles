local null_ls = require "null-ls"

local sources = {
  null_ls.builtins.diagnostics.flake8,
  null_ls.builtins.diagnostics.pylint,
  null_ls.builtins.diagnostics.staticcheck,
  null_ls.builtins.diagnostics.tidy,
  null_ls.builtins.diagnostics.yamllint,
  null_ls.builtins.diagnostics.zsh,

  null_ls.builtins.formatting.goimports,
  null_ls.builtins.formatting.rustfmt,
}

null_ls.setup {
  sources = sources,

  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      local group = vim.api.nvim_create_augroup("LspFormatting", {})
      vim.api.nvim_create_autocmd("BufWritePre <buffer>", {
        command = "lua vim.lsp.buf.formatting_sync()",
        group = group,
      })
    end
  end,
}
