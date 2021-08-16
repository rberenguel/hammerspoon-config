-- Press shift while dragging a window, and it will snap it (according to the 
-- medium grid in windows.lua)

wm = require('windows')

local drawing = require'hs.drawing'
local myScreen = hs.mouse.getCurrentScreen()

function getWindowUnderMouse()
  local _ = hs.application

  local pos = hs.geometry.new(hs.mouse.absolutePosition())
  
  return hs.fnutils.find(hs.window.orderedWindows(), function(w)
    return myScreen == w:screen() and pos:inside(w:frame())
  end)
end

draggingWin = nil
draggingMode = 1

local ACTIVE_AREA = 100

local leftMediumCell = hs.grid.getCell(wm.screenPositions.mediumSideLeft, hs.screen.find('LG'))
local rightMediumCell = hs.grid.getCell(wm.screenPositions.mediumSideRight, hs.screen.find('LG'))
local centreMediumCell = hs.grid.getCell(wm.screenPositions.mediumCentre, hs.screen.find('LG'))
local leftMediumCellTop = hs.grid.getCell(wm.screenPositions.mediumSideLeft, hs.screen.find('LG'))
leftMediumCellTop['h'] = ACTIVE_AREA
local rightMediumCellTop = hs.grid.getCell(wm.screenPositions.mediumSideRight, hs.screen.find('LG'))
rightMediumCellTop['h'] = ACTIVE_AREA
local centreMediumCellTop = hs.grid.getCell(wm.screenPositions.mediumCentre, hs.screen.find('LG'))
centreMediumCellTop['h'] = ACTIVE_AREA

dragEvent = hs.eventtap.new({ hs.eventtap.event.types.leftMouseUp }, function(e)
  print("Monitoring drag")
  if draggingWin then
	
	print("And it moves")
    local dx = e:getProperty(hs.eventtap.event.properties.mouseEventDeltaX)
    local dy = e:getProperty(hs.eventtap.event.properties.mouseEventDeltaY)
	local mousePos = hs.geometry.new(hs.mouse.getRelativePosition())
	local leftClick = hs.mouse.getButtons()["left"]
	local x  = mousePos.x
	local y = mousePos.y
	local leftMediumCellX = leftMediumCell['w']
	local rightMediumCellX = rightMediumCell['w'] * 3
	print(leftMediumCellX)
	print(rightMediumCellX)
	
	local destination = nil
	print(x, " ", y)
	if y < ACTIVE_AREA and x > leftMediumCellX and x < rightMediumCellX then
		print("Resize now centre")
		destination = wm.screenPositions.mediumCentre
	end
	if y < ACTIVE_AREA and x < leftMediumCellX then
		print("Resize now left")
		destination = wm.screenPositions.mediumSideLeft
	end
	if y < ACTIVE_AREA and x > rightMediumCellX then
		print("Resize now right")
		destination = wm.screenPositions.mediumSideRight
	end
	if destination then
		hs.timer.doAfter(0.1, function() wm.moveWindowToPosition(destination) end)
	end
	
	draggingWin = nil
	grid(false)
	dragEvent:stop()
	grid(false)
  end
  return nil
end)

hs.grid.ui.textSize = 0

leftHighlight, rightHighlight, centreHighlight, leftHighlightTop, rightHighlightTop, centreHighlightTop = nil
gridShown = false

local function getColor(t, maxAlpha)
	maxAlpha = maxAlpha or false
	if t.red then 
		return t
	else
		alpha = t[4]/255.0 or 1
		if maxAlpha then
			alpha = 1
		end
		return {red=t[1]/255.0 or 0,green=t[2]/255.0 or 0,blue=t[3]/255.0 or 0,alpha=alpha} 
	end
  end

function grid(show)
	print("Toggling grid", show)
	if gridShown and show then
		return
	end
	function showHighlight(color, cell, stroke)
		stroke = stroke or 3
		highlight = drawing.rectangle(cell)
		highlight:setFill(true) highlight:setFillColor(getColor(color, false)) highlight:setStroke(true)

		if stroke ~= 0 then
			highlight:setStrokeColor(getColor(color,true))
		else
			highlight:setStrokeColor(getColor({0, 0, 0, 0}))
		end
			
		highlight:setStrokeWidth(stroke)
		highlight:show()
		return highlight
	end
	alpha = 50
	factor = 2
	orange = {55, 203, 75, alpha}
	magenta = {211,  54, 130, alpha}
	cyan = {42, 161, 152, alpha}
	orangeA = {55, 203, 75, alpha*factor}
	magentaA = {211,  54, 130, alpha*factor}
	cyanA = {42, 161, 152, alpha*factor}
	if show then
		leftHighlight = showHighlight(orange, leftMediumCell)
		rightHighlight = showHighlight(cyan, rightMediumCell)
		centreHighlight = showHighlight(magenta, centreMediumCell)
		leftHighlightTop = showHighlight(orangeA, leftMediumCellTop, 0)
		rightHighlightTop = showHighlight(cyanA, rightMediumCellTop, 0)
		centreHighlightTop = showHighlight(magentaA, centreMediumCellTop, 0)
		gridShown = true
	else 
		if leftHighlight then 
			leftHighlight:delete()
			leftHighlight = nil
		 end
		if rightHighlight then 
			rightHighlight:delete() 
			rightHighlight = nil
		end
		if centreHighlight then 
			centreHighlight:delete()
			centreHighlight = nil
		end
		if leftHighlightTop then 
			leftHighlightTop:delete() 
			leftHighlightTop = nil
		end
		if rightHighlightTop then 
			rightHighlightTop:delete() 
			rightHighlightTop = nil
		end
		if centreHighlightTop then 
			centreHighlightTop:delete() 
			centreHighlightTop = nil
		end
		gridShown = false
	end
	
end

flagsEvent = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(e)
	local flags = e:getFlags()
	local leftClick = hs.mouse.getButtons()['left']
	print("Left clicked?", leftClick)
	if flags.shift and draggingWin == nil and leftClick then
	  draggingWin = getWindowUnderMouse()
	  grid(true)
	  dragEvent:start()
	elseif draggingWin ~= nil and leftClick then
	  hs.window.highlight.start()
	  draggingWin = getWindowUnderMouse()
	  grid(true)
	  dragEvent:start()
	else
		grid(false)
	  dragEvent:stop()
	  draggingWin = nil
	end
	return nil
  end)

flagsEvent:start()