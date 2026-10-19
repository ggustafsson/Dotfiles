if not vim.g.dont_run_again_if_we_have_already_bought_chicken_nuggets then
  vim.cmd.colorscheme "16x256"

  vim.g.dont_run_again_if_we_have_already_bought_chicken_nuggets = 1
end

vim.o.completeopt = "menu,menuone,noselect"
vim.o.confirm = true
vim.o.foldenable = false
vim.o.guicursor = ""
vim.o.inccommand = ""
vim.o.list = true
vim.o.spelllang = "en,sv"
vim.o.tabline = "%!v:lua.TabLine()"
vim.o.textwidth = 79
vim.o.wrap = false

vim.o.backup = true
vim.o.backupdir = vim.fn.expand("~/.local/share/nvim/backup")
vim.o.undofile = true

vim.o.cursorline = true
vim.o.cursorlineopt = "number"

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- See ':help fo-table' for explanation.
vim.opt.formatoptions:remove("t")
vim.opt.formatoptions:append("lnor")

-- ~/.vimrc [+] [dos] [latin1] [vim]        142,47    30%
vim.o.statusline = table.concat {
  " %(%f %)",
  "%(%m %)",
  "%([%{&fileformat=='unix'?'':&fileformat}] %)",
  "%([%{&fileencoding=='utf-8'?'':&fileencoding}] %)",
  "%(%y %)",
  "%=",
  "%-12.( %l,%v %)", -- 99999,999 would still have two spaces.
  "%(%P %)",
}

vim.o.number = true
vim.o.relativenumber = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.wildignorecase = true
vim.o.wildmode = "longest,list"

vim.g.markdown_folding = 1

vim.g.fzf_action = { ["ctrl-s"] = "split", ["ctrl-v"] = "vsplit", ["ctrl-t"] = "tab split" }
vim.g.fzf_colors = { border = { "fg", "VertSplit" } }
vim.g.fzf_command_prefix = "Fzf"
vim.g.fzf_layout = { window = { height = 0.8, width = 1 } }
