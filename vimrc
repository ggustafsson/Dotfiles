" Göran Gustafsson <gustafsson.g@gmail.com>

if !exists("g:dont_run_again")
  let g:dont_run_again = 1

  call pathogen#infect()
  call pathogen#helptags()

  filetype plugin indent on
  runtime macros/matchit.vim

  syntax enable
  colorscheme ninja
endif

if has("gui_running")
  set guicursor+=a:blinkon0
  set guioptions=c
  set showcmd
endif

set backspace=indent,eol,start
set confirm
set cryptmethod=blowfish
set encoding=utf-8
set formatoptions=cjlnoqrt
set hidden
set history=100
set nowrap
set showbreak=+
set spelllang=en,sv
set textwidth=78
set timeoutlen=2000
set virtualedit=block
set wildmode=longest,list

set autoindent
set smartindent

set backup
set backupdir=~/.vim/backups
set directory=~/.vim/backups
set undofile
set undodir=~/.vim/undos

set expandtab
set shiftwidth=2
set softtabstop=2

set hlsearch
set ignorecase
set incsearch
set smartcase

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
set listchars=tab:>-,trail:-,precedes:<,extends:>

set number
set numberwidth=3
set relativenumber

set splitbelow
set splitright

set t_vb=
set visualbell

let g:mapleader = ","

let g:gundo_help = 0
let g:gundo_preview_statusline = " Gundo Preview"
let g:gundo_tree_statusline = " Gundo Tree"

let g:LustyExplorerDefaultMappings = 0
let g:LustyJugglerDefaultMappings = 0

let g:NERDCreateDefaultMappings = 0
let g:NERDCustomDelimiters = { 'c': { 'left': '//' } }

let g:NERDTreeDirArrows = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeStatusline = " NERDTree"

command! Sudo w !sudo tee %

" -nargs=? means 0 or 1 arguments are allowed.
command! -nargs=? Helpt tab help <args>
command! -nargs=? Helpv vertical help <args>

if has("mac")
  if has("gui")
    nnoremap <Leader>fo :call FontSize()<CR>
  endif

  nnoremap <Leader>fi :silent !open "%:p:h"<CR>
  nnoremap <Leader>op :silent !open -a Safari "%"<CR>
endif

nnoremap <Leader>bd :call BufferDelete()<CR>
nnoremap <Leader>cc :call ColorColumn()<CR>
nnoremap <Leader>cd :cd %:p:h \| pwd<CR>
nnoremap <Leader>co :call NERDComment("n", "toggle")<CR>
nnoremap <Leader>do :LustyFilesystemExplorer ~/Documents/Text\ Files<CR>
nnoremap <Leader>ed :LustyFilesystemExplorerFromHere<CR>
nnoremap <Leader>eh :LustyFilesystemExplorer ~<CR>
nnoremap <Leader>er :browse oldfiles<CR>
nnoremap <Leader>fe :set fileformat=unix \| set fileencoding=utf-8
nnoremap <Leader>ft :set filetype=
nnoremap <Leader>gu :GundoToggle<CR>
nnoremap <Leader>in :.-1read ~/.vim/templates/
nnoremap <Leader>li :set list!<CR>
nnoremap <Leader>ne :enew<CR>
nnoremap <Leader>nu :set number! \| set relativenumber!<CR>
nnoremap <Leader>pa :set paste!<CR>
nnoremap <Leader>re :%s//gc \| nohlsearch<C-b><Right><Right><Right>
nnoremap <Leader>rs :source ~/.vim/session.vim<CR>
nnoremap <Leader>s2 :setlocal expandtab softtabstop=2 shiftwidth=2<CR>
nnoremap <Leader>s4 :setlocal expandtab softtabstop=4 shiftwidth=4<CR>
nnoremap <Leader>s8 :setlocal expandtab softtabstop=8 shiftwidth=8<CR>
nnoremap <Leader>sh :shell<CR>
nnoremap <Leader>sp :setlocal spell!<CR>
nnoremap <Leader>ss :mksession! ~/.vim/session.vim<CR>
nnoremap <Leader>t2 :setlocal noexpandtab shiftwidth=2 softtabstop=0 tabstop=2<CR>
nnoremap <Leader>t4 :setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4<CR>
nnoremap <Leader>t8 :setlocal noexpandtab shiftwidth=8 softtabstop=0 tabstop=8<CR>
nnoremap <Leader>ta :tab sball<CR>
nnoremap <Leader>to :edit ~/Documents/Text\ Files/To-do\ List.todo<CR>
nnoremap <Leader>tr :NERDTreeToggle<CR>
nnoremap <Leader>tw :set textwidth=78
nnoremap <Leader>un :edit!<CR>
nnoremap <Leader>vi :edit ~/.vimrc<CR>
nnoremap <Leader>w3 :!~/Scripts/validate "%"<CR>
nnoremap <Leader>wr :set wrap!<CR>
nnoremap <Leader>ws :%s/\s\+$// \| nohlsearch<CR>
nnoremap <Leader>zs :edit ~/.zshrc<CR>

nnoremap ,. :

nnoremap vil ^vg_
nnoremap Y   y$

nnoremap j gj
nnoremap k gk

nnoremap + <C-w>+
nnoremap - <C-w>-
nnoremap ? <C-w>>
nnoremap _ <C-w><

nnoremap <Backspace> :nohlsearch<CR>
nnoremap <Tab>       :LustyBufferExplorer<CR>

vnoremap <Leader>co :call NERDComment("x", "toggle")<CR>
vnoremap <Leader>ne y:enew<CR>P
vnoremap <Leader>so :sort<CR>

inoremap <expr><Tab> CompleteTab()
inoremap jj          <Esc>

if has("gui_running") && has("mac")
  function! FontSetup()
    set guifont=Menlo:h12
    set linespace=1

    set columns=204
    set lines=53
  endfunction
  if !exists("g:dont_set_font_again")
    let g:dont_set_font_again = 1

    call FontSetup()
  endif

  function! FontSize()
    if &guifont != "Menlo:h22"
      set guifont=Menlo:h22
    else
      call FontSetup()
    endif
  endfunction
endif

" Delete buffers in a more user friendly way (try to not close split windows).
function! BufferDelete()
  if &modified
    echohl ErrorMsg
    echo "No write since last change. Not closing buffer!"
    echohl None
  else
    let s:total_nr_buffers = len(filter(range(1, bufnr("$")), "buflisted(v:val)"))

    if s:total_nr_buffers == 1
      bdelete
      echohl WarningMsg
      echo "Buffer deleted. Created new buffer."
      echohl None
    else
      bprevious
      bdelete #
    endif
  endif
endfunction

" Easily switch between two different colorcolumn settings and off state.
function! ColorColumn()
  if empty(&colorcolumn)
    echo "setlocal colorcolumn=79"
    setlocal colorcolumn=79
  elseif &colorcolumn == "79"
    echo "setlocal colorcolumn=73"
    setlocal colorcolumn=73
  else
    echo "setlocal colorcolumn="
    setlocal colorcolumn=
  endif
endfunction

" Turn the tab key into <C-n> (auto completion) if there are characters to the
" left of the cursor, normal tab key is used otherwise.
"
" inoremap <expr><Tab> CompleteTab()
function! CompleteTab()
  " Get the character left of the cursor.
  let char = getline('.')[col('.')-2]

  " Insert a normal tab if the character left of the cursor is non existent, a
  " space or a tab. Otherwise use autocomplete.
  if empty(char) || char == " " || char =~ '\t'
    return "\<Tab>"
  else
    return "\<C-n>"
  endif
endfunction

augroup Main
  autocmd!
  autocmd BufWritePost ~/.vimrc source %

  " Check if last cursor position still exist and if so then go to it.
  autocmd BufReadPost * if line("'\"") <= line("$") | execute "normal! g`\"" | endif

  autocmd BufNewFile,BufReadPost *.blowfish,README,TODO setlocal filetype=text
  autocmd BufNewFile,BufReadPost *.conf,config          setlocal filetype=conf
  autocmd BufNewFile,BufReadPost *.md                   setlocal filetype=markdown
  autocmd BufNewFile,BufReadPost *.todo                 setlocal filetype=todo

  autocmd FileType gitcommit          setlocal colorcolumn=73 nolist spell textwidth=72
  autocmd FileType help               setlocal colorcolumn= nolist
  autocmd FileType markdown,text,todo setlocal colorcolumn=79
  autocmd FileType markdown,python    setlocal expandtab shiftwidth=4 softtabstop=4
augroup END
