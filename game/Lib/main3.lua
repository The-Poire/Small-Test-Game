--print(_ENV)

love.window.setFullscreen(true)
sw,sh = love.graphics.getDimensions()
t=love.timer.getTime()
MLoadingBar = require("LoadingBar")

bar = MLoadingBar:new( (sw - 750) /2 , (sh - 125 - 25)/2 , 750 , 125 , 25 , function(p,s)return "Loading : "..math.floor(p + 0.5).."/"..s.max end , nil , nil , 50 )

function love.draw()
  bar:draw(love.timer.getTime()-t)
end


function love.keyreleased(key)
  if key == "escape" then
    love.event.quit()
  end
end
