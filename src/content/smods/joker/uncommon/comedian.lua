-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Joker
local j = {
    key = "comedian",
    blueprint_compat = true,
    config = { extra = { retriggers = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { 6, 7, 8, 9 } }
    end,
    rarity = 2,
    cost = 6,
    calculate = function(self, card, context)
        local retrigger_ranks = { "6", "7", "8", "9" }
        if context.repetition and mistiutils.matches_rank(context.other_card, retrigger_ranks) then
            return {
                message = localize("k_again_ex"),
                repetitions = card.ability.extra.retriggers,
            }
        end
    end,
}

return j
