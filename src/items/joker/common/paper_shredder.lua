-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistigris.mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "paper_shredder",
	blueprint_compat = false,
	rarity = 1,
	cost = 6,
	calculate = function(self, card, context)
		if context.destroying_card and not context.blueprint then
			if context.destroy_card.debuff then
				return {
					remove = true
				}
			end
		end
	end,
}

return enable and j or nil
