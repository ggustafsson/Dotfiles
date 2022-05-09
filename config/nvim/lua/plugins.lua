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

local builtin = require("nnn").builtin
require("nnn").setup {
  explorer = {
    width = 28,
  },
  mappings = {
    { "<C-E>", builtin.populate_cmdline },
    { "<C-S>", builtin.open_in_split },
    { "<C-T>", builtin.open_in_tab },
    { "<C-V>", builtin.open_in_vsplit },
    { "<C-Y>", builtin.copy_to_clipboard },

    -- XXX: Look into using the nnn <C-G> function instead.
    -- { "<C-W>", builtin.cd_to_path },
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
