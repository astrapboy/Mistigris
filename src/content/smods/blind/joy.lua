-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Blind
local bl = {
    key = "joy",
    atlas = "blinds",
    pos = { x = 0, y = 0 },
    boss = { min = 3 },
    boss_colour = HEX("334461"),
    dollars = 5,
    mult = 2,
    set_blind = function(self)
        G.GAME.mstg.joy_pin = true
    end,
    disable = function(self)
        G.GAME.mstg.joy_pin = false
    end,
    defeat = function(self)
        G.GAME.mstg.joy_pin = false
    end,
}

return bl
