" Göran Gustafsson <gustafsson.g@gmail.com>

let s:uname = substitute(system('uname'), "\n", "", "")

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

syntax enable
if ( has("gui_running") || (&t_Co == 256) )
	colorscheme ninja
endif

if has("mac")
	set shell=/usr/local/bin/zsh
endif

set confirm
set gdefault
set hidden
set nofoldenable
set nowrap
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

set encoding=utf-8
set fileencoding=utf-8

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
"set statusline+=%(%{StatuslineCheckPath()}\ %)
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
	set guioptions=cgt
	set noantialias

	if has("mac")
		set guicursor+=a:blinkon0
		set guifont=Monaco:h12

		if !exists("g:dont_resize_again")
			set columns=187
			set lines=45

			let g:dont_resize_again = 1
		endif
	else
		set guifont=Dina:h15
	endif
else
	set mouse=v
	set title
endif

if has("mac")
	let g:gist_clip_command = "pbcopy"
elseif s:uname == "OpenBSD"
	let g:LustyExplorerSuppressRubyWarning = 1
	let g:LustyJugglerSuppressRubyWarning = 1
else
	let g:gist_clip_command = "xclip -selection primary"
endif

let g:gist_open_browser_after_post = 1
let g:mapleader = ","
let g:surround_no_mappings = 1

let g:html_ignore_folding = 1
let g:html_number_lines = 0

let g:LustyExplorerDefaultMappings = 0
let g:LustyJugglerDefaultMappings = 0

let g:NERDCreateDefaultMappings = 0
let g:NERDMenuMode = 0
let g:NERDSpaceDelims = 1

let g:NERDTreeAutoCenter = 0
let g:NERDTreeMinimalUI = 1

cabbrev ht   tab help
cabbrev htab tab help

cabbrev Q  q
cabbrev W  w
cabbrev WQ wq
cabbrev Wq wq
cabbrev wQ wq

if has("mac")
	if has("gui_running")
		nmap <Leader>fa :call FancyView()<CR>
	endif

	nmap <Leader>fi :silent !open "%:p:h"<CR>
	nmap <Leader>op :silent !open "%"<CR>
endif

nmap <Leader>bd :call BufferDelete()<CR>
nmap <Leader>bl :read ~/.vim/templates/template.license<CR>
nmap <Leader>cc :call ColorColumn()<CR>
nmap <Leader>cd :cd %:p:h<CR>:pwd<CR>
nmap <Leader>ch :silent !chmod "%"<CR>
nmap <Leader>di :diffthis<CR>
nmap <Leader>do :LustyFilesystemExplorer ~/Documents/Text\ Files/<CR>
nmap <Leader>e2 :setlocal expandtab shiftwidth=2 tabstop=2<CR>
nmap <Leader>e4 :setlocal expandtab shiftwidth=4 tabstop=4<CR>
nmap <Leader>ed :LustyFilesystemExplorerFromHere<CR>
nmap <Leader>eh :LustyFilesystemExplorer ~<CR>
nmap <Leader>ft :set filetype=
nmap <Leader>ga :Gist -a<CR>
nmap <Leader>gg :Gist<CR>
nmap <Leader>la :!ls -la "%:p:h"<CR>
nmap <Leader>li :set list!<CR>
nmap <Leader>ls :!ls -l "%"<CR>
nmap <Leader>ne :enew<CR>
nmap <Leader>nu :set number!<CR>
nmap <Leader>pa :set paste!<CR>
nmap <Leader>pw :pwd<CR>
nmap <Leader>re :%s/
nmap <Leader>sc :split ~/Documents/Text\ Files/Scratch\ Notes.txt<CR>
nmap <Leader>sg :call <SID>SyntaxGroup()<CR>
nmap <Leader>sh :shell<CR>
nmap <Leader>sn :new<CR>
nmap <Leader>sp :setlocal spell!<CR>
nmap <Leader>su ^vg_<Plug>VSurround
nmap <Leader>to :split ~/Documents/Text\ Files/Things\ to\ Do.txt<CR>
nmap <Leader>tr :NERDTreeToggle<CR>
nmap <Leader>un :edit!<CR>
nmap <Leader>vi :edit ~/.vimrc<CR>
nmap <Leader>vn :vnew<CR>
nmap <Leader>wr :set wrap!<CR>
nmap <Leader>zs :edit ~/.zshrc<CR>

if s:uname == "OpenBSD"
	nmap <Leader>do :edit ~/Documents/Text\ Files/<CR>
	nmap <Leader>ed :edit
	nmap <Leader>eh :edit ~/

	nmap § :buffers<CR>
else
	nmap § :LustyBufferExplorer<CR>
endif

nmap vil ^vg_

nmap <Backspace> :nohlsearch<CR>
nmap <Tab>       :bnext<CR>

nmap + <C-w>+
nmap - <C-w>-
nmap < <C-w>>
nmap > <C-w><

nmap <C-s> :!mpc current<CR>
nmap <C-n> :silent !mpc next<CR>
nmap <C-p> :silent !mpc prev<CR>
nmap <C-t> :silent !mpc toggle<CR>

nmap <Leader><Space> <Plug>NERDCommenterToggle
vmap <Leader><Space> <Plug>NERDCommenterToggle

vmap <Leader>ga :Gist -a<CR>
vmap <Leader>gg :Gist<CR>
vmap <Leader>ne y:enew<CR>P
vmap <Leader>sn y:new<CR>P
vmap <Leader>so :sort<CR>
vmap <Leader>su <Plug>VSurround
vmap <Leader>vn y:vnew<CR>P

imap <C-Tab> <C-n>

if has("mac")
	if has("gui_running")
		function! FancyView()
			set antialias
			set guifont=Inconsolata:h28
		endfunction
	endif
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
		setlocal colorcolumn=80
	else
		setlocal colorcolumn=
	endif
endfunction

function! StatuslineBufferNr()
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

function! StatuslineCheckPath()
	let b:checkpath = ""

	if expand("%:p:h") != getcwd()
		let b:checkpath = "[!= PWD]"
	endif

	return b:checkpath
endfunction

function! <SID>SyntaxGroup()
	if !exists("*synstack")
		return
	endif

	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

augroup Main
	autocmd!

	autocmd BufNewFile,BufRead *.php                     setlocal filetype=html
	autocmd BufNewFile,BufRead *.txt,README,INSTALL,TODO setlocal filetype=text
	autocmd BufNewFile,BufRead config                    setlocal filetype=conf

	autocmd BufNewFile *.css  execute "0read ~/.vim/templates/template.css  | 18"
	autocmd BufNewFile *.html execute "0read ~/.vim/templates/template.html | 33"
	autocmd BufNewFile *.php  execute "0read ~/.vim/templates/template.php  | 34"
	autocmd BufNewFile *.py   execute "0read ~/.vim/templates/template.py   | 6"
	autocmd BufNewFile *.sh   execute "0read ~/.vim/templates/template.sh   | 5"

	autocmd FileType gitcommit     setlocal spell
	autocmd Filetype help          setlocal nospell colorcolumn=
	autocmd Filetype markdown,text setlocal colorcolumn=+1 spell textwidth=79

	autocmd BufWritePost ~/.vimrc source %
augroup END

