-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
    key = "losing_ticket",
    config = { extra = { money = 5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS["c_wheel_of_fortune"]
        local stg = card.ability.extra
        return { vars = { localize({ type = "name_text", set = "Tarot", key = "c_wheel_of_fortune" }), stg.money } }
    end,
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    calculate = function(self, card, context)
        if context.mstg_wheel_fail then
            ease_dollars(card.ability.extra.money)
        end
    end
}

return enable and j or nil
