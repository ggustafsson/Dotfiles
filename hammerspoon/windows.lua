-------------------------------------------------------------------------------
-- 1. Main size.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "1", function()
  local window = hs.window.focusedWindow()
  local frame = window:frame()
  local screen = window:screen():frame()

  frame.x = 0
  frame.y = 0
  frame.w = 1321
  frame.h = screen.h
  window:setFrame(frame)
end)

-------------------------------------------------------------------------------
-- 2. Alternative main size.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "2", function()
  local window = hs.window.focusedWindow()
  local frame = window:frame()
  local screen = window:screen():frame()

  frame.x = 0
  frame.y = 0
  frame.w = 1160
  frame.h = screen.h
  window:setFrame(frame)
end)

-------------------------------------------------------------------------------
-- 3. Finder.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "3", function()
  local window = hs.window.focusedWindow()
  local frame = window:frame()
  local screen = window:screen():frame()

  frame.x = 104
  frame.y = 0
  frame.w = 1160 - frame.x
  frame.h = screen.h
  window:setFrame(frame)
end)

-------------------------------------------------------------------------------
-- 4. Messages.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "4", function()
  local window = hs.window.focusedWindow()
  local frame = window:frame()
  local screen = window:screen():frame()
  local margin = 279

  frame.x = screen.x + margin
  frame.y = 97
  frame.w = screen.w - (margin * 2) - 1
  frame.h = 577
  window:setFrame(frame)
end)

-------------------------------------------------------------------------------
-- 5. Transmission.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "5", function()
  local window = hs.window.focusedWindow()
  local frame = window:frame()
  local screen = window:screen():frame()
  local margin = 468

  frame.x = screen.x + margin
  frame.y = 97
  frame.w = screen.w - (margin * 2) - 1
  frame.h = 657
  window:setFrame(frame)
end)

-------------------------------------------------------------------------------
-- 6. Maximize window (and revert).
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "6", function()
  hs.window.focusedWindow():maximize()
end)

-------------------------------------------------------------------------------
-- 7. Move window to center.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "7", function()
  local window = hs.window.focusedWindow()
  local frame = window:frame()
  local screen = window:screen():frame()

  frame.x = (screen.w / 2) - (frame.w / 2)
  frame.y = (screen.h / 2) - (frame.h / 2)
  window:setFrame(frame)
end)

-------------------------------------------------------------------------------
-- 8. Move and resize window 50% left (and revert).
-------------------------------------------------------------------------------
local frameLeftCache = {}

hs.hotkey.bind(preKeys, "8", function()
  local window = hs.window.focusedWindow()

  if frameLeftCache[window:id()] then
    window:setFrame(frameLeftCache[window:id()])
    frameLeftCache[window:id()] = nil
  else
    frameLeftCache[window:id()] = window:frame()
    window:focusedWindow():moveToUnit(hs.layout.left50)
  end
end)

-------------------------------------------------------------------------------
-- 9. Move and resize window 50% right (and revert).
-------------------------------------------------------------------------------
local frameRightCache = {}

hs.hotkey.bind(preKeys, "9", function()
  local window = hs.window.focusedWindow()

  if frameRightCache[window:id()] then
    window:setFrame(frameRightCache[window:id()])
    frameRightCache[window:id()] = nil
  else
    frameRightCache[window:id()] = window:frame()
    window:focusedWindow():moveToUnit(hs.layout.right50)
  end
end)

-------------------------------------------------------------------------------
-- 0. Move window to the top left.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "0", function()
  hs.window.focusedWindow():setTopLeft(0,0)
end)

-------------------------------------------------------------------------------
-- +. Move window to the top left.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "+", function()
  local window = hs.window.focusedWindow()
  local frame = window:frame()
  local screen = window:screen():frame()

  frame.x = screen.w - frame.w
  window:setFrame(frame)
end)
