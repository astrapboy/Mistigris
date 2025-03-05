-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Blind
local b = {
	key = "journey",
	dollars = 5,
	mult = 2,
	boss = { min = 1 },
	boss_colour = HEX("fd9e57"),
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
}

return enable and b or nil
