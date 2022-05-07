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

vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_show_icons = { files = 0, folders = 0, folder_arrows = 0, git = 0 }
vim.g.nvim_tree_symlink_arrow = " -> "
require("nvim-tree").setup {
  view = {
    number = true,
    relativenumber = true,
    signcolumn = "no",
    width = 35,
  },
  filters = {
    dotfiles = true,
  },
  git = {
    ignore = false,
  },
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
