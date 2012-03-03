" Göran Gustafsson <gustafsson.g@gmail.com>

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

syntax enable
colorscheme ninja

if has("mac")
  set shell=/usr/local/bin/zsh
endif

set confirm
set encoding=utf-8
set formatoptions+=n
set gdefault
set hidden
set nofoldenable
set nostartofline
set nowrap
set scrolloff=3
set showbreak=+
set spelllang=en,sv
set timeoutlen=2000
set virtualedit=block,onemore

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

set history=2000
set undolevels=2000

set hlsearch
set ignorecase
set incsearch
set smartcase

set laststatus=2
set statusline=%(%{StatuslineBufferNr()}\ %)
set statusline+=%(%F\ %)
set statusline+=%(%m\ %)
set statusline+=%([%{(&fenc==\"\"?&enc:&fenc)}]\ %)
set statusline+=%(%y\ %)
set statusline+=%(%{&paste?'[paste]':''}\ %)
set statusline+=%=
set statusline+=%(%v,\ %)
set statusline+=%(%l/%L\ %)

set list
set listchars=tab:>-,trail:-,precedes:<,extends:>

set numberwidth=3
set relativenumber

set splitbelow
set splitright

set t_vb=
set visualbell

set wildmode=longest,list
set wildignore=*.doc,*.pdf,.DS_Store
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.svg,*.tiff
set wildignore+=*.flac,*.nsf,*.nsfe,*.m4r,*.mp3,*.ogg,*.wav
set wildignore+=*.avi,*.flv,*.f4v,*.mkv,*.mov,*.mpg,*.mpeg,*.mp4,*.m4v,*.wmv
set wildignore+=*.dmg,*.iso,*.rar,*.tar,*.tar.bz2,*.tar.gz,*.zip

if has("gui_running")
  set guicursor+=a:blinkon0
  set guioptions=cgt
  set showcmd

  function! FontSetup()
    set guifont=Monaco:h12
    set noantialias

    set columns=130
    set lines=34
  endfunction

  if !exists("g:dont_load_again")
    call FontSetup()

    let g:dont_load_again = 1
  endif
else
  set mouse=v
  set title
endif

if has("mac")
  let g:gist_clip_command = "pbcopy"
endif

let g:gist_open_browser_after_post = 1
let g:mapleader = ","
let g:nyancat_display_statusline = 1
let g:snippets_dir = "~/.vim/snippets"

let g:gundo_help = 0
let g:gundo_preview_statusline = " Gundo Preview"
let g:gundo_tree_statusline = " Gundo Tree"

let g:html_ignore_folding = 1
let g:html_number_lines = 0

let g:LustyExplorerDefaultMappings = 0
let g:LustyJugglerDefaultMappings = 0

let g:minesweeper_custom_colors = 1
let g:minesweeper_statusline = " MineSweeper"
let g:minesweeper_title = "MineSweeper"

let g:NERDCreateDefaultMappings = 0
let g:NERDMenuMode = 0

let g:NERDTreeAutoCenter = 0
let g:NERDTreeDirArrows = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeStatusline = " NERDTree"

cabbrev ht   tab help
cabbrev htab tab help

cabbrev Q  q
cabbrev W  w
cabbrev WQ wq
cabbrev Wq wq
cabbrev wQ wq

if has("gui_running")
  nmap <Leader>cl :call CleanView()<CR>
  nmap <Leader>fa :call FancyView()<CR>
endif

if has("mac")
  nmap <Leader>fi :silent !open "%:p:h"<CR>
  nmap <Leader>ll :!gls -lh "%"<CR>
  nmap <Leader>ls :!gls -lha "%:p:h"<CR>
  nmap <Leader>op :silent !open -a Safari "%"<CR>
else
  nmap <Leader>ll :!ls -lh "%"<CR>
  nmap <Leader>ls :!ls -lha "%:p:h"<CR>
endif

nmap <Leader>bd :call BufferDelete()<CR>
nmap <Leader>cc :call ColorColumn()<CR>
nmap <Leader>cd :cd %:p:h<CR>:pwd<CR>
nmap <Leader>do :LustyFilesystemExplorer ~/Documents/Text\ Files<CR>
nmap <Leader>ed :LustyFilesystemExplorerFromHere<CR>
nmap <Leader>eh :LustyFilesystemExplorer ~<CR>
nmap <Leader>ft :set filetype=
nmap <Leader>ga :Gist -a<CR>
nmap <Leader>gg :Gist<CR>
nmap <Leader>gu :GundoToggle<CR>
nmap <Leader>li :set list!<CR>
nmap <Leader>mi :MineSweeper normal<CR>
nmap <Leader>ne :enew<CR>
nmap <Leader>nu :set relativenumber!<CR>
nmap <Leader>ny :source ~/.vim/bundle/nyancat-vim/nyancat2.vim<CR>
nmap <Leader>pa :set paste!<CR>
nmap <Leader>pw :pwd<CR>
nmap <Leader>re :%s//c<Left><Left>
nmap <Leader>rs :source ~/.vim/session.vim<CR>
nmap <Leader>s2 :set expandtab softtabstop=2 shiftwidth=2<CR>
nmap <Leader>s4 :set expandtab softtabstop=4 shiftwidth=4<CR>
nmap <Leader>sc :split ~/Documents/Text\ Files/Scratch\ Notes.txt<CR>
nmap <Leader>sh :shell<CR>
nmap <Leader>sn :new<CR>
nmap <Leader>sp :setlocal spell!<CR>
nmap <Leader>ss :mksession ~/.vim/session.vim<CR>
nmap <Leader>t4 :set noexpandtab shiftwidth=4 softtabstop=0 tabstop=4<CR>
nmap <Leader>t8 :set noexpandtab shiftwidth=8 softtabstop=0 tabstop=8<CR>
nmap <Leader>tm :split ~/Downloads/Temporary.txt<CR>
nmap <Leader>to :split ~/Documents/Text\ Files/To-do\ List.todo<CR>
nmap <Leader>tr :NERDTreeToggle<CR>
nmap <Leader>un :edit!<CR>
nmap <Leader>vi :edit ~/.vimrc<CR>
nmap <Leader>vn :vnew<CR>
nmap <Leader>wr :set wrap!<CR>
nmap <Leader>zs :edit ~/.zshrc<CR>

nmap vil ^vg_
nmap §   :LustyBufferExplorer<CR>

nmap + <C-w>+
nmap - <C-w>-
nmap < <C-w>>
nmap > <C-w><

nmap <Backspace> :nohlsearch<CR>
nmap <Tab>       :bnext<CR>

nmap <Leader><Space> <Plug>NERDCommenterToggle
vmap <Leader><Space> <Plug>NERDCommenterToggle

vmap <Leader>ga :Gist -a<CR>
vmap <Leader>gg :Gist<CR>
vmap <Leader>ne y:enew<CR>P
vmap <Leader>sn y:new<CR>P
vmap <Leader>so :sort<CR>
vmap <Leader>vn y:vnew<CR>P

vmap s <Plug>VSurround

vmap + :m'>+<CR>gv=`<my`>mzgv`yo`z
vmap - :m'<-2<CR>gv=`>my`<mzgv`yo`z

vmap <Tab>   >gv
vmap <S-Tab> <gv

if has("gui_running")
  function! FancyView()
    if &guifont != "Inconsolata:h22"
      set antialias
      set guifont=Inconsolata:h22
    else
      call FontSetup()
    endif
  endfunction

  function! CleanView()
    if &laststatus == 2
      set laststatus=1
      set norelativenumber
    else
      set laststatus=2
      set relativenumber
    endif
  endfunction
endif

function! BufferDelete()
  if &modified
    echohl ErrorMsg
    echomsg "No write since last change. Not closing buffer."
    echohl NONE
  else
    let s:total_nr_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))

    if s:total_nr_buffers == 1
      bdelete
      echo "Buffer deleted. Created new buffer."
    else
      bprevious
      bdelete #
      echo "Buffer deleted."
    endif
  endif
endfunction

function! ColorColumn()
  if empty(&colorcolumn)
    if empty(&textwidth)
      echo "colorcolumn=80"
      setlocal colorcolumn=80
    else
      echo "colorcolumn=+1 (" . (&textwidth + 1) . ")"
      setlocal colorcolumn=+1
    endif
  else
    echo "colorcolumn="
    setlocal colorcolumn=
  endif
endfunction

function! StatuslineBufferNr()
  if &number == 1
    let b:bnumber = strlen(bufnr("%"))
    let b:blines = strlen(line("$"))
    let b:spaces = max([&numberwidth - b:bnumber, b:blines - b:bnumber + 1])

    let b:statusline = repeat(" ", b:spaces) . bufnr("%")
  else
    let b:statusline = "  " . bufnr("%")
  endif

  return b:statusline
endfunction

augroup Main
  autocmd!

  autocmd BufNewFile,BufRead *.todo                    setlocal filetype=todo
  autocmd BufNewFile,BufRead *.txt,README,INSTALL,TODO setlocal filetype=text
  autocmd BufNewFile,BufRead config                    setlocal filetype=conf
  autocmd BufNewFile,BufRead MineSweeper               setlocal virtualedit=

  autocmd FileType gitcommit          setlocal colorcolumn=+1 nolist spell
  autocmd FileType help               setlocal colorcolumn=
  autocmd FileType html               setlocal filetype=html.css
  autocmd FileType markdown,text,todo setlocal colorcolumn=+1 textwidth=79
  autocmd FileType php                setlocal filetype=php.html.css
  autocmd FileType python             setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType snippet            setlocal noexpandtab shiftwidth=8 softtabstop=0 tabstop=8

  autocmd BufWritePost ~/.vimrc source %
augroup END

