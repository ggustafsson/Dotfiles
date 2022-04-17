command! -nargs=1 FixFile call FixFile(<args>)
command! -nargs=1 FixTabs call FixTabs(<args>)
command! -nargs=* -complete=help Help vertical help <args>
command! -nargs=1 -complete=file InsertTemplate call InsertTemplate(<q-args>)
command! -nargs=0 SyntaxGroup call SyntaxGroup()

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
    echo "Select 2, 4 or 8 spaces!"
    return
  endif

  setlocal fileencoding=utf-8
  setlocal fileformat=unix

  call FixTabs(a:spaces)

  normal! ml
  %s/\s\+$//e " Removes trailing whitespaces.
  nohlsearch
  normal! `l
endfunction

" Convert tabs to 2, 4 or 8 spaces.
function! FixTabs(spaces)
  if a:spaces !~ "^[248]$"
    echo "Select 2, 4 or 8 spaces!"
    return
  endif

  setlocal expandtab
  let &l:shiftwidth = a:spaces
  let &l:softtabstop = a:spaces
  let &l:tabstop = a:spaces
  retab
endfunction

" Jump to next or previous location list entry. If location list is empty jump
" to next or previous quickfix list entry instead.
function! GoToLocation(action)
  if a:action == "next"
    let l:cmds_loclist  = {"next": "lnext", "rotate": "lfirst"}
    let l:cmds_quickfix = {"next": "cnext", "rotate": "cfirst"}
  elseif a:action == "previous"
    let l:cmds_loclist  = {"next": "lprevious", "rotate": "llast"}
    let l:cmds_quickfix = {"next": "cprevious", "rotate": "clast"}
  else
    return
  endif

  try
    execute l:cmds_loclist.next
  catch /:E553:/ " E553: No more items
    execute l:cmds_loclist.rotate
  catch /:E42:\|:E776:/ " E42: No Errors + E776: No location list
    try
      execute l:cmds_quickfix.next
    catch /:E553:/ " E553: No more items
      execute l:cmds_quickfix.rotate
    catch /:E42:/ " E42: No Errors
      return
    endtry
  catch /:E926:/ " E926: Current location list was changed
    execute l:cmds_loclist.next
  endtry
endfunction

" Insert file above cursor, replace #YEAR# with 'YYYY' and replace '#DATE#'
" with 'YYYY-MM-DD'. If buffer has only one empty line then remove it after
" insert so HTML templates and similar works better.
function! InsertTemplate(file)
  let l:lines = line("$")
  let l:text = getline(".")

  if lines == 1 && empty(text)
    execute "read " .. fnameescape(a:file)
    normal! ggdd
  else
    execute ".-read " .. fnameescape(a:file)
  endif

  normal! ml
  execute "%s/#YEAR#/" .. strftime("%Y") .. "/ge"
  execute "%s/#DATE#/" .. strftime("%Y-%m-%d") .. "/ge"
  normal! `l
endfunction

" Display syntax group used at cursor position.
function! SyntaxGroup()
  let l:syntax_id = synID(line("."), col("."), 1)
  let l:syntax_name = synIDattr(l:syntax_id, "name")
  let l:syntax_trans = synIDattr(synIDtrans(l:syntax_id), "name")

  echo syntax_name . " -> " . syntax_trans
  execute "highlight " . syntax_trans
endfunction

" Undo all changes since last file save. Unsaved buffers are emptied.
function! UndoAll()
  let l:filename = expand("%")
  if !empty(filename)
    edit!
  else
    earlier 1f
  endif
endfunction

" 1:.vimrc  2:Xresources  3:[No Name]        X
function NvimTabLine()
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
