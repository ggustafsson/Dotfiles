require("cmp").setup({
  -- Order of sources sets priority.
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

require("Comment").setup({
  toggler = {
    line  = "gcc",
    block = "gCC",
  },
  opleader = {
    line  = "gc",
    block = "gC",
  },
})

require("nvim-treesitter.configs").setup({
  ensure_installed = "all",

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
