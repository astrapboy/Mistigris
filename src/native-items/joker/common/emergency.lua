-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
    key = "emergency",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS["m_glass"]
    end,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    cost = 7,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.repetition and SMODS.has_enhancement(context.other_card, "m_glass") then
            return {
                repetitions = 1
            }
        end
        if context.destroying_card and not context.blueprint and context.cardarea == G.play and G.GAME.current_round.hands_left == 0 and SMODS.has_enhancement(context.destroying_card, 'm_glass') then
            return {
                remove = true
            }
        end
    end
}

return enable and j or nil
