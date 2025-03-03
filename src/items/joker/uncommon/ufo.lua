-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistigris.mistiutils')
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "ufo",
	atlas = "jokers",
	pos = { x = 4, y = 0 },
	config = { extra = { Xmult_add = 0.5 } },
	loc_vars = function(self, info_queue, card)
		local stg = card.ability.extra
		return {
			vars = { stg.Xmult_add, stg.Xmult_add * mistiutils.get_unplayed_hand_count_this_run() }
		}
	end,
	blueprint_compat = false,
	rarity = 2,
	cost = 8,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			for name, handinfo in pairs(G.GAME.hands) do
				if name == context.scoring_name and handinfo.played == 1 then
					card_eval_status_text(card, "extra", nil, nil, nil,
						{ message = localize { type = 'variable', key = 'a_xmult_minus', vars = { card.ability.extra.Xmult_add } } })
				end
			end
		end

		local mult = card.ability.extra.Xmult_add * mistiutils.get_unplayed_hand_count_this_run()
		if context.joker_main and to_big(mult) >= to_big(1) then
			return {
				Xmult = mult
			}
		end
	end
}

return enable and j or nil
