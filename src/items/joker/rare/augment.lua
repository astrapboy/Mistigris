-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
    key = "augment",
    atlas = "jokers",
    pos = { x = 8, y = 0 },
    config = { extra = { Xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS["m_gold"]
        local stg = card.ability.extra
        return { vars = { stg.Xmult } }
    end,
    blueprint_compat = true,
    rarity = 3,
    cost = 12,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_gold") and not context.other_card.debuff and not context.end_of_round then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

return enable and j or nil
