-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "leaky_soda",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy",
		},
	},
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	config = { extra = { mult = 8, mult_penalty = 2, mult_gain = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_penalty, card.ability.extra.mult_gain } }
	end,
	rarity = 2,
	cost = 5,
	pools = {
		Food = true,
	},
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_penalty
			if card.ability.extra.mult <= 0 then
				mistiutils.destroy_joker(card)
				return {
					message = localize("k_drank_ex"),
				}
			else
				return {
					message = localize({
						type = "variable",
						key = "a_mult_minus",
						vars = {
							card.ability.extra.mult_penalty,
						},
					}),
					colour = G.C.MULT,
				}
			end
		end

		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult
				 + card.ability.extra.mult_gain * G.GAME.current_round.hands_left
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { card.ability.extra.mult_gain * G.GAME.current_round.hands_left },
				}),
				colour = G.C.MULT,
			}
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
}

return enable and j or nil
