-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

-- add a sticker to a random joker at end of round

local enable = true

--- @type SMODS.Blind
local b = {
	key = "horse", -- horse walks in?
	boss = {
		min = 1,
		max = 5,
		showdown = false
	},
	boss_colour = HEX("E1AE77"),
	dollars = 5,
	mult = 2,
	discovered = true,
	atlas = "blinds",
	pos = {x = 0},
	defeat = function(self)
		if #G.jokers.cards > 0 then
			local joker = pseudorandom_element(G.jokers.cards, pseudohash("horse"))
			local x = pseudorandom("debuff")
			if x < 0.33 then
				joker:set_perishable(true)
			elseif x < 0.66 then
				joker:set_rental(true)
			else
				joker:set_eternal(true)
			end

			joker:juice_up(0.6)
			play_sound('gold_seal', 1.2, 0.4)
		end
	end
}

return enable and b or nil
