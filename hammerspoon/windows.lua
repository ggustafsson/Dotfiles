local frameCache = {}

-------------------------------------------------------------------------------
-- 1. Main size.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "1", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()
  local screen = window:screen():frame()

  frame.y = 0
  frame.w = 1250
  frame.h = screen.h
  window:setFrame(frame)

  hs.alert.show("Size 1", 0.5)
end)

-------------------------------------------------------------------------------
-- 2. Main size 2.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "2", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()
  local screen = window:screen():frame()

  frame.y = 0
  frame.w = 1050
  frame.h = screen.h
  window:setFrame(frame)

  hs.alert.show("Size 2", 0.5)
end)

-------------------------------------------------------------------------------
-- 3. Main size 3.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "3", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()
  local screen = window:screen():frame()

  frame.y = 0
  frame.w = 850
  frame.h = screen.h
  window:setFrame(frame)

  hs.alert.show("Size 3", 0.5)
end)

-------------------------------------------------------------------------------
-- 4. Placeholder.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "4", function()
  hs.alert.show("4 - No Action", 0.5)
end)

-------------------------------------------------------------------------------
-- 5. Small size 1.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "5", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()

  frame.w = 900
  frame.h = 600
  window:setFrame(frame)

  hs.alert.show("Size 5", 0.5)
end)

-------------------------------------------------------------------------------
-- 6. Small size 2.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "6", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()

  frame.w = 1000
  frame.h = 750
  window:setFrame(frame)

  hs.alert.show("Size 6", 0.5)
end)

-------------------------------------------------------------------------------
-- 7. Placeholder.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "7", function()
  hs.alert.show("7 - No Action", 0.5)
end)

-------------------------------------------------------------------------------
-- 8. Move and resize window 50% left.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "8", function()
  local window = hs.window.focusedWindow()

  if frameCache[window:id()] then
    window:setFrame(frameCache[window:id()])
    frameCache[window:id()] = nil
    hs.alert.show("Reverted", 0.5)
  else
    frameCache[window:id()] = window:frame()
    window:moveToUnit(hs.layout.left50)
    hs.alert.show("Left Split", 0.5)
  end
end)

-------------------------------------------------------------------------------
-- 9. Move and resize window 50% right.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "9", function()
  local window = hs.window.focusedWindow()

  if frameCache[window:id()] then
    window:setFrame(frameCache[window:id()])
    frameCache[window:id()] = nil
    hs.alert.show("Reverted", 0.5)
  else
    frameCache[window:id()] = window:frame()
    window:moveToUnit(hs.layout.right50)
    hs.alert.show("Right Split", 0.5)
  end
end)

-------------------------------------------------------------------------------
-- 0. Move window to center.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "0", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()
  local screen = window:screen():frame()

  frame.x = (screen.w / 2) - (frame.w / 2)
  frame.y = (screen.h / 2) - (frame.h / 2)
  window:setFrame(frame)

  hs.alert.show("Centered", 0.5)
end)

-------------------------------------------------------------------------------
-- +. Maximize window.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "+", function()
  local window = hs.window.focusedWindow()

  if frameCache[window:id()] then
    window:setFrame(frameCache[window:id()])
    frameCache[window:id()] = nil
    hs.alert.show("Reverted", 0.5)
  else
    frameCache[window:id()] = window:frame()
    window:maximize()
    hs.alert.show("Maximized", 0.5)
  end
end)
