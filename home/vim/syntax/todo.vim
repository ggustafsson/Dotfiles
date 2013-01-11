syntax match Blog      +^@.*+
syntax match Comment   +^#.*+
syntax match Default   +^-.*+
syntax match Important +^!.*+
syntax match School    +^=.*+

highlight link Blog      Title
highlight link Comment   Comment
highlight link Default   Identifier
highlight link Important Statement
highlight link School    Type
