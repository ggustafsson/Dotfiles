local lspconfig = require "lspconfig"

-- lua-language-server & rust-analyzer is configured later.
local servers = {
  "ansiblels", -- Includes "ansible-lint".
  "bashls",    -- Includes "ShellCheck".
  "gopls",
  "hls",
  "pyright",
  "yamlls",
}

-- Using global variable to allow for usage in 'local.lua' file.
lsp_on_attach = function(_, bufnr)
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

-- Also known as "lua-language-server".
lspconfig["sumneko_lua"].setup {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        disable = {"lowercase-global", "redefined-local"},
        globals = {"hs", "vim"},
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = lsp_on_attach,
  }
end
