-- Initialize MistiUtils
local MistiUtils = require("MistiUtils")

-- Boulder
SMODS.Joker({
	key = "boulder",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy & Aiksi Lotl",
		},
	},
	config = { extra = { reroll_bonus = 1, reroll_total = 0, reroll_max = 10, win_reroll = true } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.reroll_bonus, card.ability.extra.reroll_max, card.ability.extra.reroll_total },
		}
	end,
	rarity = 2,
	blueprint_compat = false,
	cost = 7,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + card.ability.extra.reroll_total
		calculate_reroll_cost(true)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls - card.ability.extra.reroll_total
		calculate_reroll_cost(true)
	end,
	calculate = function(self, card, context)
		if context.entering_shop then
			card.ability.extra.win_reroll = true
		end

		if context.reroll_shop and not context.blueprint then
			card.ability.extra.win_reroll = false
			if not G.GAME.current_round.reroll_shop_context_caught and card.ability.extra.reroll_total > 0 then
				G.GAME.current_round.reroll_shop_context_caught = true
				card.ability.extra.reroll_total = card.ability.extra.reroll_total - 1
			end
		end

		if
			 context.ending_shop
			 and card.ability.extra.reroll_total < card.ability.extra.reroll_max
			 and card.ability.extra.win_reroll
			 and not context.blueprint
		then
			card.ability.extra.reroll_total = card.ability.extra.reroll_total + 1
			G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
			calculate_reroll_cost(true)
			return {
				message = localize("k_upgrade_ex"),
			}
		end
	end,
})

-- Comedian
SMODS.Joker({
	key = "comedian",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy",
		},
	},
	blueprint_compat = true,
	config = { extra = { retriggers = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { 6, 7, 8, 9 } }
	end,
	rarity = 2,
	cost = 6,
	calculate = function(self, card, context)
		local retrigger_ranks = { 6, 7, 8, 9 }
		if context.repetition and MistiUtils.matches_rank(context.other_card, retrigger_ranks) then
			return {
				message = localize("k_again_ex"),
				repetitions = card.ability.extra.retriggers,
			}
		end
	end,
})

-- Handyman
SMODS.Joker({
	key = "handyman",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy",
		},
	},
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
})

-- Banana Factory
SMODS.Joker({
	key = "bananafactory",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy & Autumn",
		},
	},
	loc_vars = function(self, info_queue, card)
		local key = G.GAME.pool_flags.gros_michel_extinct and "j_cavendish" or "j_gros_michel"
		info_queue[#info_queue + 1] = G.P_CENTERS[key]
		return {
			vars = {
				localize({ type = "name_text", set = "Joker", key = key }),
			},
		}
	end,
	blueprint_compat = false,
	rarity = 2,
	cost = 6,
	calculate = function(self, card, context)
		if context.entering_shop and not context.blueprint then
			if
				 not next(SMODS.find_card("j_gros_michel"))
				 and not next(SMODS.find_card("j_cavendish"))
				 and not next(SMODS.find_card("j_ring_master"))
			then
				local key = G.GAME.pool_flags.gros_michel_extinct and "j_cavendish" or "j_gros_michel"
				MistiUtils.replace_joker_in_shop(key, 2)
			end

			return {}
		end
	end,
})

-- Medusa
SMODS.Joker({
	key = "medusa",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy",
		},
	},
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
					MistiUtils.add_event(function()
						c:juice_up()
						return true
					end)
				end
			end
			if face_count ~= 0 then
				return {
					message = localize("k_mstg_stone_ex"),
				}
			end
		end
	end,
})

-- Tortoise
SMODS.Joker({
	key = "tortoise",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy",
		},
	},
	blueprint_compat = true,
	config = { extra = { round_bonus = 0.5, total_bonus = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.round_bonus, card.ability.extra.total_bonus } }
	end,
	rarity = 2,
	cost = 5,
	calculate = function(self, card, context)
		if
			 context.end_of_round
			 and context.cardarea == G.jokers
			 and not context.blueprint
			 and G.GAME.current_round.hands_left == 0
			 and G.GAME.current_round.discards_left == 0
		then
			card.ability.extra.total_bonus = card.ability.extra.total_bonus + card.ability.extra.round_bonus
			return {
				message = localize("k_upgrade_ex"),
			}
		end

		if context.joker_main then
			return {
				Xmult = card.ability.extra.total_bonus,
			}
		end
	end,
})

-- Sacrifice
SMODS.Joker({
	key = "sacrifice",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			art = "Gappie",
			code = "astrapboy",
		},
	},
	atlas = "jokers",
	pos = { x = 0, y = 0 },
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	config = { extra = { bonus_xmult = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus_xmult } }
	end,
	rarity = 2,
	cost = 8,
	calculate = function(self, card, context)
		if context.selling_self and not context.blueprint then
			local victims = MistiUtils.killable_jokers(card)
			local to_destroy = pseudorandom_element(victims, pseudoseed("sacrifice")) or nil
			if to_destroy then
				to_destroy.getting_sliced = true
				MistiUtils.add_event(function()
					to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
					return true
				end)
			end
		end

		if context.joker_main then
			return {
				Xmult = card.ability.extra.bonus_xmult,
			}
		end
	end,
})

-- Leaky Soda
SMODS.Joker({
	key = "leakysoda",
	mstg_vars = {
		credits = {
			idea = "astrapboy",
			code = "astrapboy",
		},
	},
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	config = { extra = { mult = 8, mult_penalty = 2, mult_gain = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_penalty, card.ability.extra.mult_gain } }
	end,
	rarity = 2,
	cost = 5,
	pools = {
		Food = true,
	},
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_penalty
			if card.ability.extra.mult <= 0 then
				MistiUtils.destroy_joker(card)
				return {
					message = localize("k_drank_ex"),
				}
			else
				return {
					message = localize({
						type = "variable",
						key = "a_mult_minus",
						vars = {
							card.ability.extra.mult_penalty,
						},
					}),
					colour = G.C.MULT,
				}
			end
		end

		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult
				 + card.ability.extra.mult_gain * G.GAME.current_round.hands_left
			return {
				message = localize({
					type = "variable",
					key = "a_mult",
					vars = { card.ability.extra.mult_gain * G.GAME.current_round.hands_left },
				}),
				colour = G.C.MULT,
			}
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
})
