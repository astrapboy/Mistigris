-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Blind
local b = {
	key = "yew",
	boss = {
		min = 3,
		showdown = false
	},
	boss_colour = HEX("ae65ff"),
	dollars = 5,
	mult = 2,
	discovered = true,
	loc_vars = function(self)
		return {
			vars = {
				G.GAME.probabilities.normal, 4
			}
		}
	end,
	collection_loc_vars = function(self)
		return {
			vars = {
				1, 4
			}
		}
	end,
	disable = function(self)
		for k, v in ipairs(G.hand.cards) do
			if v.facing == "back" then
				v:flip()
			end
		end
		for k, v in pairs(G.playing_cards) do
			v.ability.wheel_flipped = nil
		end
	end,
	stay_flipped = function(self, area, card)
		return mistiutils.chance("yew_flip", 4)
	end,
	modify_hand = function(self)
		for k, v in ipairs(G.hand.cards) do
			v:flip()
		end
		return mult, hand_chips, false
	end,
}

return enable and b or nil
