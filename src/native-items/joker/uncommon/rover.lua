-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
    key = "rover",
    config = {
        extra = {
            hand = "", Xmult = 1, Xmult_gain = 0.5
        }
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {
                stg.Xmult_gain, localize(stg.hand, "poker_hands"), stg.Xmult
            }
        }
    end,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 6,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.hand = mistiutils.random_hand()
    end,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.mstg_level_up_hand and context.mstg_level_up_hand_name == card.ability.extra.hand and not context.blueprint then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
            return {
                message = localize("k_upgrade_ex")
            }
        end

        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end

        if context.end_of_round and context.cardarea == G.jokers and not context.game_over and not context.blueprint then
            card.ability.extra.hand = mistiutils.random_hand(card.ability.extra.hand)
            return {
                message = localize("k_reset"),
            }
        end
    end
}

return enable and j or nil
