-------------------------------------------------------------------------------
-- Settings and variables.
-------------------------------------------------------------------------------
hs.window.animationDuration = 0
preKeys = {"cmd", "ctrl"}

-------------------------------------------------------------------------------
-- Separate Lua files.
-------------------------------------------------------------------------------
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
    hs.alert.show(" Config Reloaded")
    hs.reload()
  end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConf):start()

-------------------------------------------------------------------------------
-- Toggle Hammerspoon console.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "c", function()
  hs.toggleConsole()
  hs.window.frontmostWindow():focus() -- Focus previous window afterwards.
end)
