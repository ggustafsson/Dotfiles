syntax match Important +^!\s.*+
syntax match Default   +^-\s.*+
syntax match School    +^=\s.*+
syntax match Comment   +^#\s.*+

highlight link Important Statement
highlight link Default   Identifier
highlight link School    Type
highlight link Comment   Comment

