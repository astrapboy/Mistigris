-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistigris.mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "vortex",
	atlas = "jokers",
	pos = { x = 6, y = 0 },
	config = { extra = { Xmult = 1, Xmult_gain = 0.5 } },
	loc_vars = function(self, info_queue, card)
		local stg = card.ability.extra
		return { vars = { stg.Xmult_gain, stg.Xmult } }
	end,
	blueprint_compat = true,
	rarity = 2,
	cost = 7,
	calculate = function(self, card, context)
		if context.ending_shop then
			if #G.consumeables.cards > 0 and not context.blueprint then
				local victims = mistiutils.killable(card, G.consumeables)
				local to_destroy = pseudorandom_element(victims, pseudoseed("vortex")) or nil
				if to_destroy then
					card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
					G.E_MANAGER:add_event(Event({
						func = function()
							to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
							return true
						end
					}))
					return {
						message = localize("k_upgrade_ex")
					}
				end
			else
				if not context.blueprint then
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('tarot1')
							card:start_dissolve({ G.C.RED }, nil, 1.6)
							return true
						end
					}))
					return {
						message = localize("k_mstg_closed_ex"),
						colour = G.C.RED
					}
				end
			end
		end
	end
}

return enable and j or nil
