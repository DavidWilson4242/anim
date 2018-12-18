local Sprite = {}

function Sprite:new()

    local self = setmetatable({}, {__index = Sprite})
    self.shapes = {}

    return self

end

return Sprite
