if vim.g.vscode then
  return
end

require("settings")

require("autocmds")
require("completions")
require("functions")
require("languages")
require("linters")
require("mappings")
require("plugins")

if file_exists("~/.config/nvim/lua/local.lua") then
  require("local")
end
