-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistigris.mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "medusa",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS["m_stone"]
	end,
	blueprint_compat = false,
	rarity = 2,
	cost = 7,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local face_count = 0
			for i = 1, #context.scoring_hand do
				local c = context.scoring_hand[i]
				if c:is_face() and not SMODS.has_enhancement(c, "m_stone") then
					face_count = face_count + 1
					c:set_ability(G.P_CENTERS.m_stone, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							c:juice_up()
							return true
						end
					}))
				end
			end
			if face_count ~= 0 then
				return {
					message = localize("k_mstg_stone_ex"),
				}
			end
		end
	end,
}

return enable and j or nil
