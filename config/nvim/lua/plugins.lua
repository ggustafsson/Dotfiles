require("ansible").setup()

require("comment").setup {
  opleader = {
    line  = "gc",
    block = "gC",
  },
  toggler = {
    line  = "gcc",
    block = "gCC",
  },
}

require("gitsigns").setup({
  signs = {
    add    = { text = "+" },
    change = { text = "+" },
  },
  signs_staged = {
    add    = { text = "+" },
    change = { text = "+" },
  },
})

require("nnn-dir").setup()

require("nvim-treesitter").install({
  "bash",
  "css",
  "go",
  "html",
  "javascript",
  "jinja",
  "json",
  "lua",
  "python",
  "ruby",
  "rust",
  "yaml",
  "zsh",
})

require("nvim-ts-autotag").setup()
