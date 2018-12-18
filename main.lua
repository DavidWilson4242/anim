local Shape = dofile("shape.lua")
local Sprite = dofile("sprite.lua")

rect = Shape:new("rectangle", 50, 50, 100, 200)
ell = Shape:new("ellipse", 0, 0, 75, 20)

function love.load()
    rect:set_color(1, 0, 0)
    ell:set_color(0, 1, 0)
    rect:add_child(ell)
end

function love.draw()
    rect:draw()
    ell:draw()
end

function love.update(dt)

end
