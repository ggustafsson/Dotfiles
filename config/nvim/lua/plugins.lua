require("cmp").setup {
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
}

require("comment").setup {
  toggler = {
    line = "gcc",
    block = "gCC",
  },
  opleader = {
    line = "gc",
    block = "gC",
  },
}

require("gitsigns").setup()

require("nvim-treesitter.configs").setup {
  ensure_installed = "maintained",

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,

      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
