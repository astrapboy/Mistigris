-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "power_of_three",
	config = { extra = { bonus_xmult = 0.33, current_xmult = 1, odds = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.bonus_xmult, 3, card.ability.extra.current_xmult } }
	end,
	rarity = 3,
	blueprint_compat = true,
	cost = 9,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if mistiutils.rank_count(context.scoring_hand, 3) > 0 and mistiutils.chance("power_of_three", card.ability.extra.odds) then
				card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.bonus_xmult
				return {
					message = localize("k_upgrade_ex"),
				}
			end
		end

		if context.joker_main then
			return {
				Xmult = card.ability.extra.current_xmult,
			}
		end
	end,
}

return enable and j or nil
