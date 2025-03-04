-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "boulder",
	config = { extra = { reroll_bonus = 1, reroll_total = 0, reroll_max = 10, win_reroll = true } },
	loc_vars = function(self, info_queue, card)
		local stg = card.ability.extra
		return {
			vars = { stg.reroll_bonus, stg.reroll_max, stg.reroll_total },
		}
	end,
	rarity = 2,
	blueprint_compat = false,
	cost = 7,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.round_resets.free_rerolls = G.GAME.round_resets.free_rerolls + card.ability.extra.reroll_total
		calculate_reroll_cost(true)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.round_resets.free_rerolls = G.GAME.round_resets.free_rerolls - card.ability.extra.reroll_total
		calculate_reroll_cost(true)
	end,
	calculate = function(self, card, context)
		if context.starting_shop then
			card.ability.extra.win_reroll = true
		end

		if context.reroll_shop and not context.blueprint then
			card.ability.extra.win_reroll = false
			if not G.GAME.current_round.caught_reroll and card.ability.extra.reroll_total > 0 then
				G.GAME.current_round.caught_reroll = true
				card.ability.extra.reroll_total = card.ability.extra.reroll_total - 1
				G.GAME.round_resets.free_rerolls = G.GAME.round_resets.free_rerolls - 1
				calculate_reroll_cost(true)
			end
		end

		if
			 context.ending_shop
			 and card.ability.extra.reroll_total < card.ability.extra.reroll_max
			 and card.ability.extra.win_reroll
			 and not context.blueprint
		then
			G.GAME.round_resets.free_rerolls = G.GAME.round_resets.free_rerolls + 1
			calculate_reroll_cost(true)
			card.ability.extra.reroll_total = card.ability.extra.reroll_total + 1
			return {
				message = localize("k_upgrade_ex"),
			}
		end
	end,
}

return enable and j or nil
