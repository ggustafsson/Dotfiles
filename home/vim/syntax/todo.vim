syntax match Important +^!\s.*+
syntax match Normal    +^-\s.*+
syntax match School    +^=\s.*+
syntax match Comment   +^#\s.*+

highlight link Important Statement
highlight link Normal    Identifier
highlight link School    Type
highlight link Comment   Comment

