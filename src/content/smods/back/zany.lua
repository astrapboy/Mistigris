-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Back
local b = {
    key = "zany",
    unlocked = true,
    discovered = true,
    apply = function(self, back)
        G.GAME.modifiers.mistigris_boost = true
    end,
}

return b
