require("cmp").setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

require("comment").setup({
  toggler = {
    line  = "gcc",
    block = "gCC",
  },
  opleader = {
    line  = "gc",
    block = "gC",
  },
})

require("gitsigns").setup()

require("nvim-treesitter.configs").setup({
  ensure_installed = "maintained",

  highlight = {
    enable = true,
    disable = { "vim" },
  },

  textobjects = {
    select = {
      enable = true,

      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})

require("trouble").setup({
  icons = false,
  indent_lines = false,

  fold_open = "v",
  fold_closed = ">",

  signs = {
    error = "error",
    warning = "warn",
    hint = "hint",
    information = "info",
  },
  use_diagnostic_signs = false,
})
