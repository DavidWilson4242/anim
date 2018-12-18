local Shape = {}
local classnames = {
    ["rectangle"] = true;
    ["ellipse"] = true;
}

--[[
    all shape properties:
        - root_x int
        - root_y int
        - rotation int
        - color {int r, int g, int b}
        - children {shape0, shape1, ...}
        - parent Shape
    shape classes:
        rectangle
            - width int
            - height int
        ellipse
            - rad_x int
            - rad_y int
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

    if classname == "rectangle" then
        self.width = args[1]
        self.height = args[2]
    elseif classname == "ellipse" then
        self.rad_x = args[1]
        self.rad_y = args[2]
    end
    
    return self
end

function Shape:add_child(child)
    child.parent = self
    table.insert(self.children, child)
end

function Shape:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    if self.classname == "rectangle" then
        love.graphics.rectangle("fill", self.root_x, self.root_y, self.width, self.height)
    elseif self.classname == "ellipse" then
        love.graphics.ellipse("fill", self.root_x, self.root_y, self.rad_x, self.rad_y)
    end

    for i, v in ipairs(self.children) do
        v:draw()
    end
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
        assert(g and b)
        self.color.r = r
        self.color.g = g
        self.color.b = b
    end
end

return Shape
