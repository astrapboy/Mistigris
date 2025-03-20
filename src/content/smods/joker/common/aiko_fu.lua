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
    dependencies = {
        "aikoyorisshenanigans"
    },
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if (#G.jokers.cards + G.GAME.joker_buffer) < G.jokers.config.card_limit then
            local chicots_to_create = G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer)
            G.GAME.joker_buffer = G.GAME.joker_buffer + chicots_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for i = 1, chicots_to_create do
                        if G.jokers then
                            local c = SMODS.add_card({ set = "Joker", key = "j_chicot" })
                            G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                        end
                    end
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker')
            }
        end
    end
}

return j
