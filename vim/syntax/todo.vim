" I write to-do lists in Vim and i want to have differently colored lines
" depending on what character each line starts with. This is my way of
" categorising all of my entries.
"
" Character - means normal.
" Character ! means important.
" Character @ means download.
" Character = means work.
" Character # means comment.

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
