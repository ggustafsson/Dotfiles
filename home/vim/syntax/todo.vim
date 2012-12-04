syntax match Important +^!.*+
syntax match Default   +^-.*+
syntax match School    +^=.*+
syntax match Comment   +^#.*+

highlight link Important Statement
highlight link Default   Identifier
highlight link School    Type
highlight link Comment   Comment

