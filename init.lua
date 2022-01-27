local wm = require('windows')
--local snappy = require('snappy')

-- Stopped using Hyper so I can use the commands remotely from my iPad, I can't
-- map Hyper there.

k = {"ctrl", "alt"}
ks = {"ctrl", "alt", "shift"}
ksc = {"ctrl", "alt", "shift", "command"}

hs.hotkey.bind(k, "return", function()
  wm.windowMaximize(0)
end)

hs.hotkey.bind(k, "e", function()
    wm.moveWindowToPosition(wm.screenPositions.halfLeft)
      end)
hs.hotkey.bind(k, "i", function()
    wm.moveWindowToPosition(wm.screenPositions.halfRight)
end)
hs.hotkey.bind(k, "l", function()
    wm.moveWindowToPosition(wm.screenPositions.smallSideLeft)
end)
hs.hotkey.bind(k, ";", function()
    wm.moveWindowToPosition(wm.screenPositions.smallSideRight)
end)
hs.hotkey.bind(k, "u", function()
    wm.moveWindowToPosition(wm.screenPositions.smallSideInnerLeft)
      end)
hs.hotkey.bind(k, "y", function()
    wm.moveWindowToPosition(wm.screenPositions.smallSideInnerRight)
end)
hs.hotkey.bind(k, "n", function()
    wm.moveWindowToPosition(wm.screenPositions.largeSideLeft)
      end)
hs.hotkey.bind(k, "o", function()
    wm.moveWindowToPosition(wm.screenPositions.largeSideRight)
end)
hs.hotkey.bind(k, "space", function()
    wm.moveWindowToPosition(wm.screenPositions.largeCentre)
end)
hs.hotkey.bind(ks, "space", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumCentre)
end)
hs.hotkey.bind(ks, "n", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumSideLeft)
end)
hs.hotkey.bind(ks, "o", function()
    wm.moveWindowToPosition(wm.screenPositions.mediumSideRight)
end)

-- RightGIF magical spoon
-- headers = {}
-- headers['Content-Type'] = 'application/x-www-form-urlencoded'
-- hs.hotkey.bind(k, "g", function()
--     hs.eventtap.keyStroke("cmd", "a")
--     hs.eventtap.keyStroke("cmd", "c")
--     search = hs.pasteboard.getContents()
--     hs.http.asyncPost("https://rightgif.com/search/web", "&text=" .. hs.http.encodeForQuery(search), headers, function(a, b, c)
--         print(b)
--         hs.pasteboard.setContents(hs.json.decode(b)['url'])
--         hs.eventtap.keyStroke("cmd", "v")
--         return
--     end)
-- end)


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
