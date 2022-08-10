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

  autocmd BufRead,BufNewFile */{,.}gitconfig*   setlocal filetype=gitconfig
  autocmd BufRead,BufNewFile */{,.}ssh/config*  setlocal filetype=sshconfig
  autocmd BufRead,BufNewFile */Ansiblebot/*.yml setlocal filetype=yaml.ansible
  autocmd BufRead,BufNewFile */yamllint/config  setlocal filetype=yaml

  autocmd BufNewFile */Text/Brain/*  Template ~/.config/nvim/templates/Note.md
  autocmd BufNewFile */Text/Cheats/* Template ~/.config/nvim/templates/Cheat.md

  autocmd FileType gitcommit
    \ setlocal nolist spell

  autocmd FileType gitconfig,snippets
    \ setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4

  autocmd FileType go
    \ let b:runprg = "go run '%'" |
    \ setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4
    \   listchars=tab:\ \ ,trail:-,nbsp:+,precedes:<,extends:>

  autocmd FileType json,python
    \ setlocal expandtab shiftwidth=4 softtabstop=4

  autocmd FileType markdown
    \ setlocal expandtab shiftwidth=4 softtabstop=4 formatoptions-=t

  autocmd FileType markdown,text
    \ setlocal linebreak

  autocmd FileType rust
    \ let b:runprg = "rustc -o /tmp/rustc-output '%' && /tmp/rustc-output" |
    \ setlocal textwidth=79

  autocmd FileType yaml,yaml.ansible
    \ setlocal indentkeys-=0# " Disable auto-indenting comments.
augroup END
