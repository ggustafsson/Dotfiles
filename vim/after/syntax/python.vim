" Match shebang line so it is cleared instead of linked to 'pythonComment'.
syntax match pythonShebang /^#!\/.*/

" Match Python docstrings as regular comments.
syntax region Comment start=/"""/ end=/"""/
