local Shape = {}
local classnames = {
    ["rectangle"] = true;
    ["ellipse"] = true;
    ["polygon"] = true;
}

--[[
    all shape properties:
        - root_x int
        - root_y int
        - rotation int
        - color {int r, int g, int b}
        - children {shape0, shape1, ...}
        - parent Shape
        - parent_layer Layer
    shape classes:
        rectangle
            - width int
            - height int
        ellipse
            - rad_x int
            - rad_y int
        polygon
            - x1 int
            - y1 int
            - x2 int
            - y2 int
            - ...
]]



function Shape:new(classname, root_x, root_y, ...)

    assert(classnames[classname])

    local args = {...}

    local self = setmetatable({}, {__index = Shape})
    self.classname = classname
    self.root_x = root_x
    self.root_y = root_y
    self.rotation = 0
    self.color = {
        r = 1;
        g = 1;
        b = 1;
    }
    self.children = {}
    self.parent_layer = nil

    if classname == "rectangle" then
        self.width = args[1]
        self.height = args[2]
    elseif classname == "ellipse" then
        self.rad_x = args[1]
        self.rad_y = args[2]
    elseif classname == "polygon" then
        assert(#args % 2 == 0)
        self.triangles = love.math.triangulate(unpack(args))
    end
    
    return self
end

function Shape:add_child(child)
    child.parent = self
    table.insert(self.children, child)
end

function Shape:set_color(r, g, b)
    if not g and not b then
        -- greyscale
        assert(r)
        self.color.r = r
        self.color.g = r
        self.color.b = r
    else
        -- RGB
        assert(g ~= nil and b ~= nil)
        self.color.r = r
        self.color.g = g
        self.color.b = b
    end
end

function Shape:get_absolute_position()
    if not self.parent then
        return self.root_x, self.root_y
    end
    local px, py = self.parent:get_absolute_position()
    return px + self.root_x, py + self.root_y
end

function Shape:get_size_factor()
    return 1/self.parent_layer.depth
end

function Shape:translate(dx, dy)
    self.root_x = self.root_x + dx
    self.root_y = self.root_y + dy
end

function Shape:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    local x, y = self:get_absolute_position()
    local size_factor = self:get_size_factor()
    if self.classname == "rectangle" then
        love.graphics.rectangle("fill", x, y, self.width*size_factor, self.height*size_factor)
    elseif self.classname == "ellipse" then
        love.graphics.ellipse("fill", x, y, self.rad_x*size_factor, self.rad_y*size_factor)
    elseif self.classname == "polygon" then
        for i, v in ipairs(self.triangles) do
            local translated = {}
            for q, k in ipairs(v) do
                if q % 2 ~= 0 then -- x coordinate
                    translated[q] = v[q] + x
                else -- y coordinate
                    translated[q] = v[q] + y
                end
            end
            love.graphics.polygon("fill", translated)
        end
    end

    for i, v in ipairs(self.children) do
        v:draw()
    end
end

return Shape
