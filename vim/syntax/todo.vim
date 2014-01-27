" I write to-do lists in Vim and i want to have differently colored lines
" depending on what character each line starts with. This is my way of
" categorising all of my entries.
"
" Lines starting with ! stands for important.
" Lines starting with - stands for normal.
" Lines starting with = stands for school.
" Lines starting with @ stands for download.
" Lines starting with # stands for comments.

syntax match Comments  +^#.*+
syntax match Download  +^@.*+
syntax match Important +^!.*+
syntax match Normal    +^-.*+
syntax match School    +^=.*+

highlight link Comments  Comment
highlight link Download  Title
highlight link Important Statement
highlight link Normal    Identifier
highlight link School    Type
