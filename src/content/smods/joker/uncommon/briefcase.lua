-- Utility Code
local mistiutils = require('mistiutils')
 
--- @type SMODS.Joker
local j = {
    key = "briefcase",
    config = {
        extra = {
            multiplier = 4,
            can_multiply = false
        }
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {
                stg.multiplier
            }
        }
    end,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        card.ability.extra.can_multiply = G.GAME.blind.in_blind and to_big(G.GAME.chips) > to_big(0)

        local eval = function()
            return (card.ability.extra.can_multiply and not context.blueprint) and not G.RESET_JIGGLES
        end

        juice_card_until(card, eval, true)

        if context.selling_self and card.ability.extra.can_multiply then
            local new_amt = to_big(G.GAME.chips) * to_big(card.ability.extra.multiplier)
            ease_chips(new_amt)
            if new_amt >= to_big(G.GAME.blind.chips) then
                if G.STATE ~= G.STATES.SELECTING_HAND then
                    return
                end
                G.STATE = G.STATES.HAND_PLAYED
                G.STATE_COMPLETE = true
                end_round()
            end
            return {
                message = localize { type = 'variable', key = 'a_mstg_xscore', vars = { card.ability.extra.multiplier } },
            }
        end
    end
}

return j
