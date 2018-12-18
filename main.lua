local Shape = dofile("shape.lua")
local Sprite = dofile("sprite.lua")
local Layer = dofile("layer.lua")
local Scene = dofile("scene.lua")

local WIDTH = love.graphics.getWidth()
local HEIGHT = love.graphics.getHeight()

local scene;
local layer_1
local layer_2
local rect_1
local polygon_1
local rect_2

function love.load()
    scene = Scene:new()
    layer_1 = Layer:new(1)
    layer_2 = Layer:new(1.3)
    rect_1 = Shape:new("rectangle", 0, 0, 300, 120)
    polygon_1 = Shape:new("polygon", 0, 0, 0, 0, 100, 0, 150, 50, 100, 100, 0, 100)
    rect_2 = Shape:new("rectangle", 0, 0, 1000, 600)

    rect_1:set_color(0.7, 0.6, 0.2)
    polygon_1:set_color(1, 1, 1)
    rect_2:set_color(0.4, 0.3, 0.8)

    rect_1:add_child(polygon_1)

    layer_1:add_shape(rect_1)
    layer_2:add_shape(rect_2)

    scene:add_layer(layer_1)
    scene:add_layer(layer_2)

    scene:translate_camera_no_shift(WIDTH/2, HEIGHT/2)
end

function love.draw()
    scene:draw()
end

function love.update(dt)

end

function love.keypressed(key)
    if key == "d" then
        scene:translate_camera(10, 0)
    elseif key == "a" then
        scene:translate_camera(-10, 0)
    end
end
