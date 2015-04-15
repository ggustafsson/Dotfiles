" I write to-do lists in Vim and i want to have differently colored lines
" depending on what character each line starts with. This is my way of
" categorising all of my entries.
"
" Lines starting with - means normal.
" Lines starting with ! means important.
" Lines starting with @ means download.
" Lines starting with = means work.
" Lines starting with # means comment.

syntax match TodoComment   +^#.*+
syntax match TodoDownload  +^@.*+
syntax match TodoImportant +^!.*+
syntax match TodoNormal    +^-.*+
syntax match TodoWork      +^=.*+

highlight link TodoComment   Comment
highlight link TodoDownload  Title
highlight link TodoImportant Statement
highlight link TodoNormal    Identifier
highlight link TodoWork      Type
