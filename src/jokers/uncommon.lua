-- Boulder
create_joker({
    key = "boulder",
    credits = {
        idea = "astrapboy",
        code = "astrapboy & Aiksi Lotl"
    },
    config = { extra = {reroll_bonus = 1, reroll_total = 0, reroll_max = 10, win_reroll = true}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.reroll_bonus, card.ability.extra.reroll_max, card.ability.extra.reroll_total}}
    end,
    rarity = "U",
    blueprint = false,
    cost = 7,
    add = function(self, card, from_debuff)
        G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + card.ability.extra.reroll_total
        calculate_reroll_cost(true)
    end,
    remove = function(self, card, from_debuff)
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
        
        if context.ending_shop and card.ability.extra.reroll_total < card.ability.extra.reroll_max and card.ability.extra.win_reroll and not context.blueprint then
            card.ability.extra.reroll_total = card.ability.extra.reroll_total + 1
            G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
            calculate_reroll_cost(true)
            return {
                message = localize('k_upgrade_ex')
            }
        end
    end
})

-- Comedian
create_joker({
    key = "comedian",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    blueprint = true,
    config = { extra = {retrigger_ranks = {6, 7, 8, 9}, retriggers = 1}},
    loc_vars = function(self, info_queue, card)
        return {vars = {6, 7, 8, 9}}
    end,
    rarity = "U",
    cost = 7,
    calculate = function(self, card, context)
        if context.repetition and matches_rank(context.other_card, card.ability.extra.retrigger_ranks) then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.retriggers
            }
        end
    end
})

-- Handyman
create_joker({
    key = "handyman",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    blueprint = true,
    config = { extra = {bonus = 6}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.bonus}}
    end,
    rarity = "U",
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
            local text = G.FUNCS.get_poker_hand_info(context.full_hand)
            local example_table = G.GAME.hands[text].example
            local suits = {["S"] = 'Spades', ['H'] = 'Hearts', ['D'] = 'Diamonds', ['C'] = 'Clubs'}
            local cards = {['2'] = 2, ['3'] = 3, ['4'] = 4, ['5'] = 5, ['6'] = 6, ['7'] = 7, ['8'] = 8, ['9'] = 9, ['10'] = 10, ['J'] = 11, ['Q'] = 12, ['K'] = 13, ['A'] = 14}

            local matches_card_count = 0
            local example_card_count = #example_table
            local cards_to_match = {}
            for _, v in ipairs(example_table) do
                local options = {}
                for letter in string.gmatch(string.upper(v[1]), '[^_]+') do
                    table.insert(options, letter)
                end

                local active_suit = suits[options[1]]
                local active_card = cards[options[2]]
                
                table.insert(cards_to_match, {id = active_card, suit = active_suit, matched = false})
            end

            for card_index = 1, #cards_to_match do
                for hand_index = 1, #context.full_hand do
                    if context.full_hand[hand_index]:is_suit(cards_to_match[card_index].suit) and context.full_hand[hand_index]:get_id() == cards_to_match[card_index].id and cards_to_match[card_index].matched == false then
                        cards_to_match[card_index].matched = true
                        matches_card_count = matches_card_count + 1
                    end
                end
            end


            if matches_card_count == example_card_count then
                return {
                    Xmult = card.ability.extra.bonus
                }
            end
        end
    end
})

-- Banana Factory
create_joker {
    key = "bananafactory",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    blueprint = false,
    rarity = "U",
    cost = 7,
    calculate = function(self, card, context)
        if context.entering_shop and not context.blueprint then
            if not next(SMODS.find_card("j_gros_michel")) and not next(SMODS.find_card("j_cavendish")) and not next(SMODS.find_card("j_showman")) then
                local delete = G.shop_jokers:remove_card(G.shop_jokers.cards[2])
                delete:remove()
                local key = G.GAME.pool_flags.gros_michel_extinct and "j_cavendish" or "j_gros_michel"
                local sold_card = SMODS.create_card({set = 'Joker', area = G.shop_jokers, key = key})
                create_shop_card_ui(sold_card, "Joker", G.shop_jokers)
                G.shop_jokers:emplace(sold_card)
                sold_card:start_materialize()
                sold_card:set_cost()
            end
            
            return {}
        end
    end
}

-- Conscription
create_joker {
    key = "conscription",
    credits = {
        idea = "astrapboy",
        code = "astrapboy and Khaki"
    },
    blueprint = false,
    rarity = "U",
    cost = 7,
    calculate = function(self, card, context)
        if context.after and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            local safes = {}
            for s_idx = 1, #context.scoring_hand do
                local c = context.scoring_hand[s_idx]
                table.insert(safes, c:get_id())
            end -- full_hand
            for c_idx = 1, #context.full_hand do
                local c = context.full_hand[c_idx]

                local found = false

                for _, id in pairs(safes) do
                    if id == c:get_id() then
                        found = true
                        break
                    end
                end
                
                if not found then
                    add_event(function()
                        if G.jokers then
                            c:juice_up(0.8, 0.8)
                            c:start_dissolve({ HEX("63f06b") }, nil, 1.6)
                            return true
                        end
                    end, nil, nil)
                end
            end
        end
    end
}