vim.api.nvim_create_user_command("FixFile", function(args)
  fix_file(args.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("FixTabs", function(args)
  fix_tabs(args.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("Help", function(args)
  vim.cmd("vertical help " .. args.args)
end, { nargs = "*", complete = "help" })

vim.api.nvim_create_user_command("Play", function(args)
  play(args.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("Popup", function(args)
  popup(args.args)
end, { nargs = "*" })

vim.api.nvim_create_user_command("Run", function()
  run()
end, { nargs = 0 })

-- Same as / in normal mode but works with paths.
vim.api.nvim_create_user_command("S", function(opts)
  vim.fn.setreg("/", opts.args)
  vim.cmd("normal! n")
end, { nargs = 1 })

vim.api.nvim_create_user_command("SyntaxInfo", function()
  syntax_info()
end, { nargs = 0 })

vim.api.nvim_create_user_command("Template", function(args)
  template(args.args)
  vim.cmd("silent! normal /\\<X\\>\r") -- Search for X.
end, { nargs = 1, complete = "file" })


-- Check if file exists and return true or false.
function file_exists(path)
  local path = path:gsub("^~", os.getenv("HOME"))
  local file = io.open(path, "r")
  return file ~= nil and io.close(file)
end

-- Change file encoding plus file format, convert tabs to spaces and remove
-- trailing whitespaces.
function fix_file(spaces)
  spaces = tostring(spaces)
  if not spaces:match("^[248]$") then
    print("Specify 2, 4 or 8 spaces!")
    return
  end

  vim.opt_local.fileencoding = "utf-8"
  vim.opt_local.fileformat = "unix"
  fix_tabs(spaces)
  vim.cmd("normal! ml")
  vim.cmd("%s/\\s\\+$//e") -- Removes trailing whitespaces.
  vim.cmd("nohlsearch")
  vim.cmd("normal! `l")
end

-- Convert tabs to 2, 4 or 8 spaces.
function fix_tabs(spaces)
  spaces = tostring(spaces)
  if not spaces:match("^[248]$") then
    print("Specify 2, 4 or 8 spaces!")
    return
  end

  local width = tonumber(spaces)
  vim.opt_local.expandtab = true
  vim.opt_local.shiftwidth = width
  vim.opt_local.softtabstop = width
  vim.opt_local.tabstop = width
  vim.cmd("retab")
end

-- Jump to next or previous location list entry. If location list is empty jump
-- to next or previous quickfix list entry instead.
function goto_loc(action)
  local cmds_loc_list, cmds_quickfix
  if action == "next" then
    cmds_loc_list = { next = "lnext", rotate = "lfirst" }
    cmds_quickfix = { next = "cnext", rotate = "cfirst" }
  elseif action == "prev" then
    cmds_loc_list = { next = "lprevious", rotate = "llast" }
    cmds_quickfix = { next = "cprevious", rotate = "clast" }
  else
    return
  end

  local ok, err = pcall(function()
    vim.cmd(cmds_loc_list.next)
  end)
  if ok then
    return
  end

  if err and err:find("E553:") then -- E553: No more items
    vim.cmd(cmds_loc_list.rotate)
  elseif err and (err:find("E42:") or err:find("E776:")) then -- E42: No Errors + E776: No location list
    local ok, err = pcall(function()
      vim.cmd(cmds_quickfix.next)
    end)
    if ok then
      return
    end

    if err and err:find("E553:") then  -- E553: No more items
      vim.cmd(cmds_quickfix.rotate)
    elseif err and not err:find("E42:") then -- E42: No Errors
      error(err, 0)
    end
  elseif err and err:find("E926:") then -- E926: Current location list was changed
    vim.cmd(cmds_loc_list.next)
  else
    error(err, 0)
  end
end

-- Open temporary file and insert template if matching one is found. Used in
-- combo with run() for language agnostic playground (e.g. Go Playground).
function play(filetype)
  local file = vim.fn.tempname() .. "." .. filetype
  local template = vim.fn.expand("~/.config/nvim/templates/Playground." .. filetype)

  vim.cmd("edit " .. file)
  if vim.fn.filereadable(template) == 1 then
    vim.cmd("Template " .. template)
  end
  vim.cmd("write")
  vim.cmd("silent !chmod +x '%'")
end

-- Execute shell command inside of Tmux popup window.
function popup(cmd)
  if vim.env.TMUX and vim.env.TMUX ~= "" then
    local tmux = "tmux popup -d '" .. vim.fn.getcwd() .. "'"
    vim.cmd("silent !" .. tmux .. " '" .. cmd .. "'")
  else
    print("Popup only works inside of Tmux!")
  end
end

-- Execute current file. Use command in variable 'b:runprg' or run file as-is.
function run()
  -- Check if buffer is named or not.
  if vim.fn.expand("%") == "" then
    print("Nothing to run!")
    return
  end

  local cmd = vim.b.runprg or "%:p" -- Full path to current file.
  if vim.env.TMUX and vim.env.TMUX ~= "" then
    vim.cmd("Popup " .. cmd)
  else
    vim.cmd("!" .. cmd)
  end
end

-- Display syntax group used at cursor position.
-- XXX: Does not work on filetypes with treesitter enabled.
function syntax_info()
  local syntax_id = vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1)
  local syntax_name = vim.fn.synIDattr(syntax_id, "name")
  local syntax_trans = vim.fn.synIDattr(vim.fn.synIDtrans(syntax_id), "name")

  if syntax_name ~= "" then
    print(syntax_name .. " -> " .. syntax_trans)
    vim.cmd("highlight " .. syntax_trans)
  else
    print("No syntax info found!")
  end
end

-- Simple custom tabline that sucks less than default.
--
-- 1:.vimrc  2:Xresources  3:[No Name]        X
--
-- vim.o.tabline = "%!v:lua.TabLine()"
function tab_line()
  local tabs = vim.fn.tabpagenr("$")
  local line = ""

  for tabnr = 1, tabs do
    local buflist = vim.fn.tabpagebuflist(tabnr)
    local winnr = vim.fn.tabpagewinnr(tabnr)
    local file = vim.fn.bufname(buflist[winnr])

    line = line .. "%" .. tabnr .. "T" -- Set tab number for mouse clicks.
    if tabnr == vim.fn.tabpagenr() then
      line = line .. "%#TabLineSel#"
    else
      line = line .. "%#TabLine#"
    end
    if file == "" then
      file = "[No Name]"
    else
      file = vim.fn.fnamemodify(file, ":p:t")
    end
    line = line .. " " .. tabnr .. ":" .. file .. " "
  end

  line = line .. "%#TabLineFill#%T"
  if tabs > 1 then
    line = line .. "%=%#TabLine#%999X X "
  end

  return line
end

-- Insert template file above cursor and perform several substitutions.
--
-- #FILE#  -> Filename with extension
-- #NAME#  -> Filename without extension
-- #TITLE# -> Filename without extension +
--            replace "-" with " - " and "_" with " "
-- #YEAR#  -> YYYY
-- #DATE#  -> YYYY-MM-DD
function template(file)
  if vim.fn.filereadable(file) == 0 then
    print("Failed to read template file!")
    return
  end

  -- Check number of lines + content of current line.
  if vim.fn.line("$") == 1 and vim.fn.getline(".") == "" then
    vim.cmd("read " .. vim.fn.fnameescape(file))
    vim.cmd("1delete")
  else
    vim.cmd(".-read " .. vim.fn.fnameescape(file))
  end

  vim.cmd("normal! ml")
  if vim.fn.expand("%") ~= "" then
    local tail = vim.fn.expand("%:t") -- t for tail.
    local name = vim.fn.expand("%:t:r") -- t for tail and r for root.
    local title = name:gsub("%-", " - "):gsub("_", " ")
    vim.cmd("%s/#FILE#/" .. tail .. "/ge")
    vim.cmd("%s/#NAME#/" .. name .. "/ge")
    vim.cmd("%s/#TITLE#/" .. title .. "/ge")
  end
  vim.cmd("%s/#YEAR#/" .. os.date("%Y") .. "/ge")
  vim.cmd("%s/#DATE#/" .. os.date("%Y-%m-%d") .. "/ge")
  vim.cmd("normal! `l")
end

-- Toggle 'colorcolumn' setting on and off. Also sets 'leadmultispace'.
function toggle_cc()
  if vim.o.colorcolumn == "" then
    local spaces = (" "):rep(math.max(0, vim.o.shiftwidth - 1))
    vim.opt_local.listchars:append({ leadmultispace = "│" .. spaces })
    vim.opt_local.colorcolumn = "+1"
    print("colorcolumn=" .. vim.o.colorcolumn)
  else
    vim.opt_local.listchars:remove("leadmultispace")
    vim.opt_local.colorcolumn = ""
    print("colorcolumn=" .. vim.o.colorcolumn)
  end
end

-- Toggle tree-sitter highlighting on and off.
vim.g.ts_highlight_enabled = true
function toggle_ts()
  if vim.g.ts_highlight_enabled then
    vim.treesitter.stop()
    vim.g.ts_highlight_enabled = false
    print("Tree-sitter highlighting off")
  else
    if pcall(vim.treesitter.start) then
      vim.g.ts_highlight_enabled = true
      print("Tree-sitter highlighting on")
    else
      print("Tree-sitter highlighting failed (No parser available)")
    end
  end
end
