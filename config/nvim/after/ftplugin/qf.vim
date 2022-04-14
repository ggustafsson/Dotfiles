setlocal norelativenumber

setlocal statusline=\ %(%t\ %)
setlocal statusline+=%(%{exists('w:quickfix_title')?''.w:quickfix_title:''}\ %)
setlocal statusline+=%=
setlocal statusline+=%-11.(%l,%v\ %)
setlocal statusline+=%(%P\ %)
