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
      height = 0.8,
      width = 0.8,
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
}
