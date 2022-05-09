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

require("gitsigns").setup()

require("luasnip.loaders.from_snipmate").lazy_load()

require("nnn").setup {
  explorer = {
    width = 28,
  },
  replace_netrw = "picker",
}

vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "css",
    "go",
    "html",
    "json",
    "python",
    "ruby",
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

  matchup = {
    enable = true,
  },
}
