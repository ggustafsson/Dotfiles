function autocmd(event, pattern, callback)
  vim.api.nvim_create_autocmd(event, {
    pattern = pattern,
    callback = callback,
  })
end

autocmd("TextYankPost", "*", function()
  vim.highlight.on_yank({ higroup = "Search", timeout = 200 })
end)

-- If last cursor position still exist then go to it.
autocmd("BufReadPost", "*", function(args)
  local filename = vim.api.nvim_buf_get_name(args.buf)
  if vim.wo.diff
    or filename:match("COMMIT_EDITMSG")
    or filename:match("MERGE_MSG")
  then
    return
  end

  local mark = vim.api.nvim_buf_get_mark(0, '"')
  local lines = vim.api.nvim_buf_line_count(0)
  if mark[1] > 1 and mark[1] <= lines then
    pcall(vim.api.nvim_win_set_cursor, 0, mark)
  end
end)

autocmd({ "BufRead", "BufNewFile" }, "*/{,.}gitconfig*", function()
  vim.bo.filetype = "gitconfig"
end)

autocmd({ "BufRead", "BufNewFile" }, "*/{,.}pythonrc", function()
  vim.bo.filetype = "python"
end)

autocmd({ "BufRead", "BufNewFile" }, "*/{,.}ssh/config*", function()
  vim.bo.filetype = "sshconfig"
end)

autocmd({ "BufRead", "BufNewFile" }, "*/Ansiblebot/*.yml", function()
  vim.bo.filetype = "ansible"
end)

autocmd({ "BufRead", "BufNewFile" }, "*/yamllint/config", function()
  vim.bo.filetype = "yaml"
end)

autocmd("BufNewFile", "*/Text/Brain/*", function()
  vim.cmd("Template ~/.config/nvim/templates/note.md")
end)

autocmd("BufNewFile", "*/Text/Cheats/*", function()
  vim.cmd("Template ~/.config/nvim/templates/cheat.md")
end)

-- Enable tree-sitter if filetype is supported.
autocmd("FileType", "*", function(args)
  local ft = vim.bo[args.buf].filetype
  local lang = vim.treesitter.language.get_lang(ft) or args.match
  if vim.treesitter.language.add(lang) then
    vim.treesitter.start(args.buf, lang)
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt_local.foldmethod = "expr"
  end
end)

autocmd("FileType", "gitcommit", function()
  vim.opt_local.list = false
  vim.opt_local.spell = true
end)

autocmd("FileType", { "gitconfig", "snippets" }, function()
  vim.opt_local.expandtab = false
  vim.opt_local.shiftwidth = 4
  vim.opt_local.softtabstop = 0
  vim.opt_local.tabstop = 4
end)

autocmd("FileType", "go", function(args)
  vim.b[args.buf].runprg = "go run '%'"
  vim.opt_local.expandtab = false
  vim.opt_local.listchars = { tab = "  ", trail = "-", nbsp = "+", precedes = "<", extends = ">" }
  vim.opt_local.shiftwidth = 4
  vim.opt_local.softtabstop = 0
  vim.opt_local.tabstop = 4
end)

autocmd("FileType", { "json", "python" }, function()
  vim.opt_local.expandtab = true
  vim.opt_local.shiftwidth = 4
  vim.opt_local.softtabstop = 4
end)

autocmd("FileType", "markdown", function()
  vim.opt_local.expandtab = true
  vim.opt_local.formatoptions:remove("t")
  vim.opt_local.shiftwidth = 4
  vim.opt_local.softtabstop = 4
end)

autocmd("FileType", { "markdown", "text" }, function()
  vim.opt_local.linebreak = true
end)

autocmd("FileType", "qf", function()
  vim.opt_local.relativenumber = false
  vim.opt_local.statusline = table.concat({
    " %(%q %)",
    "%(%{exists('w:quickfix_title')?''.w:quickfix_title:''} %)",
    "%=",
    "%-12.( %l/%L %)",
    " %(%P %)",
  })
end)

autocmd("FileType", "rust", function(args)
  vim.b[args.buf].runprg = "rustc -o /tmp/rustc-output '%' && /tmp/rustc-output"
end)
