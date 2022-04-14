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

vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_show_icons = '{"git": 0, "folders": 0, "files": 0, "folder_arrows": 0}'
vim.g.nvim_tree_symlink_arrow = " -> "
require("nvim-tree").setup {
  view = {
    width = 35,
    number = true,
    relativenumber = true,
    signcolumn = "no",
  },
  filters = {
    dotfiles = true,
  },
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

  highlight = {
    enable = true,
     disable = {
       "yaml",
     },
  },

  matchup = {
    enable = true,
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
