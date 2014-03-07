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
set formatoptions=cjlnoqrt
set hidden
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

if has("mac")
  let g:gist_clip_command = "pbcopy"
endif

let g:NERDCreateDefaultMappings = 0
let g:gist_open_browser_after_post = 1
let g:mapleader = ","

let g:gundo_help = 0
let g:gundo_preview_statusline = " Gundo Preview"
let g:gundo_tree_statusline = " Gundo Tree"

let g:LustyExplorerDefaultMappings = 0
let g:LustyJugglerDefaultMappings = 0

let g:NERDTreeDirArrows = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeStatusline = " NERDTree"

cabbrev Q  q
cabbrev W  w
cabbrev Wq wq
cabbrev X  w

" -nargs=? means 0 or 1 arguments are allowed.
command! -nargs=? Helpt tab help <args>
cabbrev helpt Helpt

command! -nargs=? Helpv vertical help <args>
cabbrev helpv Helpv

command! Sudo w !sudo tee %
cabbrev sudo Sudo

if has("mac")
  if has("gui")
    nnoremap <Leader>fu :call FullScreen()<CR>
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
nnoremap <Leader>fe :set fileformat=unix \| set fileencoding=utf-8
nnoremap <Leader>ft :set filetype=
nnoremap <Leader>ga :Gist -a<CR>
nnoremap <Leader>gg :Gist<CR>
nnoremap <Leader>gu :GundoToggle<CR>
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

nnoremap vil ^vg_
nnoremap Y   Vy

nnoremap j gj
nnoremap k gk

nnoremap + <C-w>+
nnoremap - <C-w>-
nnoremap ? <C-w>>
nnoremap _ <C-w><

nnoremap <Backspace> :nohlsearch<CR>
nnoremap <Tab>       :LustyBufferExplorer<CR>

vnoremap <Leader>co :call NERDComment("x", "toggle")<CR>
vnoremap <Leader>ga :Gist -a<CR>
vnoremap <Leader>gg :Gist<CR>
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

  function! FullScreen()
    if &guifont != "Menlo:h24"
      set guifont=Menlo:h24
      set fullscreen
    else
      call FontSetup()
      set nofullscreen
    endif
  endfunction
endif

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

function! CompleteTab()
  " Get the character left of the cursor.
  let char = getline('.')[col('.')-2]

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
