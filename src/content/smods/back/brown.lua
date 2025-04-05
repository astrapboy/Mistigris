-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Back
local b = {
    key = "brown",
    unlocked = true,
    discovered = true,
    apply = function(self, back)
        G.GAME.modifiers.no_interest = true
        G.GAME.modifiers.mstg_reroll_limit = true
        G.GAME.round_resets.free_rerolls = 1e6
    end,
}

return b
