local color = require'theme.color'
local gears = require'gears'

local theme = {
    color = color,
    font = "FiraCode Nerd Font Mono",
    rounded_shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 2)
    end
}

return theme
