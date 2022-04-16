if !exists("g:dont_run_again_if_we_have_already_bought_chicken_nuggets")
  colorscheme 16x256

  let g:dont_run_again_if_we_have_already_bought_chicken_nuggets = 1
endif

set completeopt=menu,menuone,noselect
set confirm
set formatoptions+=lnor " See ':help fo-table'.
set guicursor=
set inccommand=
set mouse=nvi " Why the heck would you want command-line mode here?
set nofoldenable
set nohidden
set nowrap
set smartindent
set spelllang=en,sv
set tabline=%!NvimTabLine()
set textwidth=79
set wildignorecase

set backup
set backupdir=~/.local/share/nvim/backup
set undofile

set cursorline
set cursorlineopt=number

set expandtab
set shiftwidth=2
set softtabstop=2

" ~/.vimrc [+] [dos] [latin1] [vim] [paste]        142,47     30%
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
set listchars=tab:>\ ,trail:-,nbsp:+,precedes:<,extends:>

set number
set relativenumber

set splitbelow
set splitright

let g:mapleader = ","
let g:markdown_folding = 1

let g:fzf_action = {"ctrl-t": "tab split", "ctrl-s": "split", "ctrl-v": "vsplit"}
let g:fzf_command_prefix = "Fzf"
