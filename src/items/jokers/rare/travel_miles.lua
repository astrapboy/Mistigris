-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "travel_miles",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy",
		},
	},
	config = { extra = { Xmult = 3, joker_reqs = 12 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.joker_reqs, #G.GAME.mstg.unique_jokers } }
	end,
	blueprint_compat = true,
	rarity = 3,
	cost = 9,
	calculate = function(self, card, context)
		if context.joker_main and #G.GAME.mstg.unique_jokers >= card.ability.extra.joker_reqs then
			return {
				Xmult = card.ability.extra.Xmult
			}
		end
	end
}

return enable and j or nil
