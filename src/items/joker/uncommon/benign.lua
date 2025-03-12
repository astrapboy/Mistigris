-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
    key = "benign",
    config = { extra = { repetitions = 1 } },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.repetitions } }
    end,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
            local front = pseudorandom_element(G.P_CARDS, pseudoseed("benign"))

            G.playing_card = (G.playing_card and G.playing_card + 1) or 1

            -- This might be a clunky solution but its the only one that worked so eh
            local c = Card(G.discard.T.x + G.discard.T.w / 2, G.discard.T.y, G.CARD_W, G.CARD_H, front,
                G.P_CENTERS.c_base, { playing_card = G.playing_card })

            assert(SMODS.change_base(c, _, "9"))

            G.E_MANAGER:add_event(Event({
                func = function()
                    c:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                    G.play:emplace(c)
                    table.insert(G.playing_cards, c)
                    return true
                end
            }))

            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                { message = localize('k_mstg_plus_card'), colour = G.C.SECONDARY_SET.Enhanced })

            G.E_MANAGER:add_event(Event({
                func = function()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    return true
                end
            }))

            draw_card(G.play, G.deck, 90, 'up', nil)

            playing_card_joker_effects({ c })
        end

        if context.repetition and context.cardarea == G.play then
            local first_nine = nil
            for k, v in ipairs(G.play.cards) do
                if v:get_id() == 9 then
                    first_nine = v
                    break
                end
            end
            if context.other_card == first_nine then
                return {
                    message = localize("k_again_ex"),
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}

return enable and j or nil
