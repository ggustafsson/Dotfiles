vim.g.mapleader = ","

if vim.fn.has "mac" == 1 then
  vim.keymap.set("n", "<Leader>fi", ":silent !open \"%:p:h\"<CR>")
  vim.keymap.set("n", "<Leader>no", ":edit ~/Documents/Text/Brain/<C-R>=strftime(\"%Y%m%d\")<CR>_.md<Left><Left><Left>")
  vim.keymap.set("n", "<Leader>op", ":silent !open \"%\"<CR>")
  vim.keymap.set("n", "<Leader>vs", ":silent !open -a \"Visual Studio Code\" \"%\"<CR>")
  vim.keymap.set("n", "<Leader>ya", ":silent w !yank<CR>")
end

vim.keymap.set("n", "<Leader>/",  ":FzfHistory/<CR>")
vim.keymap.set("n", "<Leader>:",  ":FzfHistory:<CR>")
vim.keymap.set("n", "<Leader>bd", ":bdelete<CR>")
vim.keymap.set("n", "<Leader>bu", ":FzfBuffers<CR>")
vim.keymap.set("n", "<Leader>cc", ":call ColorColumn()<CR>")
vim.keymap.set("n", "<Leader>cd", ":tcd <C-R>=getcwd()<CR>/")
vim.keymap.set("n", "<Leader>do", ":FzfFiles ~/Documents/Text<CR>")
vim.keymap.set("n", "<Leader>ed", ":edit <C-R>=fnameescape(expand(\"%:p:h\"))<CR>/")
vim.keymap.set("n", "<Leader>eh", ":edit ~/")
vim.keymap.set("n", "<Leader>et", ":edit ~/Documents/Text/")
vim.keymap.set("n", "<Leader>fd", ":FzfFiles<CR>")
vim.keymap.set("n", "<Leader>fh", ":FzfFiles ~/")
vim.keymap.set("n", "<Leader>ft", ":FzfFiletypes<CR>")
vim.keymap.set("n", "<Leader>he", ":FzfHelptags<CR>")
vim.keymap.set("n", "<Leader>hi", ":FzfHistory<CR>")
vim.keymap.set("n", "<Leader>li", ":setlocal list! list?<CR>")
vim.keymap.set("n", "<Leader>ll", ":call ClearLocList()<CR>")
vim.keymap.set("n", "<Leader>ma", ":FzfMarks<CR>")
vim.keymap.set("n", "<Leader>nu", ":setlocal number! relativenumber!<CR>")
vim.keymap.set("n", "<Leader>rg", ":FzfRg<Space>")
vim.keymap.set("n", "<Leader>rs", ":source ~/.local/share/nvim/session.vim<CR>")
vim.keymap.set("n", "<Leader>s2", ":setlocal expandtab shiftwidth=2 softtabstop=2<CR>")
vim.keymap.set("n", "<Leader>s4", ":setlocal expandtab shiftwidth=4 softtabstop=4<CR>")
vim.keymap.set("n", "<Leader>se", ":FzfLines<CR>")
vim.keymap.set("n", "<Leader>sp", ":setlocal spell! spell?<CR>")
vim.keymap.set("n", "<Leader>ss", ":mksession! ~/.local/share/nvim/session.vim<CR>")
vim.keymap.set("n", "<Leader>t2", ":setlocal noexpandtab shiftwidth=2 softtabstop=0 tabstop=2<CR>")
vim.keymap.set("n", "<Leader>t4", ":setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4<CR>")
vim.keymap.set("n", "<Leader>t8", ":setlocal noexpandtab shiftwidth=8 softtabstop=0 tabstop=8<CR>")
vim.keymap.set("n", "<Leader>te", ":Template ~/.config/nvim/templates/")
vim.keymap.set("n", "<Leader>ts", ":call TSToggle()<CR>")
vim.keymap.set("n", "<Leader>tw", ":setlocal textwidth=79")
vim.keymap.set("n", "<Leader>un", ":undo!<CR>")
vim.keymap.set("n", "<Leader>wi", ":FzfWindows<CR>")
vim.keymap.set("n", "<Leader>wr", ":setlocal wrap! wrap?<CR>")
vim.keymap.set("n", "<Leader>ws", "ml:%s/\\s\\+$//e | nohlsearch<CR>`l")
vim.keymap.set("n", "<Leader>xx", ":FzfRg \\b(FIXME|NOTE|TODO|XXX)(:|$| )<CR>")

-- sed turns two spaces delimiter into one space.
vim.keymap.set("n", "<Leader>cl", ":%!column -t | sed 's/\\( *\\) /\\1/g'<CR>")
vim.keymap.set("v", "<Leader>cl", ":!column -t | sed 's/\\( *\\) /\\1/g'<CR>")

vim.keymap.set("n", "<Leader>ne", ":enew<CR>")
vim.keymap.set("v", "<Leader>ne", "y:enew<CR>PGdd")

vim.keymap.set("n", "<Leader>re", ":%s++gc<Left><Left><Left>")
vim.keymap.set("v", "<Leader>re", ":s+\\%V+gc<Left><Left><Left>")

vim.keymap.set("n", "<Leader>so", ":sort<CR>")
vim.keymap.set("v", "<Leader>so", ":sort<CR>")

vim.keymap.set("n", "<Leader>ti", ":.!title<CR>")
vim.keymap.set("v", "<Leader>ti", ":!title<CR>")

-- Like 'p' and 'P' but last yanked instead of last deleted.
vim.keymap.set("n", "<Leader>P", '"0P')
vim.keymap.set("n", "<Leader>p", '"0p')

-- Like 'y', 'yy' and 'Y' but use system clipboard.
vim.keymap.set("n", "<Leader>Y", '"*y$')
vim.keymap.set("n", "<Leader>yy", '"*yy')
vim.keymap.set("v", "<Leader>y", '"*y')

-- Display full path to current file.
vim.keymap.set("n", "<C-G>", "1<C-G>")

vim.keymap.set("n", "<C-W>C", "<Cmd>tabclose<CR>")
vim.keymap.set("n", "<C-W>t", "<Cmd>tabnew<CR>")

-- Disable to avoid unintended triggering.
vim.keymap.set("n", "Q", "<Nop>")

-- These key combos are unused and similar to 'gt' and 'gT' for tabs.
vim.keymap.set("n", "gb", "<Cmd>bnext<CR>")
vim.keymap.set("n", "gB", "<Cmd>bprevious<CR>")
vim.keymap.set("n", "gl", "GoToLoc next")
vim.keymap.set("n", "gL", "GoToLoc prev")

-- Mark relative jumps with 'j' and 'k' so CTRL-I and CTRL-O works.
vim.keymap.set("n", "j", function()
  return (vim.v.count > 1 and ("m'" .. vim.v.count) or "") .. "j"
end, { expr = true })

vim.keymap.set("n", "k", function()
  return (vim.v.count > 1 and ("m'" .. vim.v.count) or "") .. "k"
end, { expr = true })

-- Default binding with nohlsearch added.
vim.keymap.set("v", "<C-L>", "<Esc><Cmd>nohlsearch<Bar>diffupdate<CR><C-L>")

vim.keymap.set("i", "<C-X><C-F>", "<Plug>(fzf-complete-path)")
vim.keymap.set("i", "<C-X><C-K>", "<Plug>(fzf-complete-word)")
vim.keymap.set("i", "<C-X><C-L>", "<Plug>(fzf-complete-line)")

-- Text object consisting of all text inside current line, first character up
-- until last character. Like 'w' (word), 'p' (paragraph), etc.
vim.keymap.set("x", "il", "^og_")
vim.keymap.set("o", "il", "<Cmd>normal vil<CR>")

-- Make Nvim behave like everything else. Ctrl-E, Ctrl-U, etc already works.
vim.keymap.set("c", "<C-A>", "<Home>")
