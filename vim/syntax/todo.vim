syntax match Download  +^@.*+
syntax match Important +^!.*+
syntax match Normal    +^-.*+
syntax match School    +^=.*+

highlight link Download  Title
highlight link Important Statement
highlight link Normal    Identifier
highlight link School    Type
