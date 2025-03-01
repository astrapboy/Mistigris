-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "invitation_letter",
	atlas = "jokers",
	pos = { x = 7, y = 0 },
	blueprint_compat = true,
	rarity = 3,
	cost = 9,
	calculate = function(self, card, context)
		if context.first_hand_drawn then
			local suit_count = {}
			for k, v in ipairs(G.playing_cards) do
				if not suit_count[v.base.suit] then suit_count[v.base.suit] = 0 end
				suit_count[v.base.suit] = suit_count[v.base.suit] + 1
			end

			local max_suit = ""
			local max_count = 0
			for k, v in pairs(suit_count) do
				if v > max_count then
					max_count = v
					max_suit = k
				end
			end

			mistiutils.add_event(function()
				local c = create_playing_card(
					{ front = mistiutils.get_random_card_in_deck_of_suit(max_suit), center = G.P_CENTERS.c_base }, G.hand, nil,
					nil,
					{ G.C.SECONDARY_SET.Enhanced })
				G.hand:emplace(c)
				c:start_materialize()
				G.GAME.blind:debuff_card(c)
				G.hand:sort()
				if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
				return true
			end)
			playing_card_joker_effects({ c })
		end
	end
}

return enable and j or nil
