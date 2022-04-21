vim.cmd [[
  source ~/.config/nvim/vim/settings.vim
  source ~/.config/nvim/vim/mappings.vim
  source ~/.config/nvim/vim/functions.vim
  source ~/.config/nvim/vim/autocmds.vim
]]

require "plugins"
require "language-servers"
require "linters-fmt"
require "completions"

function file_exists(name)
  local file = io.open(name, "r")
  return file ~= nil and io.close(file)
end

function source_lua(name)
  local path = os.getenv("HOME") .. "/.config/nvim/lua/" .. name .. ".lua"
  if file_exists(path) then
    require(name)
  end
end

function source_vim(name)
  local path = os.getenv("HOME") .. "/.config/nvim/vim/" .. name .. ".vim"
  if file_exists(path) then
    vim.cmd("source " .. path)
  end
end

source_lua "local"
source_vim "local"
