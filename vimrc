" Göran Gustafsson <gustafsson.g@gmail.com>

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax enable
colorscheme ninja

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

set laststatus=2
set statusline=%(\ %F\ %)
set statusline+=%(%m\ %)
set statusline+=%([%{&fenc==''?&enc:&fenc}]\ %)
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

command -nargs=? Helpt tab help <args>
cabbrev helpt Helpt

command -nargs=? S sudo w !sudo tee %

if has("mac")
  nnoremap <Leader>fi :silent !open "%:p:h"<CR>
  nnoremap <Leader>fu :call FullScreen()<CR>
  nnoremap <Leader>op :silent !open -a Safari "%"<CR>
endif

nnoremap <Leader>bd :call BufferDelete()<CR>
nnoremap <Leader>cc :call ColorColumn()<CR>
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <Leader>do :LustyFilesystemExplorer ~/Documents/Text\ Files<CR>
nnoremap <Leader>ed :LustyFilesystemExplorerFromHere<CR>
nnoremap <Leader>eh :LustyFilesystemExplorer ~<CR>
nnoremap <Leader>fe :set fileformat=unix \| set fileencoding=utf-8
nnoremap <Leader>ft :set filetype=
nnoremap <Leader>ga :Gist -a<CR>
nnoremap <Leader>gg :Gist<CR>
nnoremap <Leader>gu :GundoToggle<CR>
nnoremap <Leader>la :!ls -lFha "%:p:h"<CR>
nnoremap <Leader>li :set list!<CR>
nnoremap <Leader>ll :!ls -lFh "%"<CR>
nnoremap <Leader>ls :!ls -lFh "%:p:h"<CR>
nnoremap <Leader>ne :enew<CR>
nnoremap <Leader>no :edit ~/Documents/Text\ Files/Vim\ Notes.txt<CR>
nnoremap <Leader>nu :call LineNumber()<CR>
nnoremap <Leader>pa :set paste!<CR>
nnoremap <Leader>re :%s//gc<Left><Left><Left>
nnoremap <Leader>rs :source ~/.vim/session.vim<CR>
nnoremap <Leader>s2 :setlocal expandtab softtabstop=2 shiftwidth=2<CR>
nnoremap <Leader>s4 :setlocal expandtab softtabstop=4 shiftwidth=4<CR>
nnoremap <Leader>s8 :setlocal expandtab softtabstop=8 shiftwidth=8<CR>
nnoremap <Leader>sc :edit ~/Documents/Text\ Files/Scratch\ Notes.txt<CR>
nnoremap <Leader>sh :shell<CR>
nnoremap <Leader>sp :setlocal spell!<CR>
nnoremap <Leader>ss :mksession! ~/.vim/session.vim<CR>
nnoremap <Leader>t2 :setlocal noexpandtab shiftwidth=2 softtabstop=0 tabstop=2<CR>
nnoremap <Leader>t4 :setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4<CR>
nnoremap <Leader>t8 :setlocal noexpandtab shiftwidth=8 softtabstop=0 tabstop=8<CR>
nnoremap <Leader>ta :tab sball<CR>
nnoremap <Leader>tm :edit ~/Documents/Secure\ Notes/Temporary.blowfish<CR>
nnoremap <Leader>to :edit ~/Documents/Text\ Files/To-do\ List.todo<CR>
nnoremap <Leader>tr :NERDTreeToggle<CR>
nnoremap <Leader>tw :set textwidth=78
nnoremap <Leader>un :edit!<CR>
nnoremap <Leader>vi :edit ~/.vimrc<CR>
nnoremap <Leader>w3 :!~/Scripts/validate "%"<CR>
nnoremap <Leader>wr :set wrap!<CR>
nnoremap <Leader>ws :%s/\s\+$//<CR>:nohlsearch<CR>
nnoremap <Leader>zs :edit ~/.zshrc<CR>

nnoremap <Leader><Space> :call NERDComment("n", "Toggle")<CR>
vnoremap <Leader><Space> :call NERDComment("n", "Toggle")<CR>

nnoremap vil ^vg_
nnoremap Y   Vy

nnoremap j gj
nnoremap k gk

nnoremap + <C-w>+
nnoremap - <C-w>-
nnoremap < <C-w><
nnoremap > <C-w>>

nnoremap <Backspace> :nohlsearch<CR>
nnoremap <Tab>       :LustyBufferExplorer<CR>

nnoremap <C-j> }
nnoremap <C-k> {
vnoremap <C-j> }
vnoremap <C-k> {

vnoremap <Leader>ga :Gist -a<CR>
vnoremap <Leader>gg :Gist<CR>
vnoremap <Leader>ne y:enew<CR>P
vnoremap <Leader>so :sort<CR>

vnoremap <Tab>   >gv
vnoremap <S-Tab> <gv

inoremap <expr><Tab> CompleteTab()
inoremap jj          <Esc>

if has("gui_running") && has("mac")
  function FontSetup()
    set guifont=Menlo:h12
    set linespace=1

    set columns=204
    set lines=53
  endfunction
  call FontSetup()

  function FullScreen()
    if &guifont != "Menlo:h24"
      set guifont=Menlo:h24
      set fullscreen
    else
      call FontSetup()
      set nofullscreen
    endif
  endfunction
endif

function BufferDelete()
  if &modified
    echoerr "No write since last change. Not closing buffer!"
  else
    let s:total_nr_buffers = len(filter(range(1, bufnr("$")), "buflisted(v:val)"))

    if s:total_nr_buffers == 1
      bdelete
      echo "Buffer deleted. Created new buffer."
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

function CompleteTab()
  let char = getline('.')[col('.')-2]

  if empty(char) || char == " "
    return "\<Tab>"
  else
    return "\<C-n>"
  endif
endfunction

function LineNumber()
  if &relativenumber == 1
    echo "set nonumber | set norelativenumber"
    set nonumber
    set norelativenumber
  else
    echo "set number | set relativenumber"
    set number
    set relativenumber
  endif
endfunction

autocmd BufRead * execute "normal g'\""

autocmd BufNewFile,BufRead *.blowfish,README,TODO setlocal filetype=text
autocmd BufNewFile,BufRead *.conf,config          setlocal filetype=conf
autocmd BufNewFile,BufRead *.md                   setlocal filetype=markdown
autocmd BufNewFile,BufRead *.todo                 setlocal filetype=todo

autocmd FileType gitcommit          setlocal colorcolumn=73 nolist spell textwidth=72
autocmd FileType help               setlocal colorcolumn=
autocmd FileType markdown,text,todo setlocal colorcolumn=79
autocmd FileType markdown,python    setlocal expandtab shiftwidth=4 softtabstop=4
