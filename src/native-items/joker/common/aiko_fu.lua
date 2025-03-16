-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Joker
local j = {
    key = "aiko_fu",
    loc_txt = {
        name = "Aiko's Least Favourite Joker",
        text = { "Fills your Joker slots", "with {C:attention}Chicot{}" }
    },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    in_pool = function(self, args)
        return false
    end,
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if #G.jokers.cards < G.jokers.config.card_limit then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.jokers then
                        local c = SMODS.add_card({ set = "Joker", key = "j_chicot" })
                        return true
                    end
                end
            }))
        end
    end
}

return j
