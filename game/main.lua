Tiles = require("Lib.Tiles")

Tiles:setGridSize(16)
Tiles:setTiles({
    --{name = "grass",texture = "grass.jpg"},
    --{name = "test",texture = "test.jpg"},
    --{name = "test2",texture = "test2.jpg"}
    {texture = "Lib/Pixhole's tileset/MasterSimple18.png"},
    {texture = "Lib/Pixhole's tileset/MasterSimple82.png"},
    {texture = "Lib/Pixhole's tileset/MasterSimple130.png"},
    {texture = "Lib/Pixhole's tileset/MasterSimple24.png"},
    {texture = "Lib/Pixhole's tileset/MasterSimple75.png"},
    nil
})

Tiles:setGenFunction()

Tiles:generate()

local x = 0

function love.update(dt)

end

function love.draw()
    Tiles:draw()
end

function love.keyreleased(key,scancode)
    if key == "escape" then love.event.quit() end
end