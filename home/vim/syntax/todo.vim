syntax match Indent1 +^!\s.*+
syntax match Indent2 +^-\s.*+
syntax match Indent3 +^#\s.*+

highlight link Indent1 Statement
highlight link Indent2 Identifier
highlight link Indent3 Comment

