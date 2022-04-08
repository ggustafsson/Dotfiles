require("cmp").setup({
  sources = {
    { name = "buffer" },
    { name = "nvim_lsp" },
    { name = "path" },
  },
})
require("cmp").setup.cmdline(":", {
  sources = {
    { name = "cmdline" },
  },
})
require("cmp").setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

require("comment").setup({
  toggler = {
    line = "gcc",
    block = "gCC",
  },
  opleader = {
    line = "gc",
    block = "gC",
  },
})

require("gitsigns").setup()
