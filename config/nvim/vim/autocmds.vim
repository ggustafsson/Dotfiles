augroup Main
  autocmd!

  autocmd TextYankPost *
    \ silent! lua vim.highlight.on_yank {higroup="Search", timeout=200}

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

  autocmd BufNewFile README.md InsertTemplate ~/.config/nvim/templates/README
  autocmd BufNewFile *.css  InsertTemplate ~/.config/nvim/templates/CSS
  autocmd BufNewFile *.go   InsertTemplate ~/.config/nvim/templates/Golang
  autocmd BufNewFile *.html InsertTemplate ~/.config/nvim/templates/HTML
  autocmd BufNewFile *.py   InsertTemplate ~/.config/nvim/templates/Python
  autocmd BufNewFile *.sh   InsertTemplate ~/.config/nvim/templates/Bash
  autocmd BufNewFile *.zsh  InsertTemplate ~/.config/nvim/templates/Zsh

  autocmd BufNewFile,BufReadPost *.conf,config
    \ setlocal filetype=conf

  autocmd FileType gitcommit
    \ setlocal nolist spell textwidth=72

  autocmd FileType go
    \ setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4

  autocmd FileType json,markdown,python
    \ setlocal expandtab shiftwidth=4 softtabstop=4

  autocmd FileType snippets
    \ setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4

  autocmd FileType yaml,yaml.ansible
    \ setlocal indentkeys-=0#
augroup END
