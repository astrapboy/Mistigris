-- Utility Code
local mistiutils = require('mistiutils')
 
--- @type SMODS.Joker
local j = {
    key = "diminishing_returns",
    config = { extra = { base_xmult = 3.5, penalty = 0.5 } },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.base_xmult, stg.penalty } }
    end,
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult = card.ability.extra.base_xmult - (card.ability.extra.penalty * #context.full_hand),
            }
        end
    end,
}

return j
