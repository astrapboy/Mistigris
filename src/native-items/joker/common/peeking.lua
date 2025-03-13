-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
    key = "peeking",
    atlas = "jokers",
    pos = { x = 1, y = 0 },
    blueprint_compat = true,
    config = { extra = { mult = 24 } },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.mult } }
    end,
    rarity = 1,
    cost = 5,
    calculate = function(self, card, context)
        if
            context.joker_main
            and card == G.jokers.cards[#G.jokers.cards]
        then
            return {
                mult = card.ability.extra.mult,
            }
        end
    end,
}

return enable and j or nil
