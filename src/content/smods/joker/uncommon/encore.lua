-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Joker
local j = {
    key = "encore",
    config = {
        extra = {
            suit = ""
        }
    },
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.suit = pseudorandom_element(SMODS.Suits, pseudoseed("encore")).key or "Spades"
    end,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {
                localize(stg.suit, 'suits_singular'),
                colours = { G.C.SUITS[stg.suit] }
            },
        }
    end,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 8,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and context.other_card:is_suit(card.ability.extra.suit) then
            return {
                message = localize("k_again_ex"),
                repetitions = 1
            }
        end

        if context.end_of_round and context.cardarea == G.jokers and not context.game_over and not context.blueprint then
            local current_suit = card.ability.extra.suit
            local possible_suits = {}
            for k, v in SMODS.Suits do
                if k ~= current_suit then possible_suits[k] = v end
            end
            card.ability.extra.suit = pseudorandom_element(possible_suits, pseudoseed("encore")).key
            return {
                message = localize("k_reset")
            }
        end
    end
}

return j
