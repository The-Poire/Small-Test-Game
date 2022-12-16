local container = {
  x = 0,
  y = 0,
  w = 100,
  h = 10,
  max = 100,
  prompt = "Loading...",
  colors = { mode = "16bites" , {25,25,25} , {10,252,10} },
  outline = true,
  fontpath = "LoadingBar/consola.ttf",
  font = love.graphics.newFont("LoadingBar/consola.ttf",10),
  nil
}

function container:new(x,y,w,h,max,prompt,colors,outline,fontsize,data)
  local this = self
  setmetatable(this,self)
  
  this.x = x or self.x
  this.y = y or self.y
  this.w = w or self.w
  this.h = h or self.h
  this.max = max or self.max
  this.prompt = prompt or self.prompt
  this.colors = colors or self.colors
  this.outline = outline or self.outline
  this.data = data
  
  --this:draw()
  
  this.font = love.graphics.newFont("LoadingBar/consola.ttf",fontsize or h)
  
  return this
end

function container:draw(value)
  
  local font = self.font
  love.graphics.setFont(font)
  
  if value > self.max then value = self.max end
  
  if self.outline then 
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line",self.x,self.y,self.w,self.h)
  end
  
  if self.colors.mode == "16bites" then
    local c = self.colors[1]
    love.graphics.setColor( c[1] / 255, c[2] / 255  , c[3] / 255)
  else
    love.graphics.setColor(self.colors[1])
  end
  
  love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
  
  
  love.graphics.setColor(1-value/self.max,value/self.max,0)
  love.graphics.rectangle("fill",self.x,self.y,self.w*value/self.max,self.h)
  
  --love.graphics.setColor(0,0,0)
  local c = self.colors[1]
  local prompt = 0--self.prompt
  if type(self.prompt) == "string" then prompt = self.prompt 
  else prompt = self.prompt(value,self) end
  love.graphics.setColor( 1 - c[1] / 255, 1 - c[2] / 255  , 1 - c[3] / 255)
  love.graphics.print(prompt,self.x + (self.w - #prompt * self.font:getWidth("a"))/2 ,self.y + (self.h - self.font:getHeight() * 0.90) /2 )
  
end

return container