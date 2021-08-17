-- Press shift while dragging a window, and it will snap it (according to the
-- medium grid in windows.lua)

local wm = require('windows')

local drawing = require'hs.drawing'
local myScreen

function myScreen()
   return hs.mouse.getCurrentScreen()
end

local function getWindowUnderMouse()
   local _ = hs.application

   local pos = hs.geometry.new(hs.mouse.absolutePosition())

   return hs.fnutils.find(hs.window.orderedWindows(), function(w)
   return myScreen() == w:screen() and pos:inside(w:frame())
   end)
end

DraggingWin = nil



Left3rd, Right3rd, Centre3rd = nil, nil, nil
HalfLeft, HalfRight, CentreTarget =  nil, nil, nil

local function getCells()
   local myScreen = myScreen()
   local ACTIVE_AREA = myScreen:fullFrame()['w']/16

   Left3rd = hs.grid.getCell(wm.screenPositions.mediumSideLeft, myScreen)
   Left3rd['x'] = Left3rd['x'] + ACTIVE_AREA
   Left3rd['w'] = Left3rd['w'] - ACTIVE_AREA
   Right3rd = hs.grid.getCell(wm.screenPositions.mediumSideRight, myScreen)
   Right3rd['w'] = Right3rd['w'] - ACTIVE_AREA

   Centre3rd = hs.grid.getCell(wm.screenPositions.mediumCentre, myScreen)
   CentreTarget = hs.grid.getCell(wm.screenPositions.mediumCentre, myScreen)
   CentreTarget['x'] = CentreTarget['x']+CentreTarget['w']/2-ACTIVE_AREA
   CentreTarget['w']=2*ACTIVE_AREA
   CentreTarget['y'] = CentreTarget['y']+CentreTarget['h']/2-ACTIVE_AREA
   CentreTarget['h']=2*ACTIVE_AREA

   HalfLeft = hs.grid.getCell(wm.screenPositions.halfLeft, myScreen)
   HalfLeft['w'] = ACTIVE_AREA
   HalfRight = hs.grid.getCell(wm.screenPositions.halfRight, myScreen)
   HalfRight['x'] = Right3rd['x'] + Right3rd['w']
   HalfRight['w'] = ACTIVE_AREA
end


DragEvent = hs.eventtap.new({ hs.eventtap.event.types.leftMouseUp }, function(e)
if DraggingWin then
   local mousePos = hs.geometry.new(hs.mouse.getAbsolutePosition())
   local leftClick = hs.mouse.getButtons()["left"]
   local x  = mousePos.x
   local y = mousePos.y
   local left3rdStart = Left3rd['x']
   local left3rdEnd = Left3rd['x'] + Left3rd['w']
   local right3rdStart = Right3rd['x']
   local right3rdEnd = right3rdStart + Right3rd['w']
   local centre3rdStart = Centre3rd['x']
   local centre3rdEnd = Centre3rd['x'] + Centre3rd['w']
   local halfLeftStart = HalfLeft['x']
   local halfLeftEnd = HalfLeft['x'] + HalfLeft['w']
   local halfRightStart = HalfRight['x']
   local halfRightEnd = HalfRight['x'] + HalfRight['w']
   local centreTargetStartX = CentreTarget['x']
   local centreTargetEndX = CentreTarget['x']+CentreTarget['w']
   local centreTargetStartY = CentreTarget['y']
   local centreTargetEndY = CentreTarget['y']+CentreTarget['h']

   local destination = nil
   if centre3rdStart < x and x < centre3rdEnd then
      print("Resize now centre")
      if centreTargetStartX < x and x < centreTargetEndX and centreTargetStartY < y and y < centreTargetEndY then
         destination = wm.screenPositions.fullScreen
      else
         destination = wm.screenPositions.mediumCentre
      end
   end
   if  left3rdStart < x and x < left3rdEnd then
      print("Resize now 3rd left")
      destination = wm.screenPositions.mediumSideLeft
   end
   if right3rdStart < x and x < right3rdEnd then
      print("Resize now right")
      destination = wm.screenPositions.mediumSideRight
   end
   if right3rdEnd < x then
      print("Resize now side right")
      destination = wm.screenPositions.halfRight
   end
   if x < halfLeftEnd then
      print("Resize now side left")
      destination = wm.screenPositions.halfLeft
   end
   if destination then
      hs.timer.doAfter(0.1, function() wm.moveWindowToPosition(destination) end)
   end
   DraggingWin = nil
   Grid(false)
   DragEvent:stop()
end
return nil
end)

HLLeft3rd, HLRight3rd, HLCentre3rd = nil, nil, nil
HLLeftHalf, HLRightHalf, HLCentreTarget = nil, nil, nil
GridShown = false

local function getColor(t, maxAlpha)
   maxAlpha = maxAlpha or false
   if t.red then
      return t
   else
      local alpha = t[4]/255.0 or 1
      if maxAlpha then
         alpha = 1
      end
      return {red=t[1]/255.0 or 0,green=t[2]/255.0 or 0,blue=t[3]/255.0 or 0,alpha=alpha}
   end
end

function Grid(show)
   if GridShown and show then
      print("Grid already visible")
      return
   end
   local function showHighlight(color, cell, stroke)
      stroke = stroke or 3
      local highlight = drawing.rectangle(cell)
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
   local alpha = 50
   local factor = 2
   local greenA = {133, 153, 0, alpha*factor}
   local blueA = {38, 139, 210, alpha*factor}
   local orangeA = {203, 75, 22, alpha*factor}
   local magentaA = {211,  54, 130, alpha*factor}
   local cyanA = {42, 161, 152, alpha*factor}
   local darkA = {30, 30, 30, alpha*factor}
   if show then
      print("Show grid")
      HLLeft3rd = showHighlight(orangeA, Left3rd)
      HLRight3rd = showHighlight(cyanA, Right3rd)
      HLCentre3rd = showHighlight(magentaA, Centre3rd)
      HLLeftHalf = showHighlight(blueA, HalfLeft)
      HLRightHalf = showHighlight(greenA, HalfRight)
      HLCentreTarget = showHighlight(darkA, CentreTarget)
      GridShown = true
   else
      print("Hide grid")
      if HLLeft3rd then
         HLLeft3rd:delete()
         HLLeft3rd = nil
      end
      if HLRight3rd then
         HLRight3rd:delete()
         HLRight3rd = nil
      end
      if HLCentre3rd then
         HLCentre3rd:delete()
         HLCentre3rd = nil
      end
      if HLLeftHalf then
         HLLeftHalf:delete()
         HLLeftHalf= nil
      end
      if HLRightHalf then
         HLRightHalf:delete()
         HLRightHalf = nil
      end
      if HLCentreTarget then
         HLCentreTarget:delete()
         HLCentreTarget = nil
      end
      GridShown = false
   end

end

FlagsEvent = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(e)
local flags = e:getFlags()
local leftClick = hs.mouse.getButtons()['left']
if flags.shift and DraggingWin == nil and leftClick then
   print("Shift triggered")
   DraggingWin = getWindowUnderMouse()
   print("dragging", DraggingWin)
   getCells()
   Grid(true)

   DragEvent:start()
elseif DraggingWin ~= nil and leftClick then
   print("Show grid bceause of drag")
   hs.window.highlight.start()
   DraggingWin = getWindowUnderMouse()
   getCells()
   Grid(true)
   DragEvent:start()
else
   print("Hiding grid, leftClick is ", leftClick)
   getCells()
   Grid(false)
   DragEvent:stop()
   DraggingWin = nil
end
return nil
end)

FlagsEvent:start()