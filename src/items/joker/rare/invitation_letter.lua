-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require('mistigris.mistiutils')
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

			local max_suit = pseudorandom_element(SMODS.Suits, pseudoseed("invitation_letter_create")).key
			local max_count = 0
			for k, v in pairs(suit_count) do
				if v > max_count then
					max_count = v
					max_suit = k
				end
			end

			local copying_card, copying_card_new = mistiutils.get_random_card_in_deck_of_suit(max_suit)
			local c = copy_card(copying_card, nil, nil, copying_card_new)
			c:add_to_deck()
			G.deck.config.card_limit = G.deck.config.card_limit + 1
			table.insert(G.playing_cards, c)
			G.hand:emplace(c)
			c:start_materialize()
			G.GAME.blind:debuff_card(c)
			G.hand:sort()
			playing_card_joker_effects({ c })

			return {
				message = localize('k_copied_ex'),
				colour = G.C.CHIPS,
				playing_cards_created = { true }
			}
		end
	end
}

return enable and j or nil
