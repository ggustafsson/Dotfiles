local servers = {
  -- Includes "ansible-lint".
  ansiblels = {
    on_attach = lsp_on_attach,
  },

  -- Includes "ShellCheck".
  bashls = {
    on_attach = lsp_on_attach,
  },

  gopls = {
    on_attach = lsp_on_attach,
    settings = {
      gopls = {
        staticcheck = true,
      },
    },
  },

  -- Also known as "lua-language-server".
  lua_ls = {
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
  },

  pyright = {
    on_attach = lsp_on_attach,
  },

  rust_analyzer = {
    on_attach = lsp_on_attach,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },

  yamlls = {
    on_attach = lsp_on_attach,
  },
}

-- Using global variable to allow for usage in 'local.lua' file.
lsp_on_attach = function(_, bufnr)
  vim.api.nvim_set_option_value("formatexpr", "", { buf = bufnr })
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

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

for server, options in pairs(servers) do
  vim.lsp.config(server, options)
  vim.lsp.enable(server)
end
