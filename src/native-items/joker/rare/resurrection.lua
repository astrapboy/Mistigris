-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
    key = "resurrection",
    loc_vars = function(self, info_queue, card)
        if G.GAME.mstg.resurrect then
            info_queue[#info_queue + 1] = G.P_CENTERS[G.GAME.mstg.resurrect]
        end
    end,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.selling_self and G.GAME.mstg.resurrect then
            local c = SMODS.add_card(mistiutils.new_card_with_other_cards_values(card, G.GAME.mstg.resurrect))
        end
    end
}

return enable and j or nil
