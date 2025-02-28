-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "missing_poster",
	config = { extra = { mult = 8 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	blueprint_compat = true,
	rarity = 1,
	cost = 4,
	calculate = function(self, card, context)
		local suits = mistiutils.get_suits(G.play.cards)
		if context.individual and context.cardarea == G.hand and context.other_card:is_face() and not mistiutils.is_any_of_these_suits(context.other_card, suits) then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}

return enable and j or nil
