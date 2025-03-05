-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Blind
local b = {
	key = "joy",
	dollars = 5,
	mult = 2,
	boss = { min = 3 },
	boss_colour = HEX("334461"),
	disable = function(self)
		G.jokers.mstg_joy_pin = false
	end,
	defeat = function(self)
		G.jokers.mstg_joy_pin = false
	end,
	set_blind = function(self)
		G.jokers.mstg_joy_pin = true
	end,
}

return enable and b or nil
