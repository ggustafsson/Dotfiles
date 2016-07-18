if !exists("g:dont_run_again")
  let g:dont_run_again = 1

  call pathogen#infect()
  call pathogen#helptags()

  filetype plugin indent on
  runtime macros/matchit.vim

  syntax enable
  colorscheme static
endif

if has("nvim")
  set mouse=
else
  set cryptmethod=blowfish
endif

set backspace=indent,eol,start
set colorcolumn=80
set confirm
set encoding=utf-8
set formatoptions+=jlnor
set nofoldenable
set nowrap
set pastetoggle=<C-p>
set sessionoptions-=options
set spelllang=en,sv
set textwidth=79
set virtualedit=block

set autoindent
set smartindent

set backup
set backupdir=~/.vim/backups
set directory=~/.vim/backups
set undofile
set undodir=~/.vim/undos

set completeopt-=preview
set omnifunc=syntaxcomplete#Complete

set expandtab
set shiftwidth=2
set softtabstop=2

set hlsearch
set incsearch

" ~/.vimrc [+] [utf-8] [unix] [vim]    1, 46/260
set laststatus=2
set statusline=%(\ %F\ %)
set statusline+=%(%r\ %)
set statusline+=%(%m\ %)
set statusline+=%([%{&fileencoding==''?&encoding:&fileencoding}]\ %)
set statusline+=%([%{&fileformat}]\ %)
set statusline+=%(%y\ %)
set statusline+=%(%{&paste?'[paste]':''}\ %)
set statusline+=%=
set statusline+=%(%v,\ %)
set statusline+=%(%l/%L\ %)

set list
set listchars=tab:!-,trail:-,precedes:<,extends:>

set number
set numberwidth=3
set relativenumber

set splitbelow
set splitright

set t_vb=
set visualbell

set wildignorecase
set wildmode=longest,list

let g:loaded_matchparen = 1
let g:mapleader = ","

let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

let g:gundo_help = 0
let g:gundo_preview_statusline = " Gundo Preview"
let g:gundo_tree_statusline = " Gundo Tree"

let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeStatusline = " NERDTree"

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_python_exec = system("which python3")

command! Sudo w !sudo tee %

" -nargs=? means 0 or 1 arguments are allowed.
command! -nargs=? Helpt tab help <args>
command! -nargs=? Helpv vertical help <args>
command! -nargs=1 -complete=file Insert call Insert(<q-args>)

if has("mac")
  nnoremap <Leader>fi :silent !open "%:p:h"<CR>
  nnoremap <Leader>op :silent !open -a Safari "%"<CR>
endif

nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bl :buffers<CR>
nnoremap <Leader>cc :call ColorColumn()<CR>
nnoremap <Leader>cd :cd <C-R>=escape(expand("%:p:h"), ' \')<CR>/
nnoremap <Leader>do :edit ~/Documents/Text\ Files/
nnoremap <Leader>ed :edit <C-R>=escape(expand("%:p:h"), ' \')<CR>/
nnoremap <Leader>ef :silent! call ErrorFind()<CR>
nnoremap <Leader>eh :edit ~/
nnoremap <Leader>er :browse oldfiles<CR>
nnoremap <Leader>fe :set fileformat=unix \| set fileencoding=utf-8
nnoremap <Leader>ff :call FixFile()<CR>
nnoremap <Leader>ft :set filetype=
nnoremap <Leader>gu :GundoToggle<CR>
nnoremap <Leader>in :Insert ~/.vim/templates/
nnoremap <Leader>li :set list!<CR>
nnoremap <Leader>no :edit ~/Documents/Text\ Files/Notes.txt<CR>
nnoremap <Leader>nu :set number! \| set relativenumber!<CR>
nnoremap <Leader>pt :edit <C-R>=escape(expand("%:p:h"), ' \')<CR>/.todo<CR>
nnoremap <Leader>rs :source ~/.vim/session.vim<CR>
nnoremap <Leader>s2 :setlocal expandtab shiftwidth=2 softtabstop=2<CR>
nnoremap <Leader>s4 :setlocal expandtab shiftwidth=4 softtabstop=4<CR>
nnoremap <Leader>s8 :setlocal expandtab shiftwidth=8 softtabstop=8<CR>
nnoremap <Leader>sh :shell<CR>
nnoremap <Leader>sp :setlocal spell!<CR>
nnoremap <Leader>ss :mksession! ~/.vim/session.vim<CR>
nnoremap <Leader>t2 :setlocal noexpandtab shiftwidth=2 softtabstop=0 tabstop=2<CR>
nnoremap <Leader>t4 :setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4<CR>
nnoremap <Leader>t8 :setlocal noexpandtab shiftwidth=8 softtabstop=0 tabstop=8<CR>
nnoremap <Leader>ta :tab sball<CR>
nnoremap <Leader>tm :edit ~/Documents/Text\ Files/Temporary.txt<CR>
nnoremap <Leader>to :edit ~/Documents/Text\ Files/To-do\ List.txt<CR>
nnoremap <Leader>tr :NERDTreeToggle<CR>
nnoremap <Leader>tw :set textwidth=79
nnoremap <Leader>un :call UndoAll()<CR>
nnoremap <Leader>vi :edit ~/.vimrc<CR>
nnoremap <Leader>w3 :!~/Scripts/validate "%"<CR>
nnoremap <Leader>wr :set wrap!<CR>
nnoremap <Leader>ws ml:%s/\s\+$//e \| nohlsearch<CR>`l
nnoremap <Leader>zs :edit ~/.zshrc<CR>

nnoremap <Leader>cl :%!column -t<CR>
vnoremap <Leader>cl :!column -t<CR>

nnoremap <Leader>ne :enew<CR>
vnoremap <Leader>ne y:enew<CR>P

vnoremap <Leader>re :s/\%V/gc<Left><Left><Left>
nnoremap <Leader>re :%s//gc<Left><Left><Left>

nnoremap <Leader>so :sort<CR>
vnoremap <Leader>so :sort<CR>

nnoremap <silent><Backspace> :nohlsearch \| echo<CR>
vnoremap <silent><Backspace> <Esc>:nohlsearch<CR>

nnoremap vil ^vg_
nnoremap Y   y$

nnoremap <silent>gb :bn<CR>
nnoremap <silent>gB :bp<CR>

nnoremap + <C-w>+
nnoremap - <C-w>-
nnoremap ? <C-w>>
nnoremap _ <C-w><

nnoremap <Tab>          :buffer<Space>
nnoremap <silent><C-w>t :tab split<CR>

inoremap jj <Esc>

inoremap <expr><Tab> CompleteTab()

" Easily switch between different colorcolumn settings. If textwidth is set
" then use textwidth + 1, if textwidth is not set then use colorcolumn=80, and
" if colorcolumn is already set then turn it off.
function! ColorColumn()
  if empty(&colorcolumn)
    if !empty(&textwidth)
      let column = str2nr(&textwidth) + 1
      echom "setlocal colorcolumn=" . column
      setlocal colorcolumn=+1
    else
      echo "setlocal colorcolumn=80"
      setlocal colorcolumn=80
    endif
  else
    echo "setlocal colorcolumn="
    setlocal colorcolumn=
  endif
endfunction

" Turn the tab key into <C-n> (keyword completion) if there are characters to
" the left of the cursor, normal tab key is inserted otherwise.
"
" inoremap <expr><Tab> CompleteTab()
function! CompleteTab()
  let char = getline('.')[col('.')-2] " Get the character left of the cursor.

  " Insert a normal tab if the character left of the cursor is non existent, a
  " space or a tab. Otherwise use autocomplete.
  if empty(char) || char == " " || char =~ '\t'
    return "\<Tab>"
  else
    return "\<C-n>"
  endif
endfunction

" Go to next error in location list, go back to first error after last error.
function! ErrorFind()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  endtry
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
" command! -nargs=1 -complete=file Insert call Insert(<q-args>)
" nnoremap <Leader>in :Insert ~/.vim/templates/
function! Insert(file)
  let lines = line('$')
  let text = getline('.')

  if lines == 1 && empty(text)
    execute "read" fnameescape(a:file)
    execute "normal ggdd\<Esc>"
  else
    execute ".-read" fnameescape(a:file)
  endif
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
  autocmd FileType qf         setlocal colorcolumn= nolist nonumber norelativenumber " QuickFix buffer.

  autocmd FileType go nmap <Leader>gd :GoDoc<CR>
  autocmd FileType go nmap <Leader>ge :GoErrCheck<CR>
  autocmd FileType go nmap <Leader>gi :GoInfo<CR>
  autocmd FileType go nmap <Leader>gl :GoLint<CR>
  autocmd FileType go nmap <Leader>gr :GoRename<CR>
  autocmd FileType go nmap <Leader>gv :GoVet<CR>
augroup END
