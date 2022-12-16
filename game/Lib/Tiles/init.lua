local container = {
  tileset = {},
  x = 0,
  y = 0,
  grid = {},
  decorations = {},
  objects = {},
  nil
  }


--local x,y,w,h = 0,0,50,50
--[[local mesh = love.graphics.newMesh({
    {x, y, 0,0},
    {x + w, y, 0,1},
    {x + w, y + h, 1,1},
    {x, y + h, 1,0},
    {x, y, 0,0}
  })]]
local screen_width, screen_height = love.graphics.getDimensions()

local function a(c,i,k)
  print(c.grid[i][k])
end

function container:setGridSize(wx,wy)  
  self.wx = wx
  self.wy = wy or wx  
end

function container:setTiles(tileData)
  
  self.tileset = {}
  print (#tileData)
  for i = 1,#tileData do 
    self.tileset[#self.tileset + 1] = {}
    local v = tileData[i]
    if v.name then
      self.tileset[#self.tileset][1] = v.name
    end
    
    if v.texture then
      if type(v.texture) == "string" then
        self.tileset[#self.tileset][2] = love.graphics.newImage(v.texture)
      else
        self.tileset[#self.tileset][2] = v.texture
      end
    else
      error("Texture is missing")
    end
    
    --v.texture:setWrap("repeat")
    
    local x,y,w,h = 0,0,self.wx,self.wy
    self.tileset[#self.tileset][3] = love.graphics.newMesh({{x, y, 0,0},{x + w, y, 0,1},{x + w, y + h, 1,1},{x, y + h, 1,0},{x, y, 0,0}})
    --self.tileset[#self.tileset][3] = love.graphics.newMesh({{x, y, 1,0},{x + w, y, 1,1},{x + w, y + h, 0,1},{x, y + h, 0,0},{x, y, 1,0}})
    self.tileset[#self.tileset][2]:setFilter("nearest")
    self.tileset[#self.tileset][3]:setTexture(self.tileset[#self.tileset][2])
    --self.tileset[#self.tileset][3]
    
  end
end

function container:draw()
  --local t = self.tileset[1][2]
  --mesh:setTexture(t
  --
  --for j = 1,#self.tileset do
  --  for i = self.x,screen_width --[[+ self.x)]] / self.wx do
  --    for k = self.y,screen_height --[[+ self.y)]] / self.wy do
  --      love.graphics.draw(self.tileset[j][3],self.x - i * self.wx,self.y - k * self.wy)
  --    end
  --  end
  --end
  --]]
  local maxY = math.floor(self.y/self.wy + 0.5)
  if maxY == 0 then maxY = 1 end
  
  local maxX = math.floor(self.x/self.wx + 0.5)
  if maxX == 0 then maxX = 1 end
  
  for i = maxX, math.ceil( screen_width/self.wx ) + math.ceil(self.x/self.wx + 0.5) + 1 do
    --print( screen_height/self.wy )
    --print(self.tileset[1][3])
    
    for k = maxY, math.ceil( screen_height/self.wy ) + math.ceil(self.y/self.wy + 0.5) do
      --love.graphics.draw(self.tileset[self.grid[i][k]][3], i * (self.wx - self.x - 1)--[[  - screen_width / 2]], k * (self.wy - self.y - 1))--  - screen_height / 2)
      --if pcall(a,self,i,k) then
      --print(self.grid[i][k],i,k,"\n")
      if self.grid[i] then if self.grid[i][k] then
        love.graphics.draw(self.tileset[ self.grid[i][k] ][3],(i - 1)* self.wx - self.x, (k - 1)* self.wy - self.y, math.rad(90))
      end end
      
      if self.decorations[i] then if self.decorations[i][k] then
        love.graphics.draw(self.tileset[ self.decorations[i][k] ][3],(i - 1)* self.wx - self.x, (k - 1)* self.wy - self.y, math.rad(90))
      end end
      
      if self.objects[i] then if self.objects[i][k] then
        love.graphics.draw(self.tileset[ self.objects[i][k] ][3],(i - 1)* self.wx - self.x, (k - 1)* self.wy - self.y, math.rad(90))
      end end
      
    end
    --error()
  end
  
  love.graphics.print(self.x,nil,20)
  love.graphics.print(self.y,nil,40)
  --love.graphics.print(tostring(pcall(a,self)),nil,60)
  
  
end


function container:move(dx,dy)
  self.x = self.x + dx
  self.y = self.y + dy
end

function container:setGenFunction(Function)
  self.generate = Function or (function(self,mx,my)for i=1,mx do self.grid[i] = {}; for k=1,my do self.grid[i][k] = 1 end end end)
end


setmetatable(container,container)

return container