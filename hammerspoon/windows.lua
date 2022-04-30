-------------------------
-- Key 1: Large Size 1 --
-------------------------
hs.hotkey.bind(preKeys, "1", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()
  local screen = window:screen():frame()

  frame.y = screen.y
  frame.w = 1250
  frame.h = screen.h
  window:setFrame(frame)
  hs.alert.show("Size 1", alertDuration)
end)

-------------------------
-- Key 2: Large Size 2 --
-------------------------
hs.hotkey.bind(preKeys, "2", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()
  local screen = window:screen():frame()

  frame.y = screen.y
  frame.w = 1050
  frame.h = screen.h
  window:setFrame(frame)
  hs.alert.show("Size 2", alertDuration)
end)

-------------------------
-- Key 3: Large Size 3 --
-------------------------
hs.hotkey.bind(preKeys, "3", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()
  local screen = window:screen():frame()

  frame.y = screen.y
  frame.w = 850
  frame.h = screen.h
  window:setFrame(frame)
  hs.alert.show("Size 3", alertDuration)
end)

------------------------
-- Key 4: Placeholder --
------------------------
hs.hotkey.bind(preKeys, "4", function()
  hs.alert.show("4 - No Action", alertDuration)
end)

-------------------------
-- Key 5: Small Size 1 --
-------------------------
hs.hotkey.bind(preKeys, "5", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()

  frame.w = 900
  frame.h = 600
  window:setFrame(frame)
  hs.alert.show("Size 5", alertDuration)
end)

-------------------------
-- Key 6: Small Size 2 --
-------------------------
hs.hotkey.bind(preKeys, "6", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()

  frame.w = 1000
  frame.h = 750
  window:setFrame(frame)
  hs.alert.show("Size 6", alertDuration)
end)

------------------------
-- Key 7: Placeholder --
------------------------
hs.hotkey.bind(preKeys, "7", function()
  hs.alert.show("7 - No Action", alertDuration)
end)

-----------------------------------------
-- Key 8: Split Window Left, or Revert --
-----------------------------------------
frameCacheLeft = {}

hs.hotkey.bind(preKeys, "8", function()
  local window = hs.window.focusedWindow()

  if frameCacheLeft[window:id()] then
    window:setFrame(frameCacheLeft[window:id()])
    frameCacheLeft[window:id()] = nil
    hs.alert.show("Reverted", alertDuration)
  else
    frameCacheLeft[window:id()] = window:frame()
    window:moveToUnit(hs.layout.left50)
    hs.alert.show("Left Split", alertDuration)
  end
end)

------------------------------------------
-- Key 9: Split Window Right, or Revert --
------------------------------------------
frameCacheRight = {}

hs.hotkey.bind(preKeys, "9", function()
  local window = hs.window.focusedWindow()

  if frameCacheRight[window:id()] then
    window:setFrame(frameCacheRight[window:id()])
    frameCacheRight[window:id()] = nil
    hs.alert.show("Reverted", alertDuration)
  else
    frameCacheRight[window:id()] = window:frame()
    window:moveToUnit(hs.layout.right50)
    hs.alert.show("Right Split", alertDuration)
  end
end)

----------------------------------
-- Key 0: Move Window to Center --
----------------------------------
hs.hotkey.bind(preKeys, "0", function()
  local window = hs.window.focusedWindow()

  window:centerOnScreen()
  hs.alert.show("Centered", alertDuration)
end)

---------------------------------------
-- Key +: Maximize Window, or Revert --
---------------------------------------
frameCacheMax = {}

hs.hotkey.bind(preKeys, "+", function()
  local window = hs.window.focusedWindow()

  if frameCacheMax[window:id()] then
    window:setFrame(frameCacheMax[window:id()])
    frameCacheMax[window:id()] = nil
    hs.alert.show("Reverted", alertDuration)
  else
    frameCacheMax[window:id()] = window:frame()
    window:maximize()
    hs.alert.show("Maximized", alertDuration)
  end
end)

-----------------------------
-- Key h: Move Window Left --
-----------------------------
hs.hotkey.bind(preKeys, "h", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()

  frame.x = frame.x - frameStep
  window:setFrame(frame)
end)

-----------------------------
-- Key j: Move Window Down --
-----------------------------
hs.hotkey.bind(preKeys, "j", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()

  frame.y = frame.y + frameStep
  window:setFrame(frame)
end)

---------------------------
-- Key k: Move Window Up --
---------------------------
hs.hotkey.bind(preKeys, "k", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()

  frame.y = frame.y - frameStep
  window:setFrame(frame)
end)

------------------------------
-- Key l: Move Window Right --
------------------------------
hs.hotkey.bind(preKeys, "l", function()
  local window = hs.window.focusedWindow()
  local frame  = window:frame()

  frame.x = frame.x + frameStep
  window:setFrame(frame)
end)
