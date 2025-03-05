-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "archibald",
	config = {
		extra = {
			ante_penalty = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		local stg = card.ability.extra
		return {
			vars = {
				stg.ante_penalty
			}
		}
	end,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	rarity = 4,
	cost = 6,
	in_pool = function()
		return false
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff and G.GAME.round_resets.ante > 1 then
			ease_ante(-card.ability.extra.ante_penalty)
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.ante_penalty
		end
	end
}

return enable and j or nil
