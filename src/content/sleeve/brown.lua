-- Utility Code
local mistiutils = require('mistiutils')

if CardSleeves then
    CardSleeves.Sleeve {
        key = "brown",
        name = "Brown Sleeve Sleeve",
        atlas = "sleeve-ph",
        pos = { x = 0, y = 2 },
        unlocked = true,
        apply = function(self)
            G.GAME.modifiers.no_interest = true
            G.GAME.modifiers.mstg_reroll_limit = true
            G.GAME.round_resets.free_rerolls = 1e6
        end,
    }
end
