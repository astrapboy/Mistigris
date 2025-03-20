-- Utility Code
local mistiutils = require('mistiutils')
 
--- @type SMODS.Joker
local j = {
    key = "wallflower",
    config = {
        extra = {
            Xmult = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {
                stg.Xmult
            }
        }
    end,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main and card == G.jokers.cards[1] then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

return j
