-- Utility Code
local mistiutils = require('mistiutils')
 
--- @type SMODS.Joker
local j = {
    key = "sleepy",
    config = { extra = { xmult_gain = 0.2, xmult_to_pass = 1, nightmared = false } },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {
                stg.xmult_gain,
                localize({ type = "name_text", set = "Joker", key = "j_mstg_awake" }),
                stg.xmult_to_pass,
            },
        }
    end,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    rarity = 1,
    cost = 4,
    calculate = function(self, card, context)
        -- Nightmare!
        if next(SMODS.find_card("j_scary_face")) and not card.ability.extra.nightmared and not context.blueprint then
            card.ability.extra.nightmared = true
            mistiutils.destroy_joker(card, function()
                if G.jokers then
                    local c = SMODS.add_card(mistiutils.new_card_with_other_cards_values(card, "j_mstg_awake"))
                    c.ability.extra.Xmult = card.ability.extra.xmult_to_pass
                    return true
                end
            end)
            return {
                message = localize("k_mstg_nightmare_ex"),
            }
        end

        if
            context.end_of_round
            and context.cardarea == G.jokers
            and not context.game_over
            and not context.blueprint
        then
            card.ability.extra.xmult_to_pass = card.ability.extra.xmult_to_pass + card.ability.extra.xmult_gain
            return {
                message = localize("k_upgrade_ex"),
            }
        end

        if context.selling_self and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.jokers then
                        local c = SMODS.add_card(mistiutils.new_card_with_other_cards_values(card, "j_mstg_awake"))
                        c.ability.extra.Xmult = card.ability.extra.xmult_to_pass
                        return true
                    end
                end
            }))
            return {
                message = localize("k_mstg_wakeup_ex"),
            }
        end
    end,
}

return j
