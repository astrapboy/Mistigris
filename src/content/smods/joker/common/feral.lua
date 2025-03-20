-- Utility Code
local mistiutils = require('mistiutils')
 
--- @type SMODS.Joker
local j = {
    key = "feral",
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS["m_wild"]
    end,
    rarity = 1,
    cost = 6,
    calculate = function(self, card, context)
        if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
            local front = pseudorandom_element(G.P_CARDS, pseudoseed("feral"))
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local c = Card(G.discard.T.x + G.discard.T.w / 2, G.discard.T.y, G.CARD_W, G.CARD_H, front,
                G.P_CENTERS.m_wild, { playing_card = G.playing_card })

            G.E_MANAGER:add_event(Event({
                func = function()
                    c:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                    G.play:emplace(c)
                    table.insert(G.playing_cards, c)
                    return true
                end
            }))

            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                { message = localize('k_mstg_plus_wild'), colour = G.C.SECONDARY_SET.Enhanced })

            G.E_MANAGER:add_event(Event({
                func = function()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    return true
                end
            }))

            draw_card(G.play, G.deck, 90, 'up', nil)

            playing_card_joker_effects({ c })
        end
    end
}

return j
