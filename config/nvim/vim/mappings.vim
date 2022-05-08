if has("mac")
  nnoremap <Leader>fi :silent !open "%:p:h"<CR>:redraw!<CR>
  nnoremap <Leader>op :silent !open "%"<CR>:redraw!<CR>
  nnoremap <Leader>vs :silent !open -a "Visual Studio Code" "%"<CR>:redraw!<CR>
endif

nnoremap <Leader>/  :FzfHistory/<CR>
nnoremap <Leader>:  :FzfHistory:<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bu :FzfBuffers<CR>
nnoremap <Leader>cc :call ColorColumn()<CR>
nnoremap <Leader>cd :cd <C-R>=escape(expand("%:p:h"), ' \')<CR>/
nnoremap <Leader>do :call DocsMode()<CR>
nnoremap <Leader>ed :edit <C-R>=escape(expand("%:p:h"), ' \')<CR>/
nnoremap <Leader>eh :edit ~/
nnoremap <Leader>ff :FzfFiles<CR>
nnoremap <Leader>ft :FzfFiletypes<CR>
nnoremap <Leader>he :FzfHelptags<CR>
nnoremap <Leader>hi :FzfHistory<CR>
nnoremap <Leader>li :setlocal list! list?<CR>
nnoremap <Leader>lo :silent! lwindow \| cwindow<CR>
nnoremap <Leader>ma :FzfMarks<CR>
nnoremap <Leader>nu :setlocal number! relativenumber!<CR>
nnoremap <Leader>rg :FzfRg<Space>
nnoremap <Leader>rs :source ~/.local/share/nvim/session.vim<CR>
nnoremap <Leader>s2 :setlocal expandtab shiftwidth=2 softtabstop=2<CR>
nnoremap <Leader>s4 :setlocal expandtab shiftwidth=4 softtabstop=4<CR>
nnoremap <Leader>se :FzfLines<CR>
nnoremap <Leader>sp :setlocal spell! spell?<CR>
nnoremap <Leader>ss :mksession! ~/.local/share/nvim/session.vim<CR>
nnoremap <Leader>t4 :setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4<CR>
nnoremap <Leader>t8 :setlocal noexpandtab shiftwidth=8 softtabstop=0 tabstop=8<CR>
nnoremap <Leader>te :InsertTemplate ~/.config/nvim/templates/
nnoremap <Leader>tm :edit ~/Documents/Text/Temporary.txt \| :setlocal nobuflisted<CR>
nnoremap <Leader>to :edit ~/Documents/Text/Todo.md \| :setlocal nobuflisted<CR>
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

nnoremap <Leader>re :%s//gc<Left><Left><Left>
vnoremap <Leader>re :s/\%V/gc<Left><Left><Left>

" XXX: Locale files are broken under macOS and the latest Ubuntu Desktop LTS
" version don't include Vim with ':sort l' support yet. Using the default
" incorrect but stable sort until the future arrives...
"
" Vim 8.2.3950 @ macOS 11.6.2 Big Sur:
"   :sort   - en_US.UTF-8     - 1 2 3 A B C U V W a b c u v w Ä Å Ö ä å ö
"   :sort l - en_US.UTF-8     - 1 2 3 A Å Ä B C Ö U V W a å ä b c ö u v w
"   :sort l - sv_SE.UTF-8     - 1 2 3 A B C U V W a b c u v w Ä Å Ö ä å ö
"   :sort l - sv_SE.ISO8859-1 - 1 2 3 A B C U V W Å Ä Ö a b c u v w å ä ö
"                               + v & w are treated as the same letter.
"
" Vim 8.1.2269 @ Ubuntu Desktop 20.04.3 LTS:
"   :sort   - en_US.UTF-8     - 1 2 3 A B C U V W a b c u v w Ä Å Ö ä å ö
"   :sort l - en_US.UTF-8     - Invalid argument: l
"   :sort l - sv_SE.UTF-8     - Invalid argument: l
"   :sort l - sv_SE.ISO8859-1 - Invalid argument: l
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
nnoremap <C-W>t <Cmd>tabedit<CR>

nnoremap Q <Nop>

" These key combos are unused and similar to 'gt' and 'gT' for tabs.
nnoremap gb <Cmd>bnext<CR>
nnoremap gB <Cmd>bprevious<CR>
nnoremap gl <Cmd>call GoToLocation("next")<CR>
nnoremap gL <Cmd>call GoToLocation("previous")<CR>

" Mark relative jumps with j/k so CTRL-I and CTRL-O works.
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
