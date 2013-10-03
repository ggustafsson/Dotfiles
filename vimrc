" Göran Gustafsson <gustafsson.g@gmail.com>

if !exists("g:dont_run_again")
  call pathogen#infect()
  call pathogen#helptags()

  filetype plugin indent on

  syntax enable
  colorscheme ninja

  let g:dont_run_again = 1
endif

set backspace=indent,eol,start
set confirm
set cryptmethod=blowfish
set encoding=utf-8
set formatoptions=cjlnoqrt
set hidden
set nowrap
set showbreak=+
set spelllang=en,sv
set t_vb=
set textwidth=78
set timeoutlen=2000
set virtualedit=block

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

set wildmode=longest,list
set wildignore=*.doc,*.pdf,.DS_Store
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.svg,*.tif,*.tiff
set wildignore+=*.flac,*.nsf,*.nsfe,*.m4a,*.m4r,*.mp3,*.ogg,*.wav
set wildignore+=*.avi,*.flv,*.f4v,*.mkv,*.mov,*.mpg,*.mpeg,*.mp4,*.m4v,*.wmv
set wildignore+=*.dmg,*.iso,*.rar,*.tar,*.tar.bz2,*.tar.gz,*.zip,*.7z

if has("gui_running") && has("mac")
  set guicursor+=a:blinkon0
  set guioptions=cgt
  set showcmd
  set visualbell

  function! FontSetup()
    set guifont=Inconsolata:h13
    set linespace=1

    set columns=185
    set lines=47
  endfunction

  if !exists("g:dont_set_font_again")
    call FontSetup()

    let g:dont_set_font_again = 1
  endif
endif

if has("mac")
  let g:gist_clip_command = "pbcopy"
endif

let g:gist_open_browser_after_post = 1
let g:mapleader = ","

let g:gundo_help = 0
let g:gundo_preview_statusline = " Gundo Preview"
let g:gundo_tree_statusline = " Gundo Tree"

let g:LustyExplorerDefaultMappings = 0
let g:LustyJugglerDefaultMappings = 0

let g:NERDCreateDefaultMappings = 0
let g:NERDMenuMode = 0

let g:NERDTreeAutoCenter = 0
let g:NERDTreeDirArrows = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeStatusline = " NERDTree"

command! -nargs=? Helpt tab help <args>
cabbrev helpt Helpt

if has("mac")
  nnoremap <Leader>fu :call FullScreen()<CR>
  nnoremap <Leader>fi :silent !open "%:p:h"<CR>
  nnoremap <Leader>op :silent !open -a Safari "%"<CR>
endif

nnoremap <Leader>bd :call BufferDelete()<CR>
nnoremap <Leader>cc :call ColorColumn()<CR>
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <Leader>do :LustyFilesystemExplorer ~/Documents/Text\ Files<CR>
nnoremap <Leader>ed :LustyFilesystemExplorerFromHere<CR>
nnoremap <Leader>eh :LustyFilesystemExplorer ~<CR>
nnoremap <Leader>ft :set filetype=
nnoremap <Leader>ga :Gist -a<CR>
nnoremap <Leader>gg :Gist<CR>
nnoremap <Leader>gu :GundoToggle<CR>
nnoremap <Leader>in :-read ~/.vim/snippets/
nnoremap <Leader>la :!ls -lFha "%:p:h"<CR>
nnoremap <Leader>li :set list!<CR>
nnoremap <Leader>ll :!ls -lFh "%"<CR>
nnoremap <Leader>ls :!ls -lFh "%:p:h"<CR>
nnoremap <Leader>ne :enew<CR>
nnoremap <Leader>no :edit ~/Documents/Text\ Files/Notes.txt<CR>
nnoremap <Leader>nu :call LineNumber()<CR>
nnoremap <Leader>os :source ~/.vim/session.vim<CR>
nnoremap <Leader>pa :set paste!<CR>
nnoremap <Leader>re :%s//gc<Left><Left><Left>
nnoremap <Leader>s2 :set expandtab softtabstop=2 shiftwidth=2<CR>
nnoremap <Leader>s4 :set expandtab softtabstop=4 shiftwidth=4<CR>
nnoremap <Leader>s8 :set expandtab softtabstop=8 shiftwidth=8<CR>
nnoremap <Leader>sh :shell<CR>
nnoremap <Leader>sp :setlocal spell!<CR>
nnoremap <Leader>ss :mksession! ~/.vim/session.vim<CR>
nnoremap <Leader>t2 :set noexpandtab shiftwidth=2 softtabstop=0 tabstop=2<CR>
nnoremap <Leader>t4 :set noexpandtab shiftwidth=4 softtabstop=0 tabstop=4<CR>
nnoremap <Leader>t8 :set noexpandtab shiftwidth=8 softtabstop=0 tabstop=8<CR>
nnoremap <Leader>ta :tab sball<CR>
nnoremap <Leader>tr :NERDTreeToggle<CR>
nnoremap <Leader>tw :set textwidth=78
nnoremap <Leader>un :edit!<CR>
nnoremap <Leader>w3 :!~/Scripts/validate "%"<CR>
nnoremap <Leader>wr :set wrap!<CR>
nnoremap <Leader>ws :%s/\s\+$//<CR>:nohlsearch<CR>

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
nnoremap <S-Tab>     :bnext<CR>

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
  function! FullScreen()
    if &guifont != "Inconsolata:h24"
      set fullscreen

      set antialias
      set guifont=Inconsolata:h24
    else
      set nofullscreen

      call FontSetup()
    endif
  endfunction
endif

function! BufferDelete()
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
    echo "colorcolumn=79"
    setlocal colorcolumn=79
  elseif &colorcolumn == "79"
    echo "colorcolumn=73"
    setlocal colorcolumn=73
  else
    echo "colorcolumn="
    setlocal colorcolumn=
  endif
endfunction

function! CompleteTab()
  let char = getline('.')[col('.')-2]

  if empty(char) || char == " "
    return "\<Tab>"
  else
    return "\<C-n>"
  endif
endfunction

function! LineNumber()
  if &relativenumber == 1
    echo "set number | set norelativenumber"
    set number
    set norelativenumber
  elseif &number == 1
    echo "set nonumber | set norelativenumber"
    set nonumber
    set norelativenumber
  else
    echo "set relativenumber | number"
    set number
    set relativenumber
  endif
endfunction

augroup Main
  autocmd!

  autocmd BufNewFile,BufRead README,TODO setlocal filetype=text
  autocmd BufNewFile,BufRead *.md        setlocal filetype=markdown
  autocmd BufNewFile,BufRead config      setlocal filetype=conf

  autocmd FileType gitcommit          setlocal colorcolumn=73 nolist spell textwidth=72
  autocmd FileType help               setlocal colorcolumn=
  autocmd FileType markdown,text,todo setlocal colorcolumn=79
  autocmd FileType markdown,python    setlocal expandtab shiftwidth=4 softtabstop=4

  autocmd BufWritePost ~/.vimrc source %
augroup END
