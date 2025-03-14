-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Joker
local j = {
    key = "awake",
    config = { extra = { Xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.Xmult } }
    end,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    rarity = 1,
    in_pool = function()
        return false
    end,
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult,
            }
        end
    end,
}

return j
