local lspconfig = require "lspconfig"

-- rust-analyzer is configured separately.
local servers = {
  "ansiblels", -- Includes "ansible-lint".
  "bashls",    -- Includes "ShellCheck".
  "gopls",
  "hls",
  "pyright",
  "yamlls",
}

-- Using global variable to allow for usage in 'local.lua' file.
lsp_on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", {})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", {})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K",  "<Cmd>lua vim.lsp.buf.hover()<CR>", {})

  local group = vim.api.nvim_create_augroup("LspFormatting", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format()
    end,
  })
end

lspconfig["rust_analyzer"].setup {
  on_attach = lsp_on_attach,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy"
      },
    }
  },
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = lsp_on_attach,
  }
end
