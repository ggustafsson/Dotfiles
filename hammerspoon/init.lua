-------------------------------------------------------------------------------
-- Settings and variables.
-------------------------------------------------------------------------------
hs.window.animationDuration = 0
preKeys = {"cmd", "ctrl"}

-------------------------------------------------------------------------------
-- Separate config files.
-------------------------------------------------------------------------------
dofile("windows.lua")

-------------------------------------------------------------------------------
-- Toggle Hammerspoon console.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "h", function()
  hs.toggleConsole()
  hs.window.frontmostWindow():focus() -- Focus previous window afterwards.
end)

-------------------------------------------------------------------------------
-- Automatically reload configuration.
-------------------------------------------------------------------------------
function reloadConfig(files)
  local changes = false

  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      changes = true
    end
  end

  if changes then
    hs.reload()
  end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("There Is No Spoon", 1)
