--debug.debug()

love.window.setFullscreen(true)
math.randomseed(os.time())


Tiles = require("Lib.Tiles")

Tiles:setGridSize(128)
Tiles:setTiles({
    --{name = "grass",texture = "grass.jpg"},
    --{name = "test",texture = "test.jpg"},
    --{name = "test2",texture = "test2.jpg"}
    {texture = "Lib/Pixhole's tileset/MasterSimple18.png"},
    {texture = "Lib/Pixhole's tileset/MasterSimple55.png"},
    {texture = "Lib/Pixhole's tileset/MasterSimple130.png"},
    {texture = "Lib/Pixhole's tileset/MasterSimple24.png"},
    {texture = "Lib/Pixhole's tileset/MasterSimple75.png"},
    nil
})

Tiles:setGenFunction(function( self, mx, my )
    for i = 1,mx do
      self.grid[i] = {}
      self.objects[i] = {}
      for k = 1,my do
        --self.grid[i][k] = math.random(1,4)
        --self.grid[i][k] = nil
        self.grid[i][k] = 1
        --self.grid[i][k] = math.floor(love.math.noise(i,k) + 0.2)%2 + 1
        if math.random()>=0.95 and math.floor(love.math.noise(i,k) + 0.2)%2 + 1 == 1 then
          self.objects[i][k] = 4
        elseif math.random()>=0.95 and math.floor(love.math.noise(i,k) + 0.2)%2 + 1 == 1 then
          self.objects[i][k] = 2
        else
          self.objects[i][k] = 0
        end
        --print(love.math.noise(i,k)%3 + 1)
      end
      --print(table.concat(self.grid[i]))
    end
  end)


Tiles:generate(1000,1000)
--Tiles:move(500*16 + 16,500*16 + 16)
--Tiles:move(0,0)
--print(#Tiles.objects)

x ,y= 1,1--500 + 1,500 + 1

local screen_width, screen_height = love.graphics.getDimensions()

function love.update(dt)

  --Tiles:move(50,50)
  local v = dt / ((1)/60)
  

  local vx,vy = calcmove(v * 0.1)

  print(vx,vy)

  x , y = x+vx , y+vy
  Tiles:move(vx*128,vy*128)

  --[[if love.keyboard.isDown("left") and Tiles.objects[math.floor(x)][math.floor(0.5 + y)] == 0 then
    Tiles:move(-10 * v,0)
    x = x + v-- -10 * v 
  elseif love.keyboard.isDown("right") and Tiles.objects[math.floor(0.5 + x)][math.floor(0.5 + y)] == 0 then
    Tiles:move(10 * v,0)
    x = x + v-- 10 * v
  end

  print(v)--Tiles.objects[math.floor(0.5 + x)][math.floor(0.5 + y)])

  if love.keyboard.isDown("down") and Tiles.objects[math.floor(0.5 + x)][math.floor(0.5 + y)] == 0 then
    Tiles:move(0,10 * v)
    y = y + v-- 10 * v
  elseif love.keyboard.isDown("up") and Tiles.objects[math.floor(0.5 + x)][math.floor(0.5 + y)] == 0 then
    Tiles:move(0,-10 * v)
    y = y + v-- -10 * v
  end]]

  --if Tiles.objects[math.floor(0.5 + x)][math.floor(0.5 + y)] == 1 then Tiles:move()

end

function love.draw()
  Tiles:draw()
  love.graphics.circle("fill",60,60,10)--screen_width/2,screen_height/2,60)

  local a1 = Tiles.objects[math.floor(x)][math.ceil(y)]
  local a2 = Tiles.objects[math.ceil(x)][math.ceil(y)]
  local b1 = Tiles.objects[math.floor(x)][math.floor(y)]
  local b2 = Tiles.objects[math.ceil(x)][math.floor(y)]
  --if a1 == 1


end

function love.keyreleased(key,scancode)
  if key == "escape" then love.event.quit() end
end


function calcmove(v)

  --Pressed keys vars
  local a,b,c,d = 0,0,0,0

  --Get if the key is pressed
  if love.keyboard.isDown("left") then a = 1 
  elseif love.keyboard.isDown("right") then b = 1 end
  if love.keyboard.isDown("down") then c = 1
  elseif love.keyboard.isDown("up") then d = 1 end

  --Objects at the player
  local a1 = Tiles.objects[math.floor(x)][math.ceil(y)]
  local a2 = Tiles.objects[math.ceil(x)][math.ceil(y)]
  local b1 = Tiles.objects[math.floor(x)][math.floor(y)]
  local b2 = Tiles.objects[math.ceil(x)][math.floor(y)]

  --Print objects
  print(a1,a2,b1,b2)

  --Speed vars
  local sx,sy = 0,0

  if a == 1 and a1 == 0 and b1 == 0 then sx = -v end
  if b == 1 and a2 == 0 and b2 == 0 then sx = v end
  if c == 1 and b1 == 0 and b2 == 0 then sy = v end
  if d == 1 and a1 == 0 and a2 == 0 then sy = -v end

  return sx,sy

end