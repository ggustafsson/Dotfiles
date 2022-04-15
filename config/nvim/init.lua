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
  -- XXX: Decide on dofile() or require()...
  -- if file_exists(name) then
  --   dofile(name)
  -- end
  file = "lua/" .. name .. ".lua"
  if file_exists(file) then
    require(name)
  end
end

-- source_config "lua/local.lua"
source_config "local"
