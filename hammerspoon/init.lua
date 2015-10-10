-------------------------------------------------------------------------------
-- Settings and variables.
-------------------------------------------------------------------------------
hs.window.animationDuration = 0
preKeys = {"ctrl", "alt"}

-------------------------------------------------------------------------------
-- Separate Lua files.
-------------------------------------------------------------------------------
dofile("wifi.lua")
dofile("windows.lua")

-------------------------------------------------------------------------------
-- Automatically reload configuration.
-------------------------------------------------------------------------------
function reloadConf(files)
  local reload = false

  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      reload = true
    end
  end

  if reload then
    hs.reload()
  end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConf):start()
hs.alert.show(" Config Reloaded")

-------------------------------------------------------------------------------
-- Toggle Hammerspoon console.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "c", function()
  hs.toggleConsole()
  hs.window.frontmostWindow():focus() -- Focus previous window afterwards.
end)
