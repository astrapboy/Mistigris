-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Joker
local j = {
    key = "aiko",
    loc_txt = {
        name = "Aiko's Favourite Joker",
        text = { "If you obtain Chicot,", "{C:attention}destroy{} it" }
    },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    in_pool = function(self, args)
        return false
    end,
    dependencies = {
        "aikoyorisshenanigans"
    },
    cost = 20,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if next(SMODS.find_card("j_chicot")) and not context.blueprint then
            local to_destroy = SMODS.find_card("j_chicot")
            for k, v in ipairs(to_destroy) do
                if not v.getting_sliced then
                    mistiutils.slice_joker(card, v)
                end
            end
        end
    end
}

return j
