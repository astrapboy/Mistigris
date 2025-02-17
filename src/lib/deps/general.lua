-- Talisman functions
to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

-- Debug messages
print_line = function(message)
    if verbose then
        sendDebugMessage("The type of the message variable is ["..type(message).."]")
    end
    if type(message) == "table" then
        if depth then
            sendDebugMessage(inspectDepth(message))
        else
            sendDebugMessage(inspect(message))
        end
    else
        sendDebugMessage(message)
    end
end

-- Grabs a random element from a table that's not numerically indexed (e.g. it has elements with strings for keys)
-- It's recommended to do <table>[math.random(#<table>)] instead for numerically-indexed tables as it's more efficient
--- Taken from JenLib
random_element = function(table)
    local index = {}
    for k, v in pairs(table) do
        index[#index + 1] = k
    end
    return table[index[math.random(#index)]]
end

-- Checks how many times a specific rank occurs in played hand
rank_count = function(hand, rank)
    local rank_counter = 0
    for i = 1, #hand do
        if hand[i]:get_id() == rank then rank_counter = rank_counter + 1 end
    end
    return rank_counter
end

-- Checks how many times a played hand contains a rank that's part of a specified table
ranks_count = function(hand, ranks)
    local rank_counter = 0
    for hand_index = 1, #hand do
        for rank_index = 1, #ranks do
            if hand[hand_index]:get_id() == ranks[rank_index] then rank_counter = rank_counter + 1 end
        end
    end
    return rank_counter
end

-- Checks if a card matches a specified table of ranks
matches_rank = function(card, ranks)
    for i = 1, #ranks do
        if card:get_id() == ranks[i] then return true end
    end
    return false
end

-- Gets tiring to type all the G.E_MANAGER mumbojumbo every time for things that are simple
--- Taken from JenLib
add_event = function(func, delay, timer, trigger, blockable, blocking)
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
chance = function(name, probability, absolute)
    if absolute == nil then absolute = true end
    return pseudorandom(name) < (absolute and 1 or G.GAME.probabilities.normal)/probability
end

-- Gets most played hand
--- Taken from JenLib
fav_hand = function()
    if not G.GAME or not G.GAME.current_round then return 'High Card' end
    local chosen_hand = 'High Card'
    local _handname, _played, _order = 'High Card', -1, 100
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
second_fav_hand = function()
    if not G.GAME or not G.GAME.current_round then return 'High Card' end
    local chosen_hand = 'High Card'
    local firstmost = fav_hand()
    local _handname, _played, _order = 'High Card', -1, 100
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
hand_pos = function(hand)
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
adjacent_hands = function(hand)
    local hands = {}
    if not G.GAME or not G.GAME.hands then return hands end
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
lowest_lvl_hand = function()
    local chosen_hand = 'High Card'
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
highest_lvl_hand = function()
    local chosen_hand = 'High Card'
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
random_hand = function(ignore, seed, allowhidden)
    local chosen_hand
    ignore = ignore or {}
    seed = seed or 'randomhand'
    if type(ignore) ~= 'table' then ignore = {ignore} end
    while true do
        chosen_hand = pseudorandom_element(G.handlist, pseudoseed(seed))
        if G.GAME.hands[chosen_hand].visible or allowhidden then
            local safe = true
            for _, v in pairs(ignore) do
                if v == chosen_hand then safe = false end
            end
            if safe then break end
        end
    end
    return chosen_hand
end