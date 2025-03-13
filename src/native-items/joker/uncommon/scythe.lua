-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
    key = "scythe",
    config = { extra = { final_hand = "" } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS["c_death"]
        local stg = card.ability.extra
        return { vars = { localize(stg.final_hand, "poker_hands") } }
    end,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.final_hand = mistiutils.random_hand()
    end,
    calculate = function(self, card, context)
        if
            context.end_of_round
            and context.cardarea == G.jokers
            and not context.game_over
        then
            if G.GAME.last_hand_played == card.ability.extra.final_hand then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({ set = "Tarot", key = "c_death" })
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
            end

            if not context.blueprint then
                card.ability.extra.final_hand = mistiutils.random_hand(card.ability.extra.final_hand)
                return {
                    message = localize("k_reset"),
                }
            end
        end
    end,
}

return enable and j or nil
