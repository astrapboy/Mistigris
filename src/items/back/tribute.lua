-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Back
local b = {
	key = "tribute",
	unlocked = true,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				for k, v in ipairs(G.playing_cards) do
					assert(SMODS.change_base(v, "Spades", "10"))
				end
				return true
			end,
		}))
	end,
}

return enable and b or nil
