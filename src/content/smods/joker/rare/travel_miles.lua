-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Joker
local j = {
    key = "travel_miles",
    config = { extra = { Xmult = 3, joker_reqs = 12 } },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.Xmult, stg.joker_reqs, #G.GAME.mstg.unique_jokers } }
    end,
    blueprint_compat = true,
    rarity = 3,
    cost = 9,
    calculate = function(self, card, context)
        if context.joker_main and #G.GAME.mstg.unique_jokers >= card.ability.extra.joker_reqs then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

return j
