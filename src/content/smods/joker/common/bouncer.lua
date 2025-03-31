-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Joker
local j = {
    key = "bouncer",
    config = {
        extra = {
            chips = 125, hand = "", fulfilled = false
        }
    },
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.hand = mistiutils.random_hand()
    end,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {
                localize(stg.hand, "poker_hands"), stg.chips
            }
        }
    end,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.pre_discard and not card.ability.extra.fulfilled and not context.blueprint and not context.retrigger_joker then
            local text, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            if text == card.ability.extra.hand then
                card.ability.extra.fulfilled = true
                return {
                    message = localize("k_active_ex")
                }
            end
        end

        if context.joker_main and card.ability.extra.fulfilled then
            return {
                chips = card.ability.extra.chips
            }
        end

        if context.end_of_round and context.cardarea == G.jokers and not context.game_over and not context.blueprint then
            card.ability.extra.fulfilled = false
            card.ability.extra.hand = mistiutils.random_hand(card.ability.extra.hand)
            return {
                message = localize("k_reset")
            }
        end
    end
}

return j
