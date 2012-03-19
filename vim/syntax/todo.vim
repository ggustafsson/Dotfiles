syntax match Indent1 +^\ \s.*+
syntax match Indent2 +^\ \ \s.*+
syntax match Indent3 +^\ \ \ \s.*+

highlight link Indent1 Identifier
highlight link Indent2 Normal
highlight link Indent3 Comment

