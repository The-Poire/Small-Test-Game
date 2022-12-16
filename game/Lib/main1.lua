--Lib = require("init")

math.randomseed(os.time())

love.window.setFullscreen(true)

t = 0

MouseState = 0

Mbutton = require("Button")

button = Mbutton:newButton(100,100,300,300,"grass.jpg",{
    {0,0,0,0},
    {125,65,1,0},
    {65,100,1,1},
    {-65,100,0,1}
    })
a = 0

mesh = love.graphics.newMesh({{1,0,0.5,0},{2,1,1,1},{0,1,0,1}})

local function getMouseGetDown(val)
 	if val == 1 and love.mouse.isDown(1) then
 		val = 2
  elseif val == 0 and love.mouse.isDown(1) then
 		val = 1
  elseif val == 2 and not love.mouse.isDown(1) then
 		val = 0
  end
  return val
end

function love.update(dt)
  t = t + dt * 50
  MouseState=getMouseGetDown(MouseState)
  --button:relocate(750 + math.cos(t) * 250, 500 + math.sin(t) * 250)
  --button:relocate(math.random(100,1000),math.random(100,800))
  --love.timer.sleep(1)
  button:relocate(250,250)
end

function love.draw()
  button:draw()
  love.graphics.draw(mesh,500,100)
  love.graphics.print(tostring(button:isHover(--[[ function(self)love.graphics.rectangle("fill",0,0,100,100)end ]])))
  love.graphics.print(tostring(button:isPressed()),nil,20)
  love.graphics.print(tostring(button:isJustPressed(function(self)love.graphics.setColor(math.random(),math.random(),math.random())end)),nil,40)
  love.graphics.print(a,nil,60)
  
  if button:isJustPressed() then
    a = a + 1
  end
  
end

function love.keyreleased(key)
  if key == "escape" then
    love.event.quit()
  end
  
end
