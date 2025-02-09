-- Power of Three
create_joker({
    name = "Power of Three",
    key = "powerofthree",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    config = { extra = {bonus_xmult = 0.33, current_xmult = 1, card_type = 3}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.bonus_xmult, card.ability.extra.card_type, card.ability.extra.current_xmult}}
    end,
    rarity = "U",
    cost = 7,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if rank_count(context.scoring_hand, card.ability.extra.card_type) > 0 then
                card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.bonus_xmult
                return {
                    message = localize('k_upgrade_ex')
                }
            end
        end

        if context.joker_main then
            return {
                Xmult = card.ability.extra.current_xmult
            }
        end
    end
})

-- Boulder
create_joker({
    name = "Boulder",
    key = "boulder",
    credits = {
        idea = "astrapboy",
        code = "astrapboy & Aiksi Lotl"
    },
    config = { extra = {reroll_bonus = 1, reroll_total = 5, reroll_max = 10, win_reroll = true}},
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
        
        if context.reroll_shop then
            card.ability.extra.win_reroll = false
            if not G.GAME.current_round.reroll_shop_context_caught and card.ability.extra.reroll_total > 0 then
                G.GAME.current_round.reroll_shop_context_caught = true
                card.ability.extra.reroll_total = card.ability.extra.reroll_total - 1
                end
            end
        
        if context.ending_shop and card.ability.extra.reroll_total < card.ability.extra.reroll_max and card.ability.extra.win_reroll then
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
    name = "Comedian",
    key = "comedian",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
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