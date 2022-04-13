local cmp_nvim_lsp = require "cmp_nvim_lsp"
local lspconfig = require "lspconfig"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

-- FIXME: Uncomment "ansiblels" after merge:
-- https://github.com/Homebrew/homebrew-core/pull/99170
local servers = {
  -- "ansiblels",
  "bashls",
  "gopls",
  "pyright",
  "yamlls",
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

-- lspconfig.ansiblels.setup {}
lspconfig.bashls.setup {}
lspconfig.gopls.setup {}
lspconfig.pyright.setup {}
lspconfig.yamlls.setup {}
