-- Initialize MistiUtils
local MistiUtils = {}

-- Debug messages
function MistiUtils.print_line(message, logger, printType)
	local functions = {
		["trace"] = sendTraceMessage,
		["debug"] = sendDebugMessage,
		["info"] = sendInfoMessage,
		["warn"] = sendWarnMessage,
		["error"] = sendErrorMessage,
		["fatal"] = sendFatalMessage,
	}
	local printFunc = functions[printType] or sendInfoMessage
	local log = logger or "MistigrisLogger"

	if verbose then
		printFunc("The type of the message variable is [" .. type(message) .. "]", log)
	end
	if type(message) == "table" then
		if depth then
			printFunc(inspectDepth(message), log)
		else
			printFunc(inspect(message), log)
		end
	else
		printFunc(message, log)
	end
end

-- Grabs a random element from a table that's not numerically indexed (e.g. it has elements with strings for keys)
-- It's recommended to do <table>[math.random(#<table>)] instead for numerically-indexed tables as it's more efficient
--- Taken from JenLib
function MistiUtils.random_element(table)
	local index = {}
	for k, v in pairs(table) do
		index[#index + 1] = k
	end
	return table[index[math.random(#index)]]
end

-- Checks how many times a specific rank occurs in played hand
function MistiUtils.rank_count(hand, rank)
	local rank_counter = 0
	for i = 1, #hand do
		if hand[i]:get_id() == rank then
			rank_counter = rank_counter + 1
		end
	end
	return rank_counter
end

-- Checks how many times a played hand contains a rank that's part of a specified table
function MistiUtils.ranks_count(hand, ranks)
	local rank_counter = 0
	for hand_index = 1, #hand do
		for rank_index = 1, #ranks do
			if hand[hand_index]:get_id() == ranks[rank_index] then
				rank_counter = rank_counter + 1
			end
		end
	end
	return rank_counter
end

-- Checks if a card matches a specified table of ranks
function MistiUtils.matches_rank(card, ranks)
	for i = 1, #ranks do
		if card:get_id() == ranks[i] then
			return true
		end
	end
	return false
end

-- Gets tiring to type all the G.E_MANAGER mumbojumbo every time for things that are simple
--- Taken from JenLib
function MistiUtils.add_event(func, delay, timer, trigger, blockable, blocking)
	G.E_MANAGER:add_event(Event({
		timer = timer,
		trigger = trigger or "immediate",
		blocking = blocking or true,
		blockable = blockable,
		func = func,
		delay = delay or 0,
	}))
end

-- Easier way of doing chance rolls
--- Taken from JenLib
function MistiUtils.chance(name, probability, absolute)
	if absolute == nil then
		absolute = true
	end
	return pseudorandom(name) < (absolute and 1 or G.GAME.probabilities.normal) / probability
end

-- Gets most played hand
--- Taken from JenLib
function MistiUtils.fav_hand()
	if not G.GAME or not G.GAME.current_round then
		return "High Card"
	end
	local chosen_hand = "High Card"
	local _handname, _played, _order = "High Card", -1, 100
	for k, v in pairs(G.GAME.hands) do
		if v.played > _played or (v.played == _played and _order > v.order) then
			_played = v.played
			_handname = k
		end
	end
	chosen_hand = _handname
	return chosen_hand
end

-- Gets the second most-played hand
--- Taken from JenLib
function MistiUtils.second_fav_hand()
	if not G.GAME or not G.GAME.current_round then
		return "High Card"
	end
	local chosen_hand = "High Card"
	local firstmost = fav_hand()
	local _handname, _played, _order = "High Card", -1, 100
	for k, v in pairs(G.GAME.hands) do
		if k ~= firstmost and v.played > _played or (v.played == _played and _order > v.order) then
			_played = v.played
			_handname = k
		end
	end
	chosen_hand = _handname
	return chosen_hand
end

-- Gets rank of a hand
--- Taken from JenLib
function MistiUtils.hand_pos(hand)
	local pos = -1
	for i = 1, #G.handlist do
		if G.handlist[i] == hand then
			pos = i
			break
		end
	end
	return pos
end

-- Gets the "adjacent" hands of a hand (a.k.a. the hands above and below the hand you specify according to the poker hand list)
--- Taken from JenLib
function MistiUtils.adjacent_hands(hand)
	local hands = {}
	if not G.GAME or not G.GAME.hands then
		return hands
	end
	local pos = -1
	for k, v in ipairs(G.handlist) do
		if v == hand then
			pos = k
		end
	end
	if pos == -1 then
		return hands
	end
	hands.forehand = G.handlist[pos + 1]
	hands.backhand = G.handlist[pos - 1]
	return hands
end

-- Gets the hand with the lowest level, prioritises lower-ranking hands
--- Taken from JenLib
function MistiUtils.lowest_lvl_hand()
	local chosen_hand = "High Card"
	local lowest_level = math.huge
	for _, v in ipairs(G.handlist) do
		if G.GAME.hands[v].level <= lowest_level then
			chosen_hand = v
			lowest_level = G.GAME.hands[v].level
		end
	end
	return chosen_hand
end

-- Gets the hand with the highest level, prioritises higher-ranking hands
--- Taken from JenLib
function MistiUtils.highest_lvl_hand()
	local chosen_hand = "High Card"
	local highest_level = -math.huge
	for _, v in ipairs(G.handlist) do
		if G.GAME.hands[v].level >= highest_level then
			chosen_hand = v
			highest_level = G.GAME.hands[v].level
		end
	end
	return chosen_hand
end

-- Gets a random hand
--- Taken from JenLib
function MistiUtils.random_hand(ignore, seed, allowhidden)
	local chosen_hand
	ignore = ignore or {}
	seed = seed or "randomhand"
	if type(ignore) ~= "table" then
		ignore = { ignore }
	end
	while true do
		chosen_hand = pseudorandom_element(G.handlist, pseudoseed(seed))
		if G.GAME.hands[chosen_hand].visible or allowhidden then
			local safe = true
			for _, v in pairs(ignore) do
				if v == chosen_hand then
					safe = false
				end
			end
			if safe then
				break
			end
		end
	end
	return chosen_hand
end

-- What Jokers can be destroyed?
function MistiUtils.killable_jokers(self)
	local t = {}
	for i = 1, #G.jokers.cards do
		local j = G.jokers.cards[i]
		if j ~= self and not j.ability["eternal"] and not j.getting_sliced then
			table.insert(t, j)
		end
	end
	return t
end

-- Destroys a Joker (like Gros Michel or Turtle Bean or any of the other food jokers)
function MistiUtils.destroy_joker(card, after)
	MistiUtils.add_event(function()
		play_sound("tarot1")
		card.T.r = -0.2
		card:juice_up(0.3, 0.4)
		card.states.drag.is = true
		card.children.center.pinch.x = true
		MistiUtils.add_event(function()
			G.jokers:remove_card(card)
			card:remove()
			if after and type(after) == "function" then
				after()
			end
			return true
		end, 0.3, nil, "after", false)
		return true
	end)
end

-- Replaces a Joker in the shop at the specified index
function MistiUtils.replace_joker_in_shop(key, index)
	local delete = G.shop_jokers:remove_card(G.shop_jokers.cards[index])
	delete:remove()
	local sold_card = SMODS.create_card({ set = "Joker", area = G.shop_jokers, key = key })
	create_shop_card_ui(sold_card, "Joker", G.shop_jokers)
	G.shop_jokers:emplace(sold_card)
	sold_card:start_materialize()
	sold_card:set_cost()
end

return MistiUtils
