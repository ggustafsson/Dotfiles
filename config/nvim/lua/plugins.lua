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
      border = "rounded"
    },
  },
  windownav = {
    next = "<C-W><C-W>",
  },
  -- XXX: Look into if <C-G> can be improved.
  mappings = {
    { "<C-E>", builtin.populate_cmdline },
    { "<C-G>", builtin.cd_to_path },
    { "<C-S>", builtin.open_in_split },
    { "<C-T>", builtin.open_in_tab },
    { "<C-V>", builtin.open_in_vsplit },
    { "<C-Y>", builtin.copy_to_clipboard },
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
