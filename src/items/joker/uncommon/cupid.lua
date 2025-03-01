-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "cupid",
	config = { extra = { suit1 = "Hearts", suit2 = "Spades", Xmult = 3 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.Xmult, localize(card.ability.extra.suit1, "suits_plural"), localize(
				card.ability.extra.suit2, "suits_plural"),
			}
		}
	end,
	blueprint_compat = true,
	rarity = 2,
	cost = 5,
	calculate = function(self, card, context)
		if context.joker_main then
			local heartCount = 0
			local spadesCount = 0
			for k, v in pairs(G.playing_cards) do
				if v:is_suit("Hearts") then
					heartCount = heartCount + 1
				elseif v:is_suit("Spades") then
					spadesCount =
						 spadesCount + 1
				end
			end

			if heartCount == spadesCount then
				return {
					Xmult = card.ability.extra.Xmult
				}
			end
		end
	end
}

return enable and j or nil
