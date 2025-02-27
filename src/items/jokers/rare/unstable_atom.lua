-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "unstable_atom",
	config = { extra = { Xmult = 5, sd_odds = 4, xmult_odds = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal, card.ability.extra.xmult_odds, card.ability.extra.Xmult, card.ability.extra.sd_odds } }
	end,
	blueprint_compat = true,
	rarity = 3,
	cost = 9,
	calculate = function(self, card, context)
		if context.joker_main then
			if mistiutils.chance("unstable_atom_xmult", card.ability.extra.xmult_odds) then
				return {
					Xmult = card.ability.extra.Xmult
				}
			end

			if mistiutils.chance("unstable_atom_destroy", card.ability.extra.sd_odds) and not context.blueprint then
				mistiutils.destroy_joker(card)
				return {
					message = localize("k_mstg_combust_ex")
				}
			else
				if not context.blueprint then
					return {
						message = localize("k_safe_ex")
					}
				end
			end
		end
	end
}

return enable and j or nil
