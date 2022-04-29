----------------------------
-- Settings and variables --
----------------------------
hs.window.animationDuration = 0
preKeys = {"cmd", "ctrl"}

---------------------------
-- Separate config files --
---------------------------
dofile("windows.lua")

----------------------------------------
-- Automatically reload configuration --
----------------------------------------
function reloadConfig(files)
  local modified = false

  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      modified = true
    end
  end

  if modified then
    hs.reload()
  end
end

-- Catch in variable to avoid Lua"s garbage collection.
watcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/",
  reloadConfig):start()

hs.alert.show("There Is No Spoon", 1)
