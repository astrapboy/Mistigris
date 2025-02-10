SMODS.Blind({
    key = 'hill',
    dollars = 5,
    mult = 2,
    boss = {min = 1},
    boss_colour = HEX('50bf7c'),
    config = {extra = {last_hand_score = to_big(math.mininteger)}};
    modify_hand = function(self, cards, poker_hands, handname, mult, hand_chips)
        if to_big(hand_chips) * to_big(mult) >= to_big(self.config.extra.last_hand_score) then
            self.config.extra.last_hand_score = to_big(hand_chips) * to_big(mult)
        end
        return mult, hand_chips, false
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        if to_big(G.GAME.hands[handname].chips) * to_big(G.GAME.hands[handname].mult) >= to_big(self.config.extra.last_hand_score) then return false else return true
        end
    end
})