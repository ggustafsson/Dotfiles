command! -nargs=* -complete=help Help vertical help <args>
command! -nargs=1 S let @/ = <q-args> | normal n " Same as / in normal mode.


" Toggle 'colorcolumn' setting on and off.
function! ColorColumn()
  if empty(&colorcolumn)
    setlocal colorcolumn=+1 colorcolumn?
  else
    setlocal colorcolumn= colorcolumn?
  endif
endfunction


" Change file encoding plus file format, convert tabs to spaces and remove
" trailing whitespaces.
function! FixFile(spaces)
  if a:spaces !~ "^[248]$"
    echo "Specify 2, 4 or 8 spaces!"
    return
  endif

  setlocal fileencoding=utf-8
  setlocal fileformat=unix

  FixTabs a:spaces

  normal! ml
  %s/\s\+$//e " Removes trailing whitespaces.
  nohlsearch
  normal! `l
endfunction
command! -nargs=1 FixFile call FixFile(<args>)


" Convert tabs to 2, 4 or 8 spaces.
function! FixTabs(spaces)
  if a:spaces !~ "^[248]$"
    echo "Specify 2, 4 or 8 spaces!"
    return
  endif

  setlocal expandtab
  let &l:shiftwidth = a:spaces
  let &l:softtabstop = a:spaces
  let &l:tabstop = a:spaces
  retab
endfunction
command! -nargs=1 FixTabs call FixTabs(<args>)


" Jump to next or previous location list entry. If location list is empty jump
" to next or previous quickfix list entry instead.
function! GoToLoc(action)
  if a:action == "next"
    let cmds_loclist  = {"next": "lnext", "rotate": "lfirst"}
    let cmds_quickfix = {"next": "cnext", "rotate": "cfirst"}
  elseif a:action == "prev"
    let cmds_loclist  = {"next": "lprevious", "rotate": "llast"}
    let cmds_quickfix = {"next": "cprevious", "rotate": "clast"}
  else
    return
  endif

  try
    execute cmds_loclist.next
  catch /:E553:/ " E553: No more items
    execute cmds_loclist.rotate
  catch /:E42:\|:E776:/ " E42: No Errors + E776: No location list
    try
      execute cmds_quickfix.next
    catch /:E553:/ " E553: No more items
      execute cmds_quickfix.rotate
    catch /:E42:/ " E42: No Errors
      return
    endtry
  catch /:E926:/ " E926: Current location list was changed
    execute cmds_loclist.next
  endtry
endfunction


" Open temporary file and insert template if matching one is found. Used in
" combo with Run() for language agnostic playground (e.g. Go Playground).
function! Play(filetype)
  let file = tempname() .. "." .. a:filetype
  let template = expand("~/.config/nvim/templates/Playground.") .. a:filetype

  execute "edit " .. file
  if filereadable(template)
    execute "Template " .. template
  endif
  write
  silent !chmod +x "%"
endfunction
command! -nargs=1 Play call Play(<q-args>)


" Execute shell command inside of Tmux popup window.
function! Pop(cmd)
  if !empty($TMUX)
    let tmux = "tmux popup -d '" .. getcwd() .. "'"
    execute "silent !" .. tmux .. " '" .. a:cmd .. "'"
  else
    echo "Pop only works inside of Tmux!"
  endif
endfunction
command! -nargs=* Pop call Pop(<q-args>)


" Execute current file. Use command in variable 'b:runprg' or run file as-is.
function! Run()
  " Check if buffer is named or not.
  if empty(expand("%"))
    echo "Nothing to run!"
    return
  endif

  if exists("b:runprg")
    let cmd = b:runprg
  else
    let cmd = "%:p" " Full path to current file.
  endif

  if !empty($TMUX)
    execute "Pop " .. cmd
  else
    execute "!" .. cmd
  endif
endfunction
command! -nargs=0 Run call Run()


" Display syntax group used at cursor position.
" XXX: Does not work on filetypes with treesitter enabled.
function! SyntaxInfo()
  let syntax_id = synID(line("."), col("."), 1)
  let syntax_name = synIDattr(syntax_id, "name")
  let syntax_trans = synIDattr(synIDtrans(syntax_id), "name")

  if !empty(syntax_name)
    echo syntax_name .. " -> " .. syntax_trans
    execute "highlight " .. syntax_trans
  else
    echo "No syntax info found!"
  endif
endfunction
command! -nargs=0 SyntaxInfo call SyntaxInfo()


" Simple custom tabline that sucks less than default.
"
" 1:.vimrc  2:Xresources  3:[No Name]        X
"
" set tabline=%!TabLine()
function TabLine()
  let string = ""
  for i in range(tabpagenr("$"))
    let tabnr = i + 1
    let string .= "%" .. (tabnr) .. "T" " Set tab number for mouse clicks.
    if tabnr == tabpagenr()
      let string .= "%#TabLineSel#"
    else
      let string .= "%#TabLine#"
    endif
    let buflist = tabpagebuflist(tabnr)
    let winnr = tabpagewinnr(tabnr)
    let file = bufname(buflist[winnr - 1])
    if file == ""
      let file = "[No Name]"
    else
      let file = fnamemodify(file, ":p:t")
    endif
    let string .= " " .. tabnr .. ":" .. file .. " "
  endfor
  let string .= "%#TabLineFill#%T"
  if tabpagenr("$") > 1
    let string .= "%=%#TabLine#%999X X "
  endif
  return string
endfunction


" Insert template file above cursor and perform several substitutions.
"
" #FILE#  -> Filename with extension
" #NAME#  -> Filename without extension
" #TITLE# -> Filename without extension and underscores
" #YEAR#  -> YYYY
" #DATE#  -> YYYY-MM-DD
function! Template(file)
  if !filereadable(a:file)
    echo "Failed to read template file!"
    return
  endif

  " Check number of lines + content of current line.
  if line("$") == 1 && empty(getline("."))
    execute "read " .. fnameescape(a:file)
    1delete
  else
    execute ".-read " .. fnameescape(a:file)
  endif

  normal! ml
  if !empty(expand("%s"))
    let file = expand("%:t") " t for tail.
    let name = expand("%:t:r") " t for tail and r for root.
    let title = substitute(name, "_", " ", "g")
    execute "%s/#FILE#/" .. file .. "/ge"
    execute "%s/#NAME#/" .. name .. "/ge"
    execute "%s/#TITLE#/" .. title .. "/ge"
  endif
  execute "%s/#YEAR#/" .. strftime("%Y") .. "/ge"
  execute "%s/#DATE#/" .. strftime("%Y-%m-%d") .. "/ge"
  normal! `l
endfunction
command! -nargs=1 -complete=file Template call Template(<q-args>) |
  \ execute "silent! normal /\\<X\\>\<CR>"
