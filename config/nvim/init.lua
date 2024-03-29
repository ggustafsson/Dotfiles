if vim.g.vscode then
  return
end

vim.cmd [[
  source ~/.config/nvim/vim/autocmds.vim
  source ~/.config/nvim/vim/functions.vim
  source ~/.config/nvim/vim/mappings.vim
  source ~/.config/nvim/vim/settings.vim
]]

require "completions"
require "functions"
require "languages"
require "lint-format"
require "plugins"

local local_lua = "~/.config/nvim/lua/local.lua"
if file_exists(local_lua) then
  require "local"
end

local local_vim = "~/.config/nvim/vim/local.vim"
if file_exists(local_vim) then
  vim.cmd("source " .. local_vim)
end
