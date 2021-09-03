local wm = require('windows')
local snappy = require('snappy')

-- Stopped using Hyper so I can use the commands remotely from my iPad, I can't
-- map Hyper there.

k = {"ctrl", "alt"}
ks = {"ctrl", "alt", "shift"}

hs.hotkey.bind(k, "return", function()
  wm.windowMaximize(0)
end)

hs.hotkey.bind(ks, "e", function()
    wm.moveWindowToPosition(wm.screenPositions.halfLeft)
      end)
hs.hotkey.bind(ks, "i", function()
    wm.moveWindowToPosition(wm.screenPositions.halfRight)
end)
hs.hotkey.bind(ks, "n", function()
    wm.moveWindowToPosition(wm.screenPositions.largeSideLeft)
end)
hs.hotkey.bind(ks, "o", function()
    wm.moveWindowToPosition(wm.screenPositions.largeSideRight)
end)
hs.hotkey.bind(k, "e", function()
    wm.moveWindowToPosition(wm.screenPositions.enlargedLeft)
      end)
hs.hotkey.bind(k, "i", function()
    wm.moveWindowToPosition(wm.screenPositions.enlargedRight)
end)
hs.hotkey.bind(ks, "space", function()
    wm.moveWindowToPosition(wm.screenPositions.largeCentre)
end)
hs.hotkey.bind(k, "n", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumSideLeft)
end)
hs.hotkey.bind(k, "l", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumSideTopLeft)
end)
hs.hotkey.bind(k, "k", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumSideBottomLeft)
end)
hs.hotkey.bind(k, "o", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumSideRight)
end)
hs.hotkey.bind(k, ";", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumSideTopRight)
end)
hs.hotkey.bind(k, "/", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumSideBottomRight)
end)
hs.hotkey.bind(k, "space", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumCentre)
end)

hs.hotkey.bind(k, 'd', function()
    -- get the focused window
    local win = hs.window.focusedWindow()
    -- get the screen where the focused window is displayed, a.k.a. current screen
    local screen = win:screen()
    -- compute the unitRect of the focused window relative to the current screen
    -- and move the window to the next screen setting the same unitRect 
    win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
    wm.windowMaximize(0)
  end)