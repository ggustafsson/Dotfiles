if vim.g.vscode then
  return
end

vim.cmd([[
  source ~/.config/nvim/vim/functions.vim
  source ~/.config/nvim/vim/mappings.vim
]])

require("autocmds")
require("completions")
require("functions")
require("languages")
require("linters")
require("plugins")
require("settings")

if file_exists("~/.config/nvim/lua/local.lua") then
  require("local")
end
