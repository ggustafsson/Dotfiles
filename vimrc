filetype plugin indent on
packadd! matchit " Makes % jump to matching HTML tags, if/else/endif, etc.

syntax enable
colorscheme static

set backspace=indent,eol,start
set confirm
set encoding=utf-8
set formatoptions+=jlnor
set nofoldenable
set nowrap
set nrformats-=octal
set omnifunc=syntaxcomplete#Complete
set pastetoggle=<C-p>
set sessionoptions-=options
set showcmd
set spelllang=en,sv
set virtualedit=block

set autoindent
set smartindent

set backup
set backupdir=~/.vim/backups
set directory=~/.vim/backups
set undofile
set undodir=~/.vim/undos

set colorcolumn=81
set textwidth=79

set cursorline
set cursorlineopt=number

set expandtab
set shiftwidth=2
set softtabstop=2

set hlsearch
set incsearch

" ~/.vimrc [+] [utf-8] [unix] [vim]    1, 46/260
set laststatus=2
set statusline=\ %F\ 
set statusline+=%(%r\ %)
set statusline+=%(%m\ %)
set statusline+=%([%{&fileencoding==''?&encoding:&fileencoding}]\ %)
set statusline+=%([%{&fileformat}]\ %)
set statusline+=%(%y\ %)
set statusline+=%(%{&paste?'[paste]':''}\ %)
set statusline+=%=%v,\ %l/%L\ 

set list
set listchars=tab:!-,trail:-,precedes:<,extends:>

set number
set numberwidth=3
set relativenumber

set splitbelow
set splitright

set wildignorecase
set wildmode=longest,list

let g:ackprg = "ag --vimgrep"
let g:mapleader = ","

let g:go_metalinter_autosave = 1
let g:go_template_autocreate = 0

let g:mundo_preview_statusline = " Mundo Preview"
let g:mundo_tree_statusline = " Mundo Tree"

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_jump = 1 " Runs :lfirst at start of syntax check.
let g:syntastic_auto_loc_list = 1 " Runs :lwindow and :lclose automatically.
let g:syntastic_enable_highlighting = 0
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

if has("mac")
  nnoremap <Leader>fi :silent !open "%:p:h"<CR>:redraw!<CR>
  nnoremap <Leader>op :silent !open "%"<CR>:redraw!<CR>
endif

nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bu :buffers<CR>:buffer<Space>
nnoremap <Leader>cc :call ColorColumn()<CR>
nnoremap <Leader>cd :cd <C-R>=escape(expand("%:p:h"), ' \')<CR>/
nnoremap <Leader>ed :edit <C-R>=escape(expand("%:p:h"), ' \')<CR>/
nnoremap <Leader>eh :edit ~/
nnoremap <Leader>fe :setlocal fileformat=unix fileencoding=utf-8
nnoremap <Leader>ff :call FixFile()<CR>
nnoremap <Leader>ft :setlocal filetype=
nnoremap <Leader>in :InsertFile ~/.vim/templates/
nnoremap <Leader>li :setlocal list! list?<CR>
nnoremap <Leader>nu :setlocal number! relativenumber!<CR>
nnoremap <Leader>rs :source ~/.vim/session.vim<CR>
nnoremap <Leader>s2 :setlocal expandtab shiftwidth=2 softtabstop=2<CR>
nnoremap <Leader>s4 :setlocal expandtab shiftwidth=4 softtabstop=4<CR>
nnoremap <Leader>s8 :setlocal expandtab shiftwidth=8 softtabstop=8<CR>
nnoremap <Leader>sh :shell<CR>
nnoremap <Leader>sp :setlocal spell! spell?<CR>
nnoremap <Leader>ss :mksession! ~/.vim/session.vim<CR>
nnoremap <Leader>t2 :setlocal noexpandtab shiftwidth=2 softtabstop=0 tabstop=2<CR>
nnoremap <Leader>t4 :setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4<CR>
nnoremap <Leader>t8 :setlocal noexpandtab shiftwidth=8 softtabstop=0 tabstop=8<CR>
nnoremap <Leader>te :edit ~/Documents/Text\ Files/
nnoremap <Leader>tw :setlocal textwidth=79
nnoremap <Leader>un :call UndoAll()<CR>
nnoremap <Leader>ut :MundoToggle<CR>
nnoremap <Leader>wr :setlocal wrap! wrap?<CR>
nnoremap <Leader>ws ml:%s/\s\+$//e \| nohlsearch<CR>`l

nnoremap <Leader>cl :%!column -t<CR>
vnoremap <Leader>cl :!column -t<CR>

nnoremap <Leader>cp :%yank *
vnoremap <Leader>cp "*y

nnoremap <Leader>ne :enew<CR>
vnoremap <Leader>ne y:enew<CR>PGdd

vnoremap <Leader>re :s/\%V/gc<Left><Left><Left>
nnoremap <Leader>re :%s//gc<Left><Left><Left>

" Locale files are broken under macOS and the latest Ubuntu Desktop LTS version
" don't include Vim with ':sort l' support yet. Using the default incorrect but
" stable sort until the future arrives...
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

nnoremap <silent><Backspace> :nohlsearch \| :echo<CR>
vnoremap <silent><Backspace> <Esc>:nohlsearch \| :echo<CR>

nnoremap Y y$

nnoremap cil ^cg_
nnoremap dil ^dg_
nnoremap vil ^vg_

nnoremap <silent><Tab>   :bnext<CR>
nnoremap <silent><S-Tab> :bprevious<CR>

nnoremap <silent><C-j> :silent! call LocationJump("next")<CR>
nnoremap <silent><C-k> :silent! call LocationJump("prev")<CR>

inoremap jj <Esc>

command! -nargs=1 -complete=file InsertFile call InsertFile(<q-args>)
command! SudoWrite w !sudo tee %

" Easily switch colorcolumn on and off. Remembers last colorcolumn setting.
function! ColorColumn()
  if empty(&colorcolumn)
    if exists("w:colorcolumn_last")
      let &l:colorcolumn = w:colorcolumn_last
      setlocal colorcolumn?
    else
      setlocal colorcolumn=+1 colorcolumn?
    endif
  else
    let w:colorcolumn_last = &colorcolumn
    setlocal colorcolumn= colorcolumn?
  endif
endfunction

" Fix file encoding, file format, tabs and remove whitespaces.
function! FixFile()
  setlocal fileencoding=utf-8
  setlocal fileformat=unix

  setlocal expandtab
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2
  retab

  normal! ml
  %s/\s\+$//e " Remove all whitespaces.
  nohlsearch
  normal! `l
endfunction

" Inserts template files above cursor, not below which is the read commands
" default behavior. If the buffer only has one empty line then it also removes
" the empty line after insert.
"
" command! -nargs=1 -complete=file InsertFile call InsertFile(<q-args>)
" nnoremap <Leader>in :InsertFile ~/.vim/templates/
function! InsertFile(file)
  let lines = line("$")
  let text = getline(".")

  if lines == 1 && empty(text)
    execute "read" fnameescape(a:file)
    execute "normal ggdd\<Esc>"
  else
    execute ".-read" fnameescape(a:file)
  endif
endfunction

" Jump to the next or previous item in the current windows location list. If
" error 'E776: No location list' is encountered jump to the next or previous
" item in the global quickfix list instead.
"
" nnoremap <silent><C-j> :silent! call LocationJump("next")<CR>
" nnoremap <silent><C-k> :silent! call LocationJump("prev")<CR>
function! LocationJump(action)
  try
    if a:action == "next"
      lnext
    else
      lprevious
    endif
  catch /:E776:/
    if a:action == "next"
      cnext
    else
      cprevious
    endif
  endtry
endfunction

" Undo all changes since last file write, unsaved buffers are emptied.
function! UndoAll()
  let filename = expand("%")

  if !empty(filename)
    edit!
  else
    earlier 1f
  endif
endfunction

augroup Main
  autocmd!
  autocmd BufWritePost ~/.vimrc source %

  " Check if last cursor position still exist and if so then go to it.
  autocmd BufReadPost * if line("'\"") <= line("$") | execute "normal! g`\"" | endif

  autocmd BufNewFile,BufReadPost *.conf,config setlocal filetype=conf

  autocmd FileType gitcommit  setlocal colorcolumn=73 spell textwidth=72
  autocmd FileType go         setlocal listchars+=tab:\ \  noexpandtab shiftwidth=4 softtabstop=0 tabstop=4
  autocmd FileType godoc,help setlocal colorcolumn= nolist
  autocmd FileType markdown   setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType python     setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType qf         setlocal colorcolumn= nocursorline norelativenumber statusline=\ %t%{exists('w:quickfix_title')?'\ '.w:quickfix_title:''}%=%l/%L\ 
augroup END
