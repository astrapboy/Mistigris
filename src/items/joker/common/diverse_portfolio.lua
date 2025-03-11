-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "diverse_portfolio",
	config = {
		extra = {
			money = 8, win = true
		}
	},
	loc_vars = function(self, info_queue, card)
		local stg = card.ability.extra
		return {
			vars = {
				stg.money
			}
		}
	end,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	calc_dollar_bonus = function(self, card)
		if G.GAME.current_round.mstg_used_hands then
			for k, v in pairs(G.GAME.current_round.mstg_used_hands) do
				if v > 1 then
					return nil
				end
			end

			return card.ability.extra.money
		end
	end
}

return enable and j or nil
