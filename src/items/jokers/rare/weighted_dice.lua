-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "weighted_dice",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy",
		},
	},
	config = { extra = { can_rig = false } },
	rarity = 3,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	cost = 9,
	calculate = function(self, card, context)
		card.ability.extra.can_rig = G.GAME.blind.in_blind

		local eval = function()
			return (card.ability.extra.can_rig and not context.blueprint) and not G.RESET_JIGGLES
		end
		juice_card_until(card, eval, true)

		if context.selling_self and not G.RESET_JIGGLES and not context.blueprint and card.ability.extra.can_rig then
			G.GAME.probabilities.normal = 1e9
			return {
				message = localize("k_mstg_rigged_ex"),
			}
		end
	end,
}

return enable and j or nil
