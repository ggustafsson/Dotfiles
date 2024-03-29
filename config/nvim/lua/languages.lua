local lspconfig = require "lspconfig"

local servers = {
  "ansiblels", -- Includes "ansible-lint".
  "bashls",    -- Includes "ShellCheck".
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

lspconfig["gopls"].setup {
  on_attach = lsp_on_attach,
  settings = {
    gopls = {
      staticcheck = true,
    },
  },
}

lspconfig["rust_analyzer"].setup {
  on_attach = lsp_on_attach,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

-- Also known as "lua-language-server".
lspconfig["lua_ls"].setup {
  on_attach = lsp_on_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      diagnostics = {
        disable = {
          "lowercase-global",
          "redefined-local",
        },
        globals = {
          "hs", -- Hammerspoon.
          "vim",
        },
      },
      format = {
        enable = false,
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
