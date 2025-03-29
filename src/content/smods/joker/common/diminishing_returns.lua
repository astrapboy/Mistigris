-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Joker
local j = {
    key = "diminishing_returns",
    config = { extra = { base_mult = 30, penalty = 5 } },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.base_mult, stg.penalty } }
    end,
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.base_mult - (card.ability.extra.penalty * #context.full_hand),
            }
        end
    end,
}

return j
