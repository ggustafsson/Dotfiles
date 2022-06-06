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

local builtin = require("nnn").builtin
require("nnn").setup {
  explorer = {
    width = 28,
  },
  picker = {
    style = {
      height = 1,
      width = 1,
      border = "rounded",
    },
  },
  windownav = {
    next = "<C-W><C-W>",
  },
  mappings = {
    { "<C-S>", builtin.open_in_split },
    { "<C-T>", builtin.open_in_tab },
    { "<C-V>", builtin.open_in_vsplit },
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
