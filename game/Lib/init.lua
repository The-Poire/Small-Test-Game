local MouseGetDown
local Lib = {
  MouseGetDown = 0
}
local Mbutton = require("Button")
local MTiles = require("Tiles")

--[[local function getMouseGetDown(val)
 	if val == 1 and love.mouse.isDown(1) then
 		val = 2
  elseif val == 0 and love.mouse.isDown(1) then
 		val = 1
  elseif val == 2 and not love.mouse.isDown(1) then
 		val = 0
  end
  return val
end]]

function Lib:update()
  self.MouseGetDown = getMouseGetDown(self.MouseGetDown)
end

--return Lib
return {buttonLib = Mbutton,tilesLib = MTiles}