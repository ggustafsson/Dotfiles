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
