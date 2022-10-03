local color = require'theme.color'
require'theme.beautiful_stuff'

local theme = {
    color = color,
    font = "Terminus 10.5",
    wifidisc = os.getenv("HOME") .. "/Pictures/wireless-full.png",
}

return theme
