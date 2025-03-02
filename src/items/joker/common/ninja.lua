-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "ninja",
	blueprint_compat = true,
	config = { extra = { threshold = 0.6, chip_bonus = 150 } },
	loc_vars = function(self, info_queue, card)
		local stg = card.ability.extra
		return { vars = { stg.chip_bonus, stg.threshold * 100 } }
	end,
	rarity = 1,
	cost = 5,
	calculate = function(self, card, context)
		if
			 context.joker_main
			 and to_big(G.GAME.chips) / to_big(G.GAME.blind.chips) < to_big(card.ability.extra.threshold)
		then
			return {
				chips = card.ability.extra.chip_bonus,
			}
		end
	end,
}

return enable and j or nil
