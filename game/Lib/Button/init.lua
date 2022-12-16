local container = {
  x = 0,
  y = 0,
  w = 100,
  h = 100,
  texture = love.graphics.newImage("Lib/Button/default.png"),
  --Visual effects only
  scale = 1,
  ang = 0
  }


function ptInTriangle(p, p0, p1, p2)
    local dX = p[1]-p2[1]
    local dY = p[2]-p2[2]
    local dX21 = p2[1]-p1[1]
    local dY12 = p1[2]-p2[2]
    local D = dY12*(p0[1]-p2[1]) + dX21*(p0[2]-p2[2])
    local s = dY12*dX + dX21*dY
    local t = (p2[2]-p0[2])*dX + (p0[1]-p2[1])*dY
    if D < 0 then
    	if s <= 0 and t <= 0 and s + t >= D then
    		return true
    	 else
    		return false
    	 end
    else
    	if  s >= 0 and t >= 0 and s + t <= D then
    	 return true
 		else
 			return false
		 end
 	end
 end

function intersecLines(s1, e1, s2, e2)
  local d = (s1[1] - e1[1]) * (s2[2] - e2[2]) - (s1[2] - e1[2]) * (s2[1] - e2[1])
  local a = s1[1] * e1[2] - s1[2] * e1[1]
  local b = s2[1] * e2[2] - s2[2] * e2[1]
  local x = (a * (s2[1] - e2[1]) - (s1[1] - e1[1]) * b) / d
  local y = (a * (s2[2] - e2[2]) - (s1[2] - e1[2]) * b) / d
  return {x, y}
end

function container:newButton(x,y,w,h,texture,vertices,scale)
  
  local this = self  
  setmetatable(this,self)
  
  if vertices then this.custom = true;vertices[#vertices + 1] = vertices[1] end
  vertices = vertices or {
      {x, y, 0,0},
      {x + w, y, 0,1},
      {x + w, y + h, 1,1},
      {x, y + h, 1,0},
      {x, y, 0,0}
    }
  
  --for i = 1,#vertices do print("{ " .. table.concat(vertices[i],", ") .. " }") end
  
  if type(texture) == "string" then
    texture = love.graphics.newImage(texture)
  end
  
  texture:setWrap("repeat")
  
  this["x"] = x or self.x
  this["y"] = y or self.y
  this["w"] = w or self.w
  this["h"] = h or self.h
  this["texture"] = texture or self.texture
  this["ox"] = x or self.x
  this["oy"] = y or self.y
  this["scale"] = scale or self.scale
  
  x = this.x
  y = this.y
  w = this.w
  h = this.h
  
  local mesh = love.graphics.newMesh(vertices,"fan")
  mesh:setTexture(this.texture)
  this.mesh = mesh
  
  if this.custom then this.vertices = vertices end
  --vertices.type = "polygon"
  this.body = vertices--SAT.new_shape(vertices,{position = {x,y}})
  
  return this
end

function container:draw()
  
  local x,y,ox,oy = self.x,self.y,self.ox,self.oy  
  love.graphics.draw(self.mesh,x - ox, y - oy, self.ang, self.scale)
  if not love.draw then love.graphics.present() end
  
end

function container:isHover(Function)
  Function = Function or function(self)return end
  mx,my = love.mouse.getPosition()
  local body,x,y = self.body,self.x,self.y
  local poly = {}
  
  for i = 1,#body do
    poly[#poly + 1] = body[i][1] + x - x/2 + x/10
    poly[#poly + 1] = body[i][2] + y - y/2 + y/10
    --print("{ ",body[i][1],", ",body[i][2]," }")
  end
  
  poly = love.math.triangulate(poly)
  for i = 1,#poly do
    --print("{ "..table.concat(poly[i]," ,").." }")
    local p = poly[i]
    
    --love.graphics.polygon("line",p)
    
    if ptInTriangle({mx,my},{p[1],p[2]},{p[3],p[4]},{p[5],p[6]}) then
      --error("succes")
      Function(self)
      return(true)
    end
  end
  
  --print(#poly)
  return false
end

function container:isPressed(Function,mousestate)
  Function = Function or function(self)return end
  MouseState = MouseState or mousestate
  
  if self:isHover() and (MouseState == 1 or MouseState == 2) then
    Function(self)
    return true
  end
  
  return false
end

function container:isJustPressed(Function,mousestate)
  Function = Function or function(self)return end
  MouseState = MouseState or mousestate

  if self:isHover() and MouseState == 1 then
    Function(self)
    return true
  end
  
  return false
end

function container.relocate(self,x,y)
  --self.mesh:setVertices()
  self.x = x
  self.y = y
end

function container.setRotate(self,ang,angMode)end


--print(polyPoint({{0,0},{10,0},{10,10},{10,0}},5,5))

return container