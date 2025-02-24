-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "outcast",
	config = { extra = { Xmult = 1, bonus = 0.1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus, card.ability.extra.Xmult } }
	end,
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy",
		},
	},
	blueprint_compat = true,
	rarity = 3,
	cost = 10,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if #context.full_hand == #context.scoring_hand then
				card.ability.extra.Xmult = 1
				return {
					message = localize("k_reset"),
				}
			else
				card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.bonus
				return {
					message = localize("k_upgrade_ex"),
				}
			end
		end

		if context.joker_main then
			return {
				Xmult = card.ability.extra.Xmult,
			}
		end
	end,
}

return enable and j or nil
