let g:mapleader = ","

if has("mac")
  nnoremap <Leader>fi :silent !open %:p:h<CR>
  nnoremap <Leader>op :silent !open %<CR>
  nnoremap <Leader>vs :silent !open -a "Visual Studio Code" %<CR>
endif

nnoremap <Leader>/  :FzfHistory/<CR>
nnoremap <Leader>:  :FzfHistory:<CR>
nnoremap <Leader>bd :Bdelete<CR>
nnoremap <Leader>bu :FzfBuffers<CR>
nnoremap <Leader>cc :call ColorColumn()<CR>
nnoremap <Leader>cd :cd <C-R>=fnameescape(expand("%:p:h"))<CR>/
nnoremap <Leader>do :call DocsMode()<CR>
nnoremap <Leader>ed :edit <C-R>=fnameescape(expand("%:p:h"))<CR>/
nnoremap <Leader>eh :edit ~/
nnoremap <Leader>ff :FzfFiles<CR>
nnoremap <Leader>ft :FzfFiletypes<CR>
nnoremap <Leader>he :FzfHelptags<CR>
nnoremap <Leader>hi :FzfHistory<CR>
nnoremap <Leader>li :setlocal list! list?<CR>
nnoremap <Leader>lo :silent! lwindow \| cwindow<CR>
nnoremap <Leader>ma :FzfMarks<CR>
nnoremap <Leader>nn :NnnPicker<CR>
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
nnoremap <Leader>tr :NnnExplorer<CR>
nnoremap <Leader>tw :setlocal textwidth=79
nnoremap <Leader>un :call UndoAll()<CR>
nnoremap <Leader>wi :FzfWindows<CR>
nnoremap <Leader>wr :setlocal wrap! wrap?<CR>
nnoremap <Leader>ws ml:%s/\s\+$//e \| nohlsearch<CR>`l
nnoremap <Leader>xx :FzfRg \b(FIXME\|NOTE\|TODO\|XXX)(:\|$\| )<CR>

" sed turns two spaces delimiter into one space.
nnoremap <Leader>cl :%!column -t \| sed 's/\( *\) /\1/g'<CR>
vnoremap <Leader>cl :!column -t \| sed 's/\( *\) /\1/g'<CR>

nnoremap <Leader>ne :enew<CR>
vnoremap <Leader>ne y:enew<CR>PGdd

nnoremap <Leader>re :%s++gc<Left><Left><Left>
vnoremap <Leader>re :s+\%V+gc<Left><Left><Left>

" XXX: Locale files are broken under macOS and not perfect under Linux either.
"
" macOS 12.4 Monterey:
"   :sort   - en_US.UTF-8     - 1 2 3 A B C U V W a b c u v vb w wa Ä Å Ö ä å ö
"   :sort l - en_US.UTF-8     - 1 2 3 A Å Ä B C Ö U V W a å ä b c ö u v vb w wa
"   :sort l - sv_SE.UTF-8     - 1 2 3 A B C U V W a b c u v vb w wa Ä Å Ö ä å ö
"   :sort l - sv_SE.ISO8859-1 - 1 2 3 A B C U V W Å Ä Ö a b c u v w wa vb å ä ö
"                               + v & w are treated as the same letter.
"
" Ubuntu 22.04 LTS:
"   :sort   - en_US.UTF-8     - 1 2 3 A B C U V W a b c u v vb w wa Ä Å Ö ä å ö
"   :sort   - en_US.UTF-8     - 1 2 3 a A å Å ä Ä b B c C ö Ö u U v V vb w W wa
"   :sort l - sv_SE.UTF-8     - 1 2 3 a A b B c C u U v V vb w W wa å Å ä Ä ö Ö
"   :sort l - sv_SE.ISO8859-1 - 1 2 3 a A Ä Ö Å ö ä å b B c C u U v V vb w W wa
"           - + dot is ignored so hidden files and directories are mixed.
"
" tl;dr using 'sort l' is not a good idea...
nnoremap <Leader>so :sort<CR>
vnoremap <Leader>so :sort<CR>

" Like 'p' and 'P' but last yanked instead of last deleted.
nnoremap <Leader>P "0P
nnoremap <Leader>p "0p

" Like 'y', 'yy' and 'Y' but use system clipboard.
nnoremap <Leader>Y  "*y$
nnoremap <Leader>yy "*yy
vnoremap <Leader>y  "*y

nnoremap <C-G> 1<C-G>

nnoremap <C-W>C <Cmd>tabclose<CR>
nnoremap <C-W>t <Cmd>tabnew<CR>

nnoremap Q <Nop>

" These key combos are unused and similar to 'gt' and 'gT' for tabs.
nnoremap gb <Cmd>bnext<CR>
nnoremap gB <Cmd>bprevious<CR>
nnoremap gl <Cmd>call GoToLoc("next")<CR>
nnoremap gL <Cmd>call GoToLoc("prev")<CR>

" Mark relative jumps with 'j' and 'k' so CTRL-I and CTRL-O works.
nnoremap <expr>j (v:count > 1 ? "m'" .. v:count : "") .. "j"
nnoremap <expr>k (v:count > 1 ? "m'" .. v:count : "") .. "k"

vnoremap <C-L> <Esc><Cmd>nohlsearch<Bar>diffupdate<CR><C-L>

inoremap jj <Esc>

inoremap <C-X><C-F> <Plug>(fzf-complete-path)
inoremap <C-X><C-K> <Plug>(fzf-complete-word)
inoremap <C-X><C-L> <Plug>(fzf-complete-line)

" Text object consisting of all text inside current line, first character up
" until last character. Like 'w' (word), 'p' (paragraph) etc.
xnoremap il ^og_
onoremap il <Cmd>normal vil<CR>

cnoremap <C-A> <Home>
