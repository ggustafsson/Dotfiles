augroup Main
  autocmd!

  autocmd TextYankPost *
    \ silent! lua vim.highlight.on_yank { higroup = "Search", timeout = 200 }

  " If last cursor position still exist then go to it.
  autocmd BufRead * autocmd FileType <buffer> ++once
    \ if &filetype !~# 'commit\|rebase' &&
    \     line("'\"") > 1 && line("'\"") <= line("$") |
    \   execute 'normal! g`"' |
    \ endif

  autocmd Filetype *
    \ if &omnifunc == "" |
    \   setlocal omnifunc=syntaxcomplete#Complete |
    \ endif

  autocmd BufNewFile README.md InsertTemplate ~/.config/nvim/templates/README.md
  autocmd BufNewFile *.css  InsertTemplate ~/.config/nvim/templates/CSS.css
  autocmd BufNewFile *.go   InsertTemplate ~/.config/nvim/templates/Golang.go
  autocmd BufNewFile *.html InsertTemplate ~/.config/nvim/templates/HTML.html
  autocmd BufNewFile *.py   InsertTemplate ~/.config/nvim/templates/Python.py
  autocmd BufNewFile *.sh   InsertTemplate ~/.config/nvim/templates/Bash.sh
  autocmd BufNewFile *.zsh  InsertTemplate ~/.config/nvim/templates/Zsh.zsh

  autocmd BufRead,BufNewFile *.conf,config
    \ setlocal filetype=conf

  autocmd BufRead,BufNewFile */Ansiblebot/*.yml
    \ setlocal filetype=yaml.ansible

  autocmd FileType gitcommit
    \ setlocal nolist spell textwidth=72

  autocmd FileType go,snippets
    \ setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4

  autocmd FileType json,markdown,python
    \ setlocal expandtab shiftwidth=4 softtabstop=4

  autocmd FileType yaml,yaml.ansible
    \ setlocal indentkeys-=0#
augroup END
