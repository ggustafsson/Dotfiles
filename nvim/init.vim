if !exists("g:dont_run_again_if_we_have_already_bought_chicken_nuggets")
  filetype plugin indent on
  packadd! matchit " Makes % jump to matching HTML tags, if/else/endif, etc.

  syntax enable
  colorscheme electric-boogaloo

  let g:dont_run_again_if_we_have_already_bought_chicken_nuggets = 1
endif


set autoread
set backspace=indent,eol,start
set confirm
set encoding=utf-8
set formatoptions+=jlnor " See ':help fo-table'.
set history=999
set mouse=nvi " Why the heck would you want command-line mode here?
set nofoldenable
set nowrap
set nrformats-=octal " CTRL-A on 007 != 010. Shaken, not stirred! :)
set omnifunc=syntaxcomplete#Complete
set pastetoggle=<C-P> " Overrides 'Find previous keyword' under insert mode.
set sessionoptions-=options
set spelllang=en,sv
set textwidth=79
set virtualedit=block

set autoindent
set smartindent

set backup
set backupdir=~/.local/share/nvim/backup
"set directory=~/.vim/swap
set undofile
"set undodir=~/.vim/undo

set cursorline
set cursorlineopt=number

set expandtab
set shiftwidth=2
set softtabstop=2

set hlsearch
set incsearch

" ~/.vimrc [+] [dos] [latin1] [vim] [paste]        142,47     30%
set laststatus=2
set statusline=\ %(%f\ %)
set statusline+=%(%m\ %)
set statusline+=%([%{&fileformat=='unix'?'':&fileformat}]\ %)
set statusline+=%([%{&fileencoding=='utf-8'?'':&fileencoding}]\ %)
set statusline+=%(%y\ %)
set statusline+=%(%{&paste?'[paste]':''}\ %)
set statusline+=%=
set statusline+=%-12.(\ %l,%v\ %) " 99999,999 would still have two spaces.
set statusline+=%(%P\ %)

set list
set listchars=tab:!-,trail:-,precedes:<,extends:>

set number
set relativenumber

set splitbelow
set splitright

set wildignorecase
set wildmode=longest,list


let g:fern#drawer_width = 35
let g:mapleader = ","
let g:markdown_folding = 1

let g:ale_sign_error = "💀 "
let g:ale_sign_warning = "🔥 "
let g:ale_sign_style_error = "⚡️ "
let g:ale_sign_style_warning = "⚡️ "

let g:fzf_action = {"ctrl-t": "tab split", "ctrl-s": "split", "ctrl-v": "vsplit"}
let g:fzf_command_prefix = "Fzf"

let g:go_metalinter_autosave = 1
let g:go_template_autocreate = 0

let g:mundo_preview_statusline = " Mundo Preview"
let g:mundo_tree_statusline = " Mundo Tree"


if has("mac")
  nnoremap <Leader>fi :silent !open "%:p:h"<CR>:redraw!<CR>
  nnoremap <Leader>op :silent !open "%"<CR>:redraw!<CR>
endif

nnoremap <Leader>/  :FzfHistory/<CR>
nnoremap <Leader>:  :FzfHistory:<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bu :FzfBuffers<CR>
nnoremap <Leader>cc :call ColorColumn()<CR>
nnoremap <Leader>cd :cd <C-R>=escape(expand("%:p:h"), ' \')<CR>/
nnoremap <Leader>ed :edit <C-R>=escape(expand("%:p:h"), ' \')<CR>/
nnoremap <Leader>ef :FzfFiles<CR>
nnoremap <Leader>eh :edit ~/
nnoremap <Leader>er :FzfHistory<CR>
nnoremap <Leader>et :edit ~/Documents/Text/
nnoremap <Leader>ft :FzfFiletypes<CR>
nnoremap <Leader>he :FzfHelptags<CR>
nnoremap <Leader>in :InsertTemplate ~/.vim/templates/
nnoremap <Leader>li :setlocal list! list?<CR>
nnoremap <Leader>lo :silent! lwindow \| cwindow<CR>
nnoremap <Leader>ma :FzfMarks<CR>
nnoremap <Leader>nu :setlocal number! relativenumber!<CR>
nnoremap <Leader>rg :FzfRg<Space>
nnoremap <Leader>rs :source ~/.vim/session.vim<CR>
nnoremap <Leader>s2 :setlocal expandtab shiftwidth=2 softtabstop=2<CR>
nnoremap <Leader>s4 :setlocal expandtab shiftwidth=4 softtabstop=4<CR>
nnoremap <Leader>se :FzfLines<CR>
nnoremap <Leader>sp :setlocal spell! spell?<CR>
nnoremap <Leader>ss :mksession! ~/.vim/session.vim<CR>
nnoremap <Leader>t4 :setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4<CR>
nnoremap <Leader>t8 :setlocal noexpandtab shiftwidth=8 softtabstop=0 tabstop=8<CR>
nnoremap <Leader>tm :edit ~/Documents/Text/Tmp.txt \| :setlocal nobuflisted<CR>
nnoremap <Leader>to :edit ~/Documents/Text/Todo.md \| :setlocal nobuflisted<CR>
nnoremap <Leader>tr :Fern . -drawer -toggle<CR>
nnoremap <Leader>tw :setlocal textwidth=79
nnoremap <Leader>un :call UndoAll()<CR>
nnoremap <Leader>ut :MundoToggle<CR>
nnoremap <Leader>wi :FzfWindows<CR>
nnoremap <Leader>wr :setlocal wrap! wrap?<CR>
nnoremap <Leader>ws ml:%s/\s\+$//e \| nohlsearch<CR>`l
nnoremap <Leader>xx :FzfRg \b(FIXME\|TODO\|XXX)(:\|$\| )<CR>

" sed turns two spaces delimiter into one space.
nnoremap <Leader>cl :%!column -t \| sed 's/\( *\) /\1/g'<CR>
vnoremap <Leader>cl :!column -t \| sed 's/\( *\) /\1/g'<CR>

nnoremap <Leader>cp :%yank *<CR>
vnoremap <Leader>cp "*y

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

nnoremap <C-L> <Cmd>nohlsearch<CR><C-L>
vnoremap <C-L> <Esc><Cmd>nohlsearch<CR><C-L>

nnoremap Q <Nop>
nnoremap Y y$

" These key combos are unused and similar to 'gt' and 'gT' for tabs.
nnoremap gb <Cmd>bnext<CR>
nnoremap gB <Cmd>bprevious<CR>
nnoremap gl <Cmd>call GoToLocation("next")<CR>
nnoremap gL <Cmd>call GoToLocation("previous")<CR>

" Mark relative jumps with j/k so CTRL-I and CTRL-O works.
nnoremap <expr>j (v:count > 1 ? "m'" .. v:count : "") .. "j"
nnoremap <expr>k (v:count > 1 ? "m'" .. v:count : "") .. "k"

nnoremap <C-W>t <Cmd>tabedit<CR>

" Move visual block down/up and keep visual selection.
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv

inoremap jj <Esc>

inoremap <C-X><C-F> <Plug>(fzf-complete-path)
inoremap <C-X><C-K> <Plug>(fzf-complete-word)
inoremap <C-X><C-L> <Plug>(fzf-complete-line)

" Text object consisting of all text inside current line, first character up
" until last character. Like 'w' (word), 'p' (paragraph) etc.
xnoremap il ^og_
onoremap il <Cmd>normal vil<CR>

cnoremap <C-A> <Home>


command! -nargs=* -complete=help Help vertical help <args>


" Toggle 'colorcolumn' setting on and off.
function! ColorColumn()
  if empty(&colorcolumn)
    setlocal colorcolumn=+1 colorcolumn?
  else
    setlocal colorcolumn= colorcolumn?
  endif
endfunction

" Change file encoding plus file format, convert tabs to spaces and remove
" trailing whitespaces.
function! FixFile(spaces)
  if a:spaces !~ "^[248]$"
    echo "Select 2, 4 or 8 spaces!"
    return
  endif

  setlocal fileencoding=utf-8
  setlocal fileformat=unix

  call FixTabs(a:spaces)

  normal! ml
  %s/\s\+$//e " Removes trailing whitespaces.
  nohlsearch
  normal! `l
endfunction
command! -nargs=1 FixFile call FixFile(<args>)

" Convert tabs to 2, 4 or 8 spaces.
function! FixTabs(spaces)
  if a:spaces !~ "^[248]$"
    echo "Select 2, 4 or 8 spaces!"
    return
  endif

  setlocal expandtab
  let &l:shiftwidth = a:spaces
  let &l:softtabstop = a:spaces
  let &l:tabstop = a:spaces
  retab
endfunction
command! -nargs=1 FixTabs call FixTabs(<args>)

" Jump to next or previous location list entry. If location list is empty jump
" to next or previous quickfix list entry instead.
function! GoToLocation(action)
  if a:action == "next"
    let l:cmds_loclist  = {"next": "lnext", "rotate": "lfirst"}
    let l:cmds_quickfix = {"next": "cnext", "rotate": "cfirst"}
  elseif a:action == "previous"
    let l:cmds_loclist  = {"next": "lprevious", "rotate": "llast"}
    let l:cmds_quickfix = {"next": "cprevious", "rotate": "clast"}
  else
    return
  endif

  try
    execute l:cmds_loclist.next
  catch /:E553:/ " E553: No more items
    execute l:cmds_loclist.rotate
  catch /:E42:\|:E776:/ " E42: No Errors + E776: No location list
    try
      execute l:cmds_quickfix.next
    catch /:E553:/ " E553: No more items
      execute l:cmds_quickfix.rotate
    catch /:E42:/ " E42: No Errors
      return
    endtry
  catch /:E926:/ " E926: Current location list was changed
    execute l:cmds_loclist.next
  endtry
endfunction

" Insert file above cursor, replace #YEAR# with 'YYYY' and replace '#DATE#'
" with 'YYYY-MM-DD'. If buffer has only one empty line then remove it after
" insert so HTML templates and similar works better.
function! InsertTemplate(file)
  let l:lines = line("$")
  let l:text = getline(".")

  if lines == 1 && empty(text)
    execute "read " .. fnameescape(a:file)
    normal! ggdd
  else
    execute ".-read " .. fnameescape(a:file)
  endif

  execute "%s/#YEAR#/\\=system(\"date +'%Y' | tr -d '\n'\")/ge"
  execute "%s/#DATE#/\\=system(\"date +'%Y-%m-%d' | tr -d '\n'\")/ge"
endfunction
command! -nargs=1 -complete=file InsertTemplate call InsertTemplate(<q-args>)

" Display syntax group used at cursor position.
function! SyntaxGroup()
  let l:syntax_id = synID(line("."), col("."), 1)
  let l:syntax_name = synIDattr(l:syntax_id, "name")
  let l:syntax_trans = synIDattr(synIDtrans(l:syntax_id), "name")

  echo syntax_name . " -> " . syntax_trans
  execute "highlight " . syntax_trans
endfunction
command! -nargs=0 SyntaxGroup call SyntaxGroup()

" Undo all changes since last file save. Unsaved buffers are emptied.
function! UndoAll()
  let l:filename = expand("%")
  if !empty(filename)
    edit!
  else
    earlier 1f
  endif
endfunction

" 1:.vimrc  2:Xresources  3:[No Name]        X
function VimTabLine()
  let string = ""
  for i in range(tabpagenr("$"))
    let tabnr = i + 1
    let string .= "%" .. (tabnr) .. "T" " Set tab number for mouse clicks.
    if tabnr == tabpagenr()
      let string .= "%#TabLineSel#"
    else
      let string .= "%#TabLine#"
    endif
    let buflist = tabpagebuflist(tabnr)
    let winnr = tabpagewinnr(tabnr)
    let file = bufname(buflist[winnr - 1])
    if file == ""
      let file = "[No Name]"
    else
      let file = fnamemodify(file, ":p:t")
    endif
    let string .= " " .. tabnr .. ":" .. file .. " "
  endfor
  let string .= "%#TabLineFill#%T"
  if tabpagenr("$") > 1
    let string .= "%=%#TabLine#%999X X "
  endif
  return string
endfunction
set tabline=%!VimTabLine()


augroup Main
  autocmd!
  autocmd BufWritePost $MYVIMRC source %

  " If last cursor position still exist then go to it.
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &filetype !~# "commit"
    \ |   execute "normal! g`\""
    \ | endif

  autocmd BufNewFile,BufReadPost *.conf,config
    \ setlocal filetype=conf

  autocmd FileType fern
    \ setlocal nonumber norelativenumber

  autocmd FileType gitcommit
    \ setlocal nolist spell textwidth=72

  autocmd FileType go
    \ setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4 nolist

  autocmd FileType godoc
    \ setlocal nolist

  autocmd FileType json,markdown,python
    \ setlocal expandtab shiftwidth=4 softtabstop=4

  autocmd FileType yaml,yaml.ansible
    \ setlocal indentkeys-=0#

  " Quickfix and location list windows.
  autocmd FileType qf
    \ setlocal norelativenumber
    \ statusline=\ %(%t\ %)
    \ statusline+=%(%{exists('w:quickfix_title')?''.w:quickfix_title:''}\ %)
    \ statusline+=%=
    \ statusline+=%-11.(%l,%v\ %)
    \ statusline+=%(%P\ %)
augroup END
