local lspconfig = require "lspconfig"

local servers = {
  "ansiblels", -- Includes "ansible-lint".
  "bashls",    -- Includes "ShellCheck".
  "gopls",
  "hls",
  "pyright",
  "rust_analyzer",
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

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = lsp_on_attach,
  }
end
