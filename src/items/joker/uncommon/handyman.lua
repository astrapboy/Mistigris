-- #region UTILITY CODE. KEEP THE SAME ACROSS ALL JOKERS OR I WILL FUCKING KILL YOU
local mistiutils = require("mistigris.mistiutils")
-- #endregion

local enable = true

--- @type SMODS.Joker
local j = {
	key = "handyman",
	blueprint_compat = true,
	config = { extra = { bonus = 6 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
	rarity = 2,
	cost = 5,
	calculate = function(self, card, context)
		if context.joker_main then
			local text = G.FUNCS.get_poker_hand_info(context.full_hand)
			local example_table = G.GAME.hands[text].example
			local suits = { ["S"] = "Spades", ["H"] = "Hearts", ["D"] = "Diamonds", ["C"] = "Clubs" }
			local cards = {
				["2"] = 2,
				["3"] = 3,
				["4"] = 4,
				["5"] = 5,
				["6"] = 6,
				["7"] = 7,
				["8"] = 8,
				["9"] = 9,
				["10"] = 10,
				["J"] = 11,
				["Q"] = 12,
				["K"] = 13,
				["A"] = 14,
			}

			local matches_card_count = 0
			local example_card_count = #example_table
			local cards_to_match = {}
			for _, v in ipairs(example_table) do
				local options = {}
				for letter in string.gmatch(string.upper(v[1]), "[^_]+") do
					table.insert(options, letter)
				end

				local active_suit = suits[options[1]]
				local active_card = cards[options[2]]

				table.insert(cards_to_match, { id = active_card, suit = active_suit, matched = false })
			end

			for card_index = 1, #cards_to_match do
				for hand_index = 1, #context.full_hand do
					if
						 context.full_hand[hand_index]:is_suit(cards_to_match[card_index].suit)
						 and context.full_hand[hand_index]:get_id() == cards_to_match[card_index].id
						 and cards_to_match[card_index].matched == false
					then
						cards_to_match[card_index].matched = true
						matches_card_count = matches_card_count + 1
					end
				end
			end

			if matches_card_count == example_card_count then
				return {
					Xmult = card.ability.extra.bonus,
				}
			end
		end
	end,
}

return enable and j or nil
