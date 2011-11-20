" Göran Gustafsson <gustafsson.g@gmail.com>

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

syntax enable
colorscheme ninja

if has("mac")
	set shell=/usr/local/bin/bash
endif

set encoding=utf-8
set gdefault
set hidden
set modelines=0
set nofoldenable
set nowrap
set number
set scrolloff=3
set showbreak=+
set spelllang=en,sv
set ttyfast
set virtualedit=block,onemore

set autoindent
set smartindent

set backup
set backupdir=~/.vim/backups
set directory=~/.vim/backups
set undofile
set undodir=~/.vim/undos

set history=2000
set undolevels=2000

set hlsearch
set ignorecase
set incsearch
set smartcase

set laststatus=2
set showcmd
set statusline=%(%{BufferNr()}\ %)
set statusline+=%(%F\ %)
set statusline+=%(%r\ %)
set statusline+=%(%m\ %)
set statusline+=%([%{(&fenc==\"\"?&enc:&fenc)}]\ %)
set statusline+=%(%y\ %)
"set statusline+=%(%{CheckPath()}\ %)
set statusline+=%(%{fugitive#statusline()}\ %)
set statusline+=%(%{&paste?'[paste]':''}\ %)
set statusline+=%=
set statusline+=%(%v,\ %)
set statusline+=%(%l/%L\ %)

set list
set listchars=tab:>-,trail:·,precedes:<,extends:>

set shiftwidth=4
set tabstop=4

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
	set guioptions=gt
	set noantialias

	if !exists("g:dont_resize_again")
		set columns=130
		set lines=30

		let g:dont_resize_again = 1
	endif

	if has("mac")
		set guicursor+=a:blinkon0
		set guifont=Monaco:h12
	else
		set guifont=Dina:h15
	endif
else
	set mouse=v
	set t_Co=256
endif

if has("mac")
	let g:gist_clip_command = "pbcopy"
else
	let g:gist_clip_command = "xclip -selection primary"
endif

let g:gist_open_browser_after_post = 1
let g:html_ignore_folding = 1
let g:mapleader = ","

let g:LustyFilesystemExplorerDefaultMappings = 0
let g:LustyJugglerDefaultMappings = 0

let g:NERDCreateDefaultMappings = 0
let g:NERDMenuMode = 0
let g:NERDSpaceDelims = 1

let g:NERDTreeAutoCenter = 0
let g:NERDTreeMinimalUI = 1

cabbrev help tab help

cabbrev Q q
cabbrev W w
cabbrev WQ wq
cabbrev Wq wq
cabbrev wQ wq

if has("mac")
	nmap <Leader>f :silent !open "%:p:h"<CR>
	nmap <Leader>o :silent !open "%"<CR>
endif

nmap <Leader>b :buffers<CR>
nmap <Leader>c :cd %:p:h<CR>:pwd<CR>
nmap <Leader>C :silent !chmod "%"<CR>
nmap <Leader>d :bprevious<CR>:bdelete #<CR>
nmap <Leader>D :LustyFilesystemExplorer ~/Documents/Text\ Files/<CR>
nmap <Leader>e :LustyFilesystemExplorerFromHere<CR>
nmap <Leader>E :LustyFilesystemExplorer ~<CR>
nmap <Leader>g :Gist -a<CR>
nmap <Leader>G :Gist<CR>
nmap <Leader>l :!ls -l "%"<CR>
nmap <Leader>L :!ls -la "%:p:h"<CR>
nmap <Leader>n :new<CR>
nmap <Leader>N :set number!<CR>
nmap <Leader>p :set paste!<CR>
nmap <Leader>s :shell<CR>
nmap <Leader>S :set spell!<CR>
nmap <Leader>t :split ~/Documents/Text\ Files/TODO\ -\ Things\ to\ Do.txt<CR>
nmap <Leader>T :NERDTreeToggle<CR>
nmap <Leader>u :edit!<CR>
nmap <Leader>v :vnew<CR>
nmap <Leader>V :edit ~/.vimrc<CR>
nmap <Leader>w :set wrap!<CR>

nmap <Backspace> :nohlsearch<CR>
nmap <Tab> :bnext<CR>

nmap <C-w><C-Up> <C-w>K
nmap <C-w><C-Down> <C-w>J
nmap <C-w><C-Left> <C-w>H
nmap <C-w><C-Right> <C-w>L

nmap + <C-w>+
nmap - <C-w>-
nmap < <C-w>>
nmap > <C-w><

nmap § :LustyBufferExplorer<CR>
nmap vil ^vg_

nmap <C-s> :!mpc current<CR>
nmap <C-n> :silent !mpc next<CR>
nmap <C-p> :silent !mpc prev<CR>
nmap <C-t> :silent !mpc toggle<CR>

nmap <Leader><Space> <Plug>NERDCommenterToggle
vmap <Leader><Space> <Plug>NERDCommenterToggle

vmap <Leader>g :Gist -a<CR>
vmap <Leader>G :Gist<CR>
vmap <Leader>n y:new<CR>P
vmap <Leader>s :sort<CR>
vmap <Leader>v y:vnew<CR>P

imap <C-Tab> <C-n>

function! BufferNr()
	if &number == 1
		let b:bnumber = strlen(bufnr("%"))
		let b:blines = strlen(line("$"))
		let b:spaces = max([&numberwidth - b:bnumber, b:blines - b:bnumber + 1])

		let b:statusline = repeat(" ", b:spaces) . bufnr("%")

		return b:statusline
	else
		let b:statusline = "  " . bufnr("%")

		return b:statusline
	endif
endfunction

function! CheckPath()
	let b:checkpath = ""

	if expand("%:p:h") != getcwd()
		let b:checkpath = "[!= PWD]"
	endif

	return b:checkpath
endfunction

augroup Main
	autocmd!

	autocmd BufNewFile,BufRead *.txt,README,INSTALL,TODO setlocal filetype=text
	autocmd BufNewFile,BufRead config setlocal filetype=conf

	autocmd BufNewFile *.css execute "0read ~/.vim/templates/template.css | 12"
	autocmd BufNewFile *.html execute "0read ~/.vim/templates/template.html | 28"
	autocmd BufNewFile *.php execute "0read ~/.vim/templates/template.php | 29"
	autocmd BufNewFile *.py execute "0read ~/.vim/templates/template.py | 6"
	autocmd BufNewFile *.sh execute "0read ~/.vim/templates/template.sh | 5"

	autocmd Filetype help setlocal nospell colorcolumn=
	autocmd Filetype markdown,text setlocal colorcolumn=+1 spell textwidth=79

	autocmd BufWritePost ~/.vimrc source %
augroup END

