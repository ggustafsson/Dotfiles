vim.cmd "source ~/.config/nvim/vim/settings.vim"
vim.cmd "source ~/.config/nvim/vim/mappings.vim"
vim.cmd "source ~/.config/nvim/vim/functions.vim"
vim.cmd "source ~/.config/nvim/vim/autocmds.vim"

require "plugins"
require "language-servers"
require "linters-fmt"
require "completions"

function file_exists(name)
  local file = io.open(name, "r")
  return file ~= nil and io.close(file)
end

function source_config(name)
  path = os.getenv("HOME") .. "/.config/nvim/lua/" .. name .. ".lua"
  if file_exists(path) then
    require(name)
  end
end

source_config "local"
