-- Outcast
create_joker({
    key = "outcast",
    config = {extra = {Xmult = 1, bonus = 0.1}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.bonus, card.ability.extra.Xmult}}
    end,
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    blueprint = true,
    rarity = "R",
    cost = 9,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if #context.full_hand == #context.scoring_hand then
                card.ability.extra.Xmult = 1
                return {
                    message = localize('k_reset')
                }
            else
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.bonus
                return {
                    message = localize('k_upgrade_ex')
                }
            end
        end

        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
})

-- Power of Three
create_joker({
    key = "powerofthree",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    config = { extra = {bonus_xmult = 0.33, current_xmult = 1, target = 3}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.bonus_xmult, card.ability.extra.target, card.ability.extra.current_xmult}}
    end,
    rarity = "R",
    blueprint = true,
    cost = 9,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if rank_count(context.scoring_hand, card.ability.extra.target) > 0 then
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

-- Plasma Joker
create_joker({
    key = "plasmajoker",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    config = { extra = {base_xmult = 1, extra_xmult = 5}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.base_xmult + card.ability.extra.extra_xmult}}
    end,
    rarity = "R",
    blueprint = true,
    cost = 9,
    calculate = function(self, card, context)
        if context.joker_main then
            local smallerNum = math.min(to_number(hand_chips), to_number(mult))
            local biggerNum = math.max(to_number(hand_chips), to_number(mult))
            local bonus_xmult = smallerNum / biggerNum * card.ability.extra.extra_xmult
            return {
                Xmult = bonus_xmult + card.ability.extra.base_xmult
            }
        end
    end
})

-- Weighted Dice
create_joker({
    key = "weighteddice",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    config = { extra = {can_rig = false}},
    rarity = "R",
    blueprint = false,
    eternal = false,
    perishable = false,
    cost = 9,
    calculate = function(self, card, context)
        card.ability.extra.can_rig = G.GAME.blind.in_blind
        
        local eval = function() return (card.ability.extra.can_rig and not context.blueprint) and not G.RESET_JIGGLES end
        juice_card_until(card, eval, true)
        
        if context.selling_self and not G.RESET_JIGGLES and not context.blueprint and card.ability.extra.can_rig then
            G.GAME.probabilities.normal = 1e9
            return {
                message = localize('k_mstg_rigged_ex')
            }
        end
    end
})

-- Conscription
create_joker({
    key = "conscription",
    credits = {
        idea = "astrapboy",
        code = "astrapboy, Khaki & Eremel"
    },
    blueprint = false,
    rarity = "R",
    cost = 9,
    calculate = function(self, card, context)
        local eval = function() return (G.GAME.current_round.hands_played == 0 and not context.blueprint) and not G.RESET_JIGGLES end
        juice_card_until(card, eval, true)
        
        if context.destroying_card and context.cardarea == "unscored" and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            return {
                remove = true
            }
        end
    end
})