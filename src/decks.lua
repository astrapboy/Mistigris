-- Placeholder Deck! Meant to test new features
SMODS.Back {
    name = "Placeholder Deck",
    key="phdeck",
    atlas="placeholder",
    pos = { x = 4, y = 2 },
    apply = function(self,back)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.jokers then
                    SMODS.add_card({set = 'Joker', key='j_hack'})
                    SMODS.add_card({set = 'Joker', key='j_mstg_peekingjoker'})
                    SMODS.add_card({set = 'Joker', key='j_mstg_boulder'})
                    SMODS.add_card({set = 'Joker', key='j_mstg_boulder'})
                    SMODS.add_card({set = 'Joker', key='j_mstg_powerofthree'})
                    return true
                end
                return true
            end
        }))
    end
}

-- Root Deck
SMODS.Back {
    name = "Root Deck",
    key="root",
    atlas="placeholder",
    pos = { x = 4, y = 2 },
    apply = function(self, back)
        for k, v in pairs(G.GAME.hands) do
            level_up_hand(self, k, true, 50)
        end
    end,
    calculate = function(self, back, context)
        if context.context == 'final_scoring_step' then
            hand_chips = to_big(math.sqrt(hand_chips))
            mult = to_big(math.sqrt(mult))
            return hand_chips, mult
        end
    end
}