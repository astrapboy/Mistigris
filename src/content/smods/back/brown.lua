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
    calculate = function(self, back, context)
        if context.end_of_round then
            G.GAME.current_round.mstg_brown_deck_rerolls = G.GAME.interest_amount *
                math.min(math.floor(to_number(G.GAME.dollars) / 5), G.GAME.interest_cap / 5)
        end

        
    end
}

return b
