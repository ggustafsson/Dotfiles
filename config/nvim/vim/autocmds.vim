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

  autocmd BufNewFile,BufReadPost *.conf,config
    \ setlocal filetype=conf

  autocmd FileType gitcommit
    \ setlocal nolist spell textwidth=72

  autocmd FileType go
    \ setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4 nolist

  autocmd FileType json,markdown,python
    \ setlocal expandtab shiftwidth=4 softtabstop=4

  autocmd FileType yaml,yaml.ansible
    \ setlocal indentkeys-=0#

  " Quickfix and location list windows.
  autocmd FileType qf
    \ setlocal norelativenumber
    \   statusline=\ %(%t\ %)
    \   statusline+=%(%{exists('w:quickfix_title')?''.w:quickfix_title:''}\ %)
    \   statusline+=%=
    \   statusline+=%-11.(%l,%v\ %)
    \   statusline+=%(%P\ %)
augroup END
