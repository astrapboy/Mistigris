-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
    key = "conscription",
    blueprint_compat = false,
    rarity = 3,
    cost = 11,
    calculate = function(self, card, context)
        local eval = function()
            return (G.GAME.current_round.hands_played == 0 and not context.blueprint) and not G.RESET_JIGGLES
        end
        juice_card_until(card, eval, true)

        if
            context.destroying_card
            and context.cardarea == "unscored"
            and G.GAME.current_round.hands_played == 0
            and not context.blueprint
        then
            return {
                remove = true,
            }
        end
    end,
}

return enable and j or nil
