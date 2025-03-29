-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Blind
local bl = {
    key = "day",
    atlas = "blinds",
    pos = { x = 0, y = 0 },
    boss = {
        min = 5,
        showdown = false
    },
    boss_colour = HEX("bafee2"),
    dollars = 5,
    mult = 2,
    discovered = true,
    modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
        for k, v in ipairs(G.hand.cards) do
            SMODS.debuff_card(v, true, "mstg_day_blind")
        end
        return mult, hand_chips, true
    end,
    drawn_to_hand = function(self)
        for k, v in ipairs(G.hand.cards) do
            SMODS.debuff_card(v, false, "mstg_day_blind")
        end
    end,
    defeat = function(self)
        for k, v in ipairs(G.playing_cards) do
            SMODS.debuff_card(v, false, "mstg_day_blind")
        end
    end
}

return bl
