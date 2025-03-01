-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "plasma",
	config = { extra = { extra_xmult = 6 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.extra_xmult } }
	end,
	rarity = 3,
	blueprint_compat = true,
	cost = 9,
	calculate = function(self, card, context)
		if context.joker_main then
			local smallerNum = math.min(to_number(hand_chips), to_number(mult))
			local biggerNum = math.max(to_number(hand_chips), to_number(mult))
			local bonus_xmult = smallerNum / biggerNum * card.ability.extra.extra_xmult
			if to_big(bonus_xmult) >= to_big(1) then
				return {
					Xmult = bonus_xmult,
				}
			end
		end
	end,
}

return enable and j or nil
