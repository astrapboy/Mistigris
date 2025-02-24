-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "timesheet",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy",
		},
	},
	config = { extra = { money = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money } }
	end,
	blueprint_compat = true,
	rarity = 1,
	cost = 6,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual then
			if not context.other_card.timesheeted then
				local c = context.other_card
				context.other_card.timesheeted = true
				mistiutils.add_event(function()
					if c then
						c.timesheeted = nil
					end
					return true
				end)
			else
				ease_dollars(card.ability.extra.money)
			end
		end
	end,
}

return enable and j or nil
