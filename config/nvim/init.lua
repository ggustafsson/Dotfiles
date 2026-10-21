if vim.g.vscode then
  return
end

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
