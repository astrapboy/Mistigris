-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "outcast",
	config = { extra = { Xmult = 1, bonus = 0.05 } },
	loc_vars = function(self, info_queue, card)
		local stg = card.ability.extra
		return { vars = { stg.bonus, stg.Xmult } }
	end,
	blueprint_compat = true,
	rarity = 2,
	cost = 8,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if #context.full_hand ~= #context.scoring_hand then
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
