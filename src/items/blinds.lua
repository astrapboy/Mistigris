-- The Journey
SMODS.Blind({
	key = "journey",
	dollars = 5,
	mult = 2,
	boss = { min = 1 },
	boss_colour = HEX("50bf7c"),
	set_blind = function(self)
		G.GAME.blind.discards_sub = to_big(math.mininteger)
	end,
	modify_hand = function(self, cards, poker_hands, handname, mult, hand_chips)
		if to_big(hand_chips) * to_big(mult) >= to_big(G.GAME.blind.discards_sub) then
			G.GAME.blind.discards_sub = to_big(hand_chips) * to_big(mult)
		end
		return mult, hand_chips, false
	end,
	debuff_hand = function(self, cards, hand, handname, check)
		if
			to_big(G.GAME.hands[handname].chips) * to_big(G.GAME.hands[handname].mult)
			>= to_big(G.GAME.blind.discards_sub)
		then
			return false
		else
			return true
		end
	end,
})
