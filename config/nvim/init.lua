if vim.g.vscode then
  return
end

vim.cmd("source ~/.config/nvim/vim/functions.vim")

require("autocmds")
require("completions")
require("functions")
require("languages")
require("linters")
require("mappings")
require("plugins")
require("settings")

if file_exists("~/.config/nvim/lua/local.lua") then
  require("local")
end
