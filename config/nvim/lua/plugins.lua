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

require("luasnip.loaders.from_snipmate").lazy_load()

require("nnn-dir").setup()

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
       "help",
       "yaml",
     },
  },
}
