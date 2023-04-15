require("nnn-dir").setup()

require("Comment").setup {
  opleader = {
    line  = "gc",
    block = "gC",
  },
  toggler = {
    line  = "gcc",
    block = "gCC",
  },
}

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "css",
    "go",
    "html",
    "json",
    "lua",
    "python",
    "ruby",
    "rust",
    "yaml",
  },

  autotag = {
    enable = true,
    filetypes = {
      "html",
    },
  },

  highlight = {
    enable = true,
    disable = {
      "yaml",
    },
  },
}
