-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Joker
local j = {
    key = "sunk_cost",
    atlas = "jokers",
    pos = { x = 9, y = 0 },
    config = {
        extra = {
            steal = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {
                stg.steal
            }
        }
    end,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.setting_blind and not context.blueprint then
            for k, v in ipairs(G.jokers.cards) do
                if v ~= card then
                    if to_big(v.sell_cost) > to_big(-10) then
                        v.ability.extra_value = v.ability.extra_value - stg.steal
                        v:set_cost()
                        card_eval_status_text(v, "extra", nil, nil, nil, { message = localize("k_mstg_val_down") })
                    end

                    card.ability.extra_value = card.ability.extra_value + stg.steal
                    card:set_cost()
                    card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_val_up") })
                end
            end

            for k, v in ipairs(G.consumeables.cards) do
                if to_big(v.sell_cost) > to_big(-10) then
                    v.ability.extra_value = v.ability.extra_value - stg.steal
                    v:set_cost()
                    card_eval_status_text(v, "extra", nil, nil, nil, { message = localize("k_mstg_val_down") })
                end

                card.ability.extra_value = card.ability.extra_value + stg.steal
                card:set_cost()
                card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_val_up") })
            end
        end
    end
}

return j
