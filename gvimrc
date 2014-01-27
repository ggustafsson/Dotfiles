" Prevent MacVim from opening a new buffer when using New Tab.
if has("mac")
  macmenu File.New\ Tab key=<nop>
  nnoremap <D-t> :tab split<CR>
endif
