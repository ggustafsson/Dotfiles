local null_ls = require "null-ls"

local sources = {
  null_ls.builtins.diagnostics.ansiblelint,
  null_ls.builtins.diagnostics.flake8,
  null_ls.builtins.diagnostics.pylint,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.diagnostics.staticcheck
  null_ls.builtins.diagnostics.tidy,
  null_ls.builtins.diagnostics.yamllint,
  null_ls.builtins.diagnostics.zsh,

  null_ls.builtins.formatting.autopep8,
  null_ls.builtins.formatting.goimports,
  null_ls.builtins.formatting.terraform_fmt,
  null_ls.builtins.formatting.tidy,
}

null_ls.setup {
  sources = sources,

  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd [[
        augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]]
    end
  end,
}
