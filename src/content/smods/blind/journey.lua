-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Blind
local bl = {
    key = "journey",
    atlas = "blinds",
    pos = { x = 0, y = 0 },
    boss = { min = 2 },
    boss_colour = HEX("fd9e57"),
    dollars = 5,
    mult = 2,
    debuff_hand = function(self, cards, hand, handname, check)
        if
            to_big(G.GAME.hands[handname].chips) * to_big(G.GAME.hands[handname].mult)
            >= to_big(G.GAME.blind.mstg.min_score)
        then
            return false
        else
            return true
        end
    end,
    modify_hand = function(self, cards, poker_hands, handname, mult, hand_chips)
        if to_big(hand_chips) * to_big(mult) >= to_big(G.GAME.blind.mstg.min_score) then
            G.GAME.blind.mstg.min_score = to_big(hand_chips) * to_big(mult)
        end
        return mult, hand_chips, false
    end,
}

return bl
