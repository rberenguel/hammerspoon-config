local wm = require('windows')
local snappy = require('snappy')

-- Stopped using Hyper so I can use the commands remotely from my iPad, I can't
-- map Hyper there.

k = {"ctrl", "alt"}
ks = {"ctrl", "alt", "shift"}

hs.hotkey.bind(k, "return", function()
  wm.windowMaximize(0)
end)

hs.hotkey.bind(k, "e", function()
    wm.moveWindowToPosition(wm.screenPositions.halfLeft)
      end)
hs.hotkey.bind(k, "i", function()
    wm.moveWindowToPosition(wm.screenPositions.halfRight)
end)
hs.hotkey.bind(ks, "n", function()
    wm.moveWindowToPosition(wm.screenPositions.largeSideLeft)
end)
hs.hotkey.bind(ks, "o", function()
    wm.moveWindowToPosition(wm.screenPositions.largeSideRight)
end)
hs.hotkey.bind(ks, "space", function()
    wm.moveWindowToPosition(wm.screenPositions.largeCentre)
end)
hs.hotkey.bind(k, "n", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumSideLeft)
end)
hs.hotkey.bind(k, "o", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumSideRight)
end)
hs.hotkey.bind(k, "space", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumCentre)
end)