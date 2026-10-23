local servers = {
  -- Includes "ansible-lint".
  ansiblels = {
    filetypes = {
      "ansible",
    },
  },

  -- Includes "ShellCheck".
  bashls = {},

  gopls = {
    settings = {
      gopls = {
        staticcheck = true,
      },
    },
  },

  -- Also known as "lua-language-server".
  lua_ls = {
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

  pyright = {},

  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = true,
        check = {
          command = "clippy",
        },
      },
    },
  },

  yamlls = {},
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspConfig", {}),
  callback = function(args)
    vim.opt_local.formatexpr = ""

    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat", {}),
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
})

for server, options in pairs(servers) do
  vim.lsp.config(server, options)
  vim.lsp.enable(server)
end
