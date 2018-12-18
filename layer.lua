local Layer = {}

function Layer:new(depth)

    local self = setmetatable({}, {__index = Layer})
    self.depth = depth
    self.shapes = {}
    self.offset_x = 0
    self.offset_y = 0
    
    return self

end

function Layer:add_shape(shape)
    shape.parent_layer = self
    table.insert(self.shapes, shape)

    -- set all child parent layers
    local set_child_layers;
    function set_child_layers(parent)
        for i, v in ipairs(parent.children) do
            v.parent_layer = self
            set_child_layers(v)
        end
    end
    set_child_layers(shape)
end

function Layer:translate_shapes(dx, dy)
    self.offset_x = self.offset_x + dx
    self.offset_y = self.offset_y + dy
    for i, v in ipairs(self.shapes) do
        v:translate(dx, dy)
    end
end

function Layer:draw()
    for i, v in ipairs(self.shapes) do
        v:draw()
    end
end

return Layer
