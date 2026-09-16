require('ansible').setup()

require("nnn-dir").setup()

require('nvim-treesitter').install {
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
}

require('nvim-ts-autotag').setup()
