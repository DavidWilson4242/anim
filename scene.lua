local Scene = {}

function Scene:new()
    
    local self = setmetatable({}, {__index = Scene})
    self.layers = {}
    self.camera_x = 0
    self.camera_y = 0
    self.camera_depth = 0

    return self

end

function Scene:add_layer(layer)
    table.insert(self.layers, layer)
    table.sort(self.layers, function(a, b)
        return a.depth > b.depth
    end)
end

function Scene:translate_camera(dx, dy)
    for i, v in ipairs(self.layers) do
        v:translate_shapes(dx/v.depth, dy/v.depth)
    end
end

function Scene:translate_camera_no_shift(dx, dy)
    for i, v in ipairs(self.layers) do
        v:translate_shapes(dx, dy)
    end
end

function Scene:draw()
    for i, v in ipairs(self.layers) do
        v:draw()
    end
end

return Scene
