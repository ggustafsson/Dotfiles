if not vim.g.dont_run_again_if_we_already_have_chicken_nuggets then
  vim.cmd.colorscheme("16x256")

  vim.g.dont_run_again_if_we_already_have_chicken_nuggets = 1
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.confirm = true
vim.opt.foldenable = false
vim.opt.guicursor = ""
vim.opt.inccommand = ""
vim.opt.list = true
vim.opt.spelllang = { "en", "sv" }
vim.opt.tabline = "%!v:lua.tab_line()"
vim.opt.textwidth = 79
vim.opt.wrap = false

vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand("~/.local/share/nvim/backup")
vim.opt.undofile = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- See ':help fo-table' for explanation.
vim.opt.formatoptions:remove("t")
vim.opt.formatoptions:append("lnor")

-- ~/.vimrc [+] [dos] [latin1] [vim]        142,47    30%
vim.opt.statusline = table.concat({
  " %(%f %)",
  "%(%m %)",
  "%([%{&fileformat=='unix'?'':&fileformat}] %)",
  "%([%{&fileencoding=='utf-8'?'':&fileencoding}] %)",
  "%(%y %)",
  "%=",
  "%-12.( %l,%v %)", -- 99999,999 would still have two spaces.
  "%(%P %)",
})

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wildignorecase = true
vim.opt.wildmode = { "longest", "list" }

vim.g.fzf_action = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit", ["ctrl-t"] = "tab split" }
vim.g.fzf_colors = { border = { "fg", "VertSplit" } }
vim.g.fzf_command_prefix = "Fzf"
vim.g.fzf_layout = { window = { height = 0.8, width = 1 } }
