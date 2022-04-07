" Shebang is by default matched as 'pythonComment->Comment', mimic Zsh and Ruby
" syntax and match as PreProc instead.
syntax match PreProc /^#!.*/

" Match Python docstrings as regular comments.
syntax region Comment start=/"""/ end=/"""/
syntax region Comment start=/'''/ end=/'''/
