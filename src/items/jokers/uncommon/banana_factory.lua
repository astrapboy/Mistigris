-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "banana_factory",
	loc_vars = function(self, info_queue, card)
		local key = G.GAME.pool_flags.gros_michel_extinct and "j_cavendish" or "j_gros_michel"
		info_queue[#info_queue + 1] = G.P_CENTERS[key]
		return {
			vars = {
				localize({ type = "name_text", set = "Joker", key = key }),
			},
		}
	end,
	blueprint_compat = false,
	rarity = 2,
	cost = 6,
	calculate = function(self, card, context)
		if context.starting_shop and not context.blueprint then
			if
				 not next(SMODS.find_card("j_gros_michel"))
				 and not next(SMODS.find_card("j_cavendish"))
				 and not next(SMODS.find_card("j_ring_master"))
			then
				local key = G.GAME.pool_flags.gros_michel_extinct and "j_cavendish" or "j_gros_michel"
				mistiutils.replace_joker_in_shop(key, 2)
			end

			return {}
		end
	end,
}

return enable and j or nil
