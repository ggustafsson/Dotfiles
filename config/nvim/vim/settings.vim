if !exists("g:dont_run_again_if_we_have_already_bought_chicken_nuggets")
  colorscheme 16x256

  let g:dont_run_again_if_we_have_already_bought_chicken_nuggets = 1
endif

set completeopt=menu,menuone,noselect
set confirm
set guicursor=
set inccommand=
set list
set mouse=nvi " XXX: https://github.com/neovim/neovim/pull/19290#issuecomment-1186515224
set nofoldenable
set nowrap
set spelllang=en,sv
set textwidth=79

set backup
set backupdir=~/.local/share/nvim/backup
set undofile

set cursorline
set cursorlineopt=number

set expandtab
set shiftwidth=2
set softtabstop=2

" See ':help fo-table' for explanation.
set formatoptions-=t
set formatoptions+=lnor

" ~/.vimrc [+] [dos] [latin1] [vim]        142,47    30%
set statusline=\ %(%f\ %)
set statusline+=%(%m\ %)
set statusline+=%([%{&fileformat=='unix'?'':&fileformat}]\ %)
set statusline+=%([%{&fileencoding=='utf-8'?'':&fileencoding}]\ %)
set statusline+=%(%y\ %)
set statusline+=%=
set statusline+=%-12.(\ %l,%v\ %) " 99999,999 would still have two spaces.
set statusline+=%(%P\ %)

set number
set relativenumber

set splitbelow
set splitright

set wildignorecase
set wildmode=longest,list

let g:markdown_folding = 1

let g:fzf_action = {"ctrl-s": "split", "ctrl-v": "vsplit"}
let g:fzf_colors = {"border": ["fg", "VertSplit"]}
let g:fzf_command_prefix = "Fzf"
let g:fzf_layout = {"window": {"height": 0.8, "width": 1}}
