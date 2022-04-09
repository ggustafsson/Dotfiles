require("cmp").setup {
  sources = {
    { name = "buffer" },
    { name = "nvim_lsp" },
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
}
