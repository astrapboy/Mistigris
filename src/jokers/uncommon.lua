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
            local example_table = G.GAME.hands[G.GAME.current_round.current_hand.handname].example
            local suits = {["S"] = 'Spades', ['H'] = 'Hearts', ['D'] = 'Diamonds', ['C'] = 'Clubs'}
            local cards = {['2'] = 2, ['3'] = 3, ['4'] = 4, ['5'] = 5, ['6'] = 6, ['7'] = 7, ['8'] = 8, ['9'] = 9, ['10'] = 10, ['J'] = 11, ['Q'] = 12, ['K'] = 13, ['A'] = 14}

            local matches_card_count = 0
            local example_card_count = #example_table
            for _, v in ipairs(example_table) do
                local options = {}
                for letter in string.gmatch(v[1], '[^_]+') do
                    table.insert(options, letter)
                end

                local active_suit = suits[options[1]]
                local active_card = cards[options[2]]
                for hand_index = 1, #context.full_hand do
                    if context.full_hand[hand_index]:is_suit(active_suit) and context.full_hand[hand_index]:get_id() == active_card then
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