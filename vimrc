if !exists("g:dont_run_again_if_we_have_already_bought_chicken_nuggets")
  filetype plugin indent on
  packadd! matchit " Makes % jump to matching HTML tags, if/else/endif, etc.

  syntax enable
  colorscheme static

  let s:vim_startup_dir = getcwd() " Used by 'ChangeDirectory()' later.
  let g:dont_run_again_if_we_have_already_bought_chicken_nuggets = 1
endif

set backspace=indent,eol,start
set confirm
set encoding=utf-8
set formatoptions+=jlnor " See ':help fo-table'.
set history=999
set nofoldenable
set nowrap
set nrformats-=octal " CTRL-A on 007 != 010. Shaken, not stirred! :)
set omnifunc=syntaxcomplete#Complete
set pastetoggle=<C-p> " Overrides 'Find previous keyword' under insert mode.
set sessionoptions-=options
set showcmd " This is for some reason 'off for Unix'. WTF?
set spelllang=en,sv
set virtualedit=block

set autoindent
set smartindent

set backup
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undofile
set undodir=~/.vim/undo

set colorcolumn=+1
set textwidth=79

set cursorline
set cursorlineopt=number

set expandtab
set shiftwidth=2
set softtabstop=2

set hlsearch
set incsearch

set ignorecase
set smartcase

" ~/.vimrc [+] [utf-8] [unix] [vim]    1, 46/260
set laststatus=2
set statusline=\ %(%F\ %)
set statusline+=%(%r\ %)
set statusline+=%(%m\ %)
set statusline+=%([%{&fileencoding==''?&encoding:&fileencoding}]\ %)
set statusline+=%([%{&fileformat}]\ %)
set statusline+=%(%y\ %)
set statusline+=%(%{&paste?'[paste]':''}\ %)
set statusline+=%=
set statusline+=%(%v,\ %)
set statusline+=%(%l/%L\ %)

set list
set listchars=tab:!-,trail:-,precedes:<,extends:>

set number
set numberwidth=3
set relativenumber

set splitbelow
set splitright

set wildignorecase
set wildmode=longest,list

let g:fzf_command_prefix = "Fzf"
let g:mapleader = ","

let g:go_metalinter_autosave = 1
let g:go_template_autocreate = 0

let g:mundo_preview_statusline = " Mundo Preview"
let g:mundo_tree_statusline = " Mundo Tree"

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_jump = 1 " Runs :lfirst at start of syntax check.
let g:syntastic_enable_highlighting = 0
let g:syntastic_mode_map = { "mode": "active", "passive_filetypes": ["go"] }

if has("mac")
  nnoremap <Leader>fi :silent !open "%:p:h"<CR>:redraw!<CR>
  nnoremap <Leader>op :silent !open "%"<CR>:redraw!<CR>
endif

if isdirectory($HOME .. "/.vim/pack/others/start/fzf")
  nnoremap <Leader>ag :FzfAg<Space>
  nnoremap <Leader>bu :FzfBuffers<CR>
  nnoremap <Leader>fd :FzfFiles<CR>
  nnoremap <Leader>fh :FzfFiles ~/
  nnoremap <Leader>ft :FzfFiletypes<CR>
  nnoremap <Leader>hi :FzfHistory<CR>
  nnoremap <Leader>se :FzfLines<CR>
else
  nnoremap <Leader>bu :buffers<CR>:buffer<Space>
  nnoremap <Leader>ft :setlocal filetype=
  nnoremap <Leader>hi :browse oldfiles<CR>
endif

nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>cc :call ColorColumn()<CR>
nnoremap <Leader>cd :call ChangeDirectory()<CR>
nnoremap <Leader>cw :call ToggleCWindow()<CR>
nnoremap <Leader>ed :edit <C-R>=escape(expand("%:p:h"), ' \')<CR>/
nnoremap <Leader>eh :edit ~/
nnoremap <Leader>in :InsertFile ~/.vim/templates/
nnoremap <Leader>li :setlocal list! list?<CR>
nnoremap <Leader>lw :call ToggleLWindow()<CR>
nnoremap <Leader>nu :setlocal number! relativenumber!<CR>
nnoremap <Leader>py :terminal python3<CR>
nnoremap <Leader>rs :source ~/.vim/session.vim<CR>
nnoremap <Leader>s2 :setlocal expandtab shiftwidth=2 softtabstop=2<CR>
nnoremap <Leader>s4 :setlocal expandtab shiftwidth=4 softtabstop=4<CR>
nnoremap <Leader>sh :terminal<CR>
nnoremap <Leader>sp :setlocal spell! spell?<CR>
nnoremap <Leader>ss :mksession! ~/.vim/session.vim<CR>
nnoremap <Leader>t4 :setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4<CR>
nnoremap <Leader>t8 :setlocal noexpandtab shiftwidth=8 softtabstop=0 tabstop=8<CR>
nnoremap <Leader>te :edit ~/Documents/Text\ Files/
nnoremap <Leader>tm :vsplit ~/Documents/Text\ Files/Tmp.txt \| :setlocal nobuflisted<CR>
nnoremap <Leader>to :vsplit ~/Documents/Text\ Files/Todo.txt \| :setlocal nobuflisted<CR>
nnoremap <Leader>tw :setlocal textwidth=79
nnoremap <Leader>un :call UndoAll()<CR>
nnoremap <Leader>ut :MundoToggle<CR>
nnoremap <Leader>wr :setlocal wrap! wrap?<CR>
nnoremap <Leader>ws ml:%s/\s\+$//e \| nohlsearch<CR>`l

nnoremap <Leader>cl :%!column -t<CR>
vnoremap <Leader>cl :!column -t<CR>

nnoremap <Leader>cp :%yank *
vnoremap <Leader>cp "*y

nnoremap <Leader>ne :enew<CR>
vnoremap <Leader>ne y:enew<CR>PGdd

vnoremap <Leader>re :s/\%V/gc<Left><Left><Left>
nnoremap <Leader>re :%s//gc<Left><Left><Left>

" Locale files are broken under macOS and the latest Ubuntu Desktop LTS version
" don't include Vim with ':sort l' support yet. Using the default incorrect but
" stable sort until the future arrives...
"
" Vim 8.2.3950 @ macOS 11.6.2 Big Sur:
"   :sort   - en_US.UTF-8     - 1 2 3 A B C U V W a b c u v w Ä Å Ö ä å ö
"   :sort l - en_US.UTF-8     - 1 2 3 A Å Ä B C Ö U V W a å ä b c ö u v w
"   :sort l - sv_SE.UTF-8     - 1 2 3 A B C U V W a b c u v w Ä Å Ö ä å ö
"   :sort l - sv_SE.ISO8859-1 - 1 2 3 A B C U V W Å Ä Ö a b c u v w å ä ö
"                               + v & w are treated as the same letter.
"
" Vim 8.1.2269 @ Ubuntu Desktop 20.04.3 LTS:
"   :sort   - en_US.UTF-8     - 1 2 3 A B C U V W a b c u v w Ä Å Ö ä å ö
"   :sort l - en_US.UTF-8     - Invalid argument: l
"   :sort l - sv_SE.UTF-8     - Invalid argument: l
"   :sort l - sv_SE.ISO8859-1 - Invalid argument: l
nnoremap <Leader>so :sort<CR>
vnoremap <Leader>so :sort<CR>

nnoremap <silent><Backspace> :nohlsearch \| :echo<CR>
vnoremap <silent><Backspace> <Esc>:nohlsearch \| :echo<CR>

nnoremap Y y$

" These key combos are unused and similar to 'gt' and 'gT' for tabs.
nnoremap <silent>gb :bnext<CR>
nnoremap <silent>gB :bprevious<CR>
nnoremap <silent>gl :call GoToLocation("next")<CR>
nnoremap <silent>gL :call GoToLocation("previous")<CR>

inoremap jj <Esc>

inoremap <expr><Tab> CompletionTab()
inoremap <C-n>       <C-x><C-o>

if isdirectory($HOME .. "/.vim/pack/others/start/fzf")
  imap <C-x><C-f> <Plug>(fzf-complete-path)
  imap <C-x><C-l> <Plug>(fzf-complete-line)
  imap <C-x><C-k> <Plug>(fzf-complete-word)
endif

" Text object consisting of all text inside current line, first character up
" until last character. Like 'w' (word), 'p' (paragraph) etc.
xnoremap il ^og_
onoremap <silent>il :normal vil<CR>

command! -nargs=* -complete=help Help vertical help <args>

" Jump back and forth between directory of file in current buffer and Vim's
" initial working directory.
function! ChangeDirectory()
  let l:buffer_path = expand("%:p:h")
  let l:current_path = getcwd()

  if l:current_path != l:buffer_path
    execute "cd " .. l:buffer_path
    echo "cd " .. getcwd()
  else
    if exists("s:vim_startup_dir")
      execute "cd " .. s:vim_startup_dir
      echo "cd " .. getcwd()
    else
      cd ~
      echo "cd " .. getcwd()
    endif
  endif
endfunction

" Easily switch colorcolumn on and off. Remembers last colorcolumn setting.
function! ColorColumn()
  if empty(&colorcolumn)
    if exists("b:colorcolumn_last")
      let &l:colorcolumn = b:colorcolumn_last
      setlocal colorcolumn?
    else
      setlocal colorcolumn=+1 colorcolumn?
    endif
  else
    let b:colorcolumn_last = &colorcolumn
    setlocal colorcolumn= colorcolumn?
  endif
endfunction

" Turns the tab key into <C-n> (keyword completion) if there are characters to
" the left of the cursor, normal tab character is inserted otherwise.
"
" inoremap <expr><Tab> CompletionTab()
function! CompletionTab()
  let l:char = getline(".")[col(".")-2] " Get the character left of the cursor.

  " Insert a normal tab if the character left of the cursor is non existent, a
  " space or a tab. Otherwise use keyword completion.
  if empty(char) || char == " " || char =~ "\t"
    return "\<Tab>"
  else
    return "\<C-n>"
  endif
endfunction

" Changes file encoding plus file format, converts tabs to spaces and removes
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
command! -nargs=1 FixFile call FixFile(<args>)

" Converts tabs to 2, 4 or 8 spaces.
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
command! -nargs=1 FixTabs call FixTabs(<args>)

" Jump to the next or previous item in the current windows location list. If
" error 'E776: No location list' is encountered jump to the next or previous
" item in the global quickfix list instead. This rotates through the lists.
function! GoToLocation(action)
  if a:action == "next"
    try
      lnext
    catch /:E553:/ " E553: No more items
      lfirst
    catch /:E776:/ " E776: No location list
      try
        cnext
      catch /:E553:/ " E553: No more items
        cfirst
      catch /:E42:/ " E42: No Errors
        return
      endtry
    " Quickfix and location list don't play nicely together.
    catch /:E926:/ " E926: Current location list was changed
      lnext
    endtry
  " Same code below as above, just [lc]previous and [lc]last instead.
  elseif a:action == "previous"
    try
      lprevious
    catch /:E553:/ " E553: No more items
      llast
    catch /:E776:/ " E776: No location list
      try
        cprevious
      catch /:E553:/ " E553: No more items
        clast
      catch /:E42:/ " E42: No Errors
        return
      endtry
    catch /:E926:/ " E926: Current location list was changed
      lprevious
    endtry
  endif
endfunction

" Inserts file above cursor instead of below which is the 'read' commands
" default behavior. If the buffer only has one empty line then it also removes
" the empty line after insert so HTML templates and similar works better.
function! InsertFile(file)
  let l:lines = line("$")
  let l:text = getline(".")

  if lines == 1 && empty(text)
    execute "read " .. fnameescape(a:file)
    normal! ggdd
  else
    execute ".-read " .. fnameescape(a:file)
  endif
endfunction
command! -nargs=1 -complete=file InsertFile call InsertFile(<q-args>)

" Toggles quickfix window, 'cwindow' only toggles when list is empty.
function! ToggleCWindow()
  if empty(filter(getwininfo(), "v:val.quickfix"))
    " Use 'cwindow' so we don't open up empty window.
    cwindow
  else
    cclose
  endif
endfunction

" Toggles location list window, 'lwindow' only toggles when list is empty.
function! ToggleLWindow()
  if empty(filter(getwininfo(), "v:val.loclist"))
    " Use 'lwindow' so we don't open up empty window.
    " + Shut up about 'E776: No location list' please!
    silent! lwindow
  else
    lclose
  endif
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

augroup Main
  autocmd!
  autocmd BufWritePost ~/.vimrc source %

  " Check if last cursor position still exist and if so then go to it.
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &filetype !~# "commit"
    \ |   execute "normal! g`\""
    \ | endif

  autocmd BufNewFile,BufReadPost *.conf,config setlocal filetype=conf

  autocmd FileType gitcommit  setlocal spell textwidth=72
  autocmd FileType go         setlocal noexpandtab shiftwidth=4 softtabstop=0 tabstop=4
  autocmd FileType godoc,help setlocal colorcolumn= nolist
  autocmd FileType json       setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType markdown   setlocal expandtab shiftwidth=4 softtabstop=4
  autocmd FileType python     setlocal expandtab shiftwidth=4 softtabstop=4

  " Quickfix and location list windows.
  autocmd FileType qf setlocal colorcolumn= nocursorline norelativenumber
    \ statusline=\ %(%t\ %)
    \ statusline+=%(%{exists('w:quickfix_title')?''.w:quickfix_title:''}\ %)
    \ statusline+=%=
    \ statusline+=%(%l/%L\ %)
augroup END
