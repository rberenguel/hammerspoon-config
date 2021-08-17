local This = {}

local GRID_SIZE = 16
local HALF_GRID_SIZE = GRID_SIZE / 2
local MEDIUM_SIDE_GRID_SIZE = 4
local LARGE_SIDE_GRID_SIZE = 5

hs.grid.setGrid(GRID_SIZE .. 'x' .. GRID_SIZE)
hs.grid.setMargins({2, 2})
hs.window.animationDuration = 0

local screenPositions       = {}
screenPositions.fullScreen = {x = 0,              y = 0,              w = GRID_SIZE, h = GRID_SIZE     }
screenPositions.halfLeft        = {x = 0,              y = 0,              w = HALF_GRID_SIZE, h = GRID_SIZE     }
screenPositions.halfRight       = {x = HALF_GRID_SIZE, y = 0,              w = HALF_GRID_SIZE, h = GRID_SIZE     }
screenPositions.halfTop         = {x = 0,              y = 0,              w = GRID_SIZE,      h = HALF_GRID_SIZE}
screenPositions.halfBottom      = {x = 0,              y = HALF_GRID_SIZE, w = GRID_SIZE,      h = HALF_GRID_SIZE}

screenPositions.mediumSideLeft       = {x = 0,              y = 0,              w = MEDIUM_SIDE_GRID_SIZE, h = GRID_SIZE     }
screenPositions.mediumSideRight       = {x = GRID_SIZE - MEDIUM_SIDE_GRID_SIZE,              y = 0,              w = MEDIUM_SIDE_GRID_SIZE, h = GRID_SIZE     }
screenPositions.mediumCentre       = {x = MEDIUM_SIDE_GRID_SIZE,              y = 0,              w = GRID_SIZE - 2*MEDIUM_SIDE_GRID_SIZE, h = GRID_SIZE     }

screenPositions.largeSideLeft       = {x = 0,              y = 0,              w = LARGE_SIDE_GRID_SIZE, h = GRID_SIZE     }
screenPositions.largeSideRight       = {x = GRID_SIZE - LARGE_SIDE_GRID_SIZE,              y = 0,              w = LARGE_SIDE_GRID_SIZE, h = GRID_SIZE     }
screenPositions.largeCentre       = {x = LARGE_SIDE_GRID_SIZE,              y = 0,              w = GRID_SIZE - 2*LARGE_SIDE_GRID_SIZE, h = GRID_SIZE     }


screenPositions.topLeftQuadrant     = {x = 0,              y = 0,              w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}
screenPositions.topRightQuadrant    = {x = HALF_GRID_SIZE, y = 0,              w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}
screenPositions.bottomLeftQuadrant  = {x = 0,              y = HALF_GRID_SIZE, w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}
screenPositions.bottomRightQuadrant = {x = HALF_GRID_SIZE, y = HALF_GRID_SIZE, w = HALF_GRID_SIZE, h = HALF_GRID_SIZE}

This.screenPositions = screenPositions

function This.moveWindowToPosition(cell, window)
  if window == nil then
    print("focusing")
    window = hs.window.focusedWindow()
  end
  if window then
    local screen = window:screen()
    print("setting cell", cell['x'], cell['y'], cell['w'], cell['h'])
    hs.grid.set(window, cell, screen)
  end
end

function This.windowMaximize(factor, window)
   if window == nil then
      window = hs.window.focusedWindow()
   end
   if window then
      window:maximize()
   end
end

return This
