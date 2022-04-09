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

require("nvim-tree").setup()

require("nvim-treesitter.configs").setup({
  ensure_installed = "maintained",

  highlight = {
    enable = true,
    disable = { "vim" },
    additional_vim_regex_highlighting = false,
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
