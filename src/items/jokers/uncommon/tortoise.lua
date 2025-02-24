-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "tortoise",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy",
		},
	},
	blueprint_compat = true,
	config = { extra = { round_bonus = 0.5, total_bonus = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.round_bonus, card.ability.extra.total_bonus } }
	end,
	rarity = 2,
	cost = 5,
	calculate = function(self, card, context)
		if
			 context.end_of_round
			 and context.cardarea == G.jokers
			 and not context.blueprint
			 and G.GAME.current_round.hands_left == 0
			 and G.GAME.current_round.discards_left == 0
		then
			card.ability.extra.total_bonus = card.ability.extra.total_bonus + card.ability.extra.round_bonus
			return {
				message = localize("k_upgrade_ex"),
			}
		end

		if context.joker_main then
			return {
				Xmult = card.ability.extra.total_bonus,
			}
		end
	end,
}

return enable and j or nil
