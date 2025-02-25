-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "jenga",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy",
		},
	},
	blueprint_compat = true,
	config = { extra = { base_normal = 1, mult_add = 4, mult = 4, normal = 1, odds = 50 } },
	loc_vars = function(self, table, card)
		return { vars = { card.ability.extra.mult, (G.GAME.probabilities.normal and card.ability.extra.normal * G.GAME.probabilities.normal or card.ability.extra.normal), card.ability.extra.odds, card.ability.extra.mult_add, card.ability.extra.base_normal }, }
	end,
	rarity = 1,
	cost = 4,
	set_ability = function(self, card, initial, delay_sprites)
		if initial then
			card.ability.extra.normal = card.ability.extra.base_normal
			card.ability.extra.mult = card.ability.extra.mult_add
		end
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local is_reset = pseudorandom("jenga") <
				 (card.ability.extra.normal * G.GAME.probabilities.normal) / card.ability.extra.odds;
			if is_reset then
				card.ability.extra.mult = card.ability.extra.mult_add
				card.ability.extra.normal = card.ability.extra.base_normal
				return {
					message = localize("k_reset"),
				}
			else
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_add
				card.ability.extra.normal = card.ability.extra.normal + card.ability.extra.base_normal
				return {
					message = localize("k_upgrade_ex"),
				}
			end
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}

return enable and j or nil
