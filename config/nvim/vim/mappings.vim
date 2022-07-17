let g:mapleader = ","

if has("mac")
  nnoremap <Leader>fi :silent !open %:p:h<CR>
  nnoremap <Leader>op :silent !open %<CR>
  nnoremap <Leader>vs :silent !open -a "Visual Studio Code" %<CR>
  nnoremap <Leader>ya :silent w !yank<CR>
endif

nnoremap <Leader>/  :FzfHistory/<CR>
nnoremap <Leader>:  :FzfHistory:<CR>
nnoremap <Leader>bu :FzfBuffers<CR>
nnoremap <Leader>cc :call ColorColumn()<CR>
nnoremap <Leader>cd :cd <C-R>=fnameescape(expand("%:p:h"))<CR>/
nnoremap <Leader>do :call DocsMode()<CR>
nnoremap <Leader>ed :edit <C-R>=fnameescape(expand("%:p:h"))<CR>/
nnoremap <Leader>ff :FzfFiles<CR>
nnoremap <Leader>ft :FzfFiletypes<CR>
nnoremap <Leader>he :FzfHelptags<CR>
nnoremap <Leader>hi :FzfHistory<CR>
nnoremap <Leader>li :setlocal list! list?<CR>
nnoremap <Leader>ma :FzfMarks<CR>
nnoremap <Leader>nu :setlocal number! relativenumber!<CR>
nnoremap <Leader>rg :FzfRg<Space>
nnoremap <Leader>rs :source ~/.local/share/nvim/session.vim<CR>
nnoremap <Leader>s2 :setlocal expandtab shiftwidth=2 softtabstop=2<CR>
nnoremap <Leader>s4 :setlocal expandtab shiftwidth=4 softtabstop=4<CR>
nnoremap <Leader>se :FzfLines<CR>
nnoremap <Leader>sp :setlocal spell! spell?<CR>
nnoremap <Leader>ss :mksession! ~/.local/share/nvim/session.vim<CR>
nnoremap <Leader>t2 :setlocal noexpandtab shiftwidth=2 softtabstop=0 tabstop=2<CR>
nnoremap <Leader>t4 :setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4<CR>
nnoremap <Leader>t8 :setlocal noexpandtab shiftwidth=8 softtabstop=0 tabstop=8<CR>
nnoremap <Leader>te :Template ~/.config/nvim/templates/
nnoremap <Leader>tm :edit ~/Documents/Text/Temporary.txt<CR>
nnoremap <Leader>to :edit ~/Documents/Text/Todo.md<CR>
nnoremap <Leader>tw :setlocal textwidth=79
nnoremap <Leader>un :call UndoAll()<CR>
nnoremap <Leader>wi :FzfWindows<CR>
nnoremap <Leader>wr :setlocal wrap! wrap?<CR>
nnoremap <Leader>ws ml:%s/\s\+$//e \| nohlsearch<CR>`l
nnoremap <Leader>xx :FzfRg \b(FIXME\|NOTE\|TODO\|XXX)(:\|$\| )<CR>

" sed turns two spaces delimiter into one space.
nnoremap <Leader>cl :%!column -t \| sed 's/\( *\) /\1/g'<CR>
vnoremap <Leader>cl :!column -t  \| sed 's/\( *\) /\1/g'<CR>

nnoremap <Leader>re :%s++gc<Left><Left><Left>
vnoremap <Leader>re :s+\%V+gc<Left><Left><Left>

nnoremap <Leader>so :sort<CR>
vnoremap <Leader>so :sort<CR>

" Like 'p' and 'P' but last yanked instead of last deleted.
nnoremap <Leader>P "0P
nnoremap <Leader>p "0p

" Like 'y', 'yy' and 'Y' but use system clipboard.
nnoremap <Leader>Y  "*y$
nnoremap <Leader>yy "*yy
vnoremap <Leader>y  "*y

" Display full path to current file.
nnoremap <C-G> 1<C-G>

nnoremap <C-J> <Cmd>call GoToLoc("next")<CR>
nnoremap <C-K> <Cmd>call GoToLoc("prev")<CR>

" Disable to avoid unintended triggering.
nnoremap Q <Nop>

" Mark relative jumps with 'j' and 'k' so CTRL-I and CTRL-O works.
nnoremap <expr>j (v:count > 1 ? "m'" .. v:count : "") .. "j"
nnoremap <expr>k (v:count > 1 ? "m'" .. v:count : "") .. "k"

" Default binding with nohlsearch added.
vnoremap <C-L> <Esc><Cmd>nohlsearch<Bar>diffupdate<CR><C-L>

inoremap jj <Esc>

inoremap <C-X><C-F> <Plug>(fzf-complete-path)
inoremap <C-X><C-K> <Plug>(fzf-complete-word)
inoremap <C-X><C-L> <Plug>(fzf-complete-line)

" Text object consisting of all text inside current line, first character up
" until last character. Like 'w' (word), 'p' (paragraph) etc.
xnoremap il ^og_
onoremap il <Cmd>normal vil<CR>

" Make Nvim behave like everything else. Ctrl-E, Ctrl-U etc already works.
cnoremap <C-A> <Home>
