-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Joker
local j = {
    key = "hot_potato",
    config = {
        extra = {
            rank = "Ace", base_countdown = 3, countdown = 3, Xmult = 2
        }
    },
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.rank = mistiutils.get_random_rank_thats_in_deck()
        card.ability.extra.countdown = card.ability.extra.base_countdown
    end,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {
                stg.Xmult, localize(stg.rank, "ranks"), stg.countdown
            }
        }
    end,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    rarity = 2,
    cost = 7,
    pools = {
        Food = true,
    },
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main then
            if mistiutils.rank_count(context.scoring_hand, stg.rank) > 0 then
                stg.rank = mistiutils.get_random_rank_thats_in_deck()
                stg.countdown = stg.base_countdown
                return {
                    Xmult = stg.Xmult,
                    message = localize("k_reset")
                }
            else
                stg.countdown = stg.countdown - 1
                if stg.countdown <= 0 then
                    mistiutils.destroy_joker(card)
                    return {
                        message = localize("k_eaten_ex")
                    }
                else
                    return {
                        message = localize { type = 'variable', key = 'a_remaining', vars = { stg.countdown } }
                    }
                end
            end
        end
    end
}

return j
