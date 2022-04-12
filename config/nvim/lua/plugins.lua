require("Comment").setup {
  toggler = {
    line  = "gcc",
    block = "gCC",
  },
  opleader = {
    line  = "gc",
    block = "gC",
  },
}

require("nvim-treesitter.configs").setup {
  ensure_installed = "all",

  highlight = {
    enable = true,
    disable = {
      "vim",
      "yaml",
    },
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
}
