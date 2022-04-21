setlocal norelativenumber

" [Quickfix List] :setqflist()        1/9    All
setlocal statusline=\ %(%q\ %)
setlocal statusline+=%(%{exists('w:quickfix_title')?''.w:quickfix_title:''}\ %)
setlocal statusline+=%=
setlocal statusline+=%-12.(\ %l/%L\ %)
setlocal statusline+=%(%P\ %)
