-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "ufo",
	config = { extra = { Xmult_add = 0.5 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.Xmult_add, card.ability.extra.Xmult_add * mistiutils.get_unplayed_hand_count_this_run() }
		}
	end,
	blueprint_compat = false,
	rarity = 3,
	cost = 4,
	calculate = function(self, card, context)
		local mult = card.ability.extra.Xmult_add * mistiutils.get_unplayed_hand_count_this_run()
		if context.joker_main and to_big(mult) >= to_big(1) then
			return {
				Xmult = mult
			}
		end
	end
}

return enable and j or nil
