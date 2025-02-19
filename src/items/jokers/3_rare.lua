-- Outcast
SMODS.Joker({
    key = "outcast",
    config = {extra = {Xmult = 1, bonus = 0.1}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.bonus, card.ability.extra.Xmult}}
    end,
    mstg_vars = {
        credits = {
            idea = "astrapboy",
            code = "astrapboy"
        }
    },
    blueprint_compat = true,
    rarity = 3,
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
SMODS.Joker({
    key = "powerofthree",
    mstg_vars = {
        credits = {
            idea = "astrapboy",
            code = "astrapboy"
        }
    },
    config = { extra = {bonus_xmult = 0.33, current_xmult = 1, target = 3}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.bonus_xmult, card.ability.extra.target, card.ability.extra.current_xmult}}
    end,
    rarity = 3,
    blueprint_compat = true,
    cost = 9,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if AddixAPI.rank_count(context.scoring_hand, card.ability.extra.target) > 0 then
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
SMODS.Joker({
    key = "plasmajoker",
    mstg_vars = {
        credits = {
            idea = "astrapboy",
            code = "astrapboy"
        }
    },
    config = { extra = {base_xmult = 1, extra_xmult = 5}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.base_xmult + card.ability.extra.extra_xmult}}
    end,
    rarity = 3,
    blueprint_compat = true,
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
SMODS.Joker({
    key = "weighteddice",
    mstg_vars = {
        credits = {
            idea = "astrapboy",
            code = "astrapboy"
        }
    },
    config = { extra = {can_rig = false}},
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
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
SMODS.Joker({
    key = "conscription",
    mstg_vars = {
        credits = {
            idea = "astrapboy",
            code = "astrapboy, Khaki & Eremel"
        }
    },
    blueprint_compat = false,
    rarity = 3,
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

-- Scythe
SMODS.Joker({
    key = "scythe",
    mstg_vars = {
        credits = {
            idea = "astrapboy & 3XPL",
            code = "astrapboy"
        }
    },
    config = { extra = {final_hand = ""}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS["c_death"]
        return {vars = {card.ability.extra.final_hand}}
    end,
    blueprint_compat = false,
    rarity = 3,
    cost = 9,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.final_hand = AddixAPI.random_hand()
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and not context.game_over and not context.blueprint then
            if G.GAME.last_hand_played == card.ability.extra.final_hand then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    AddixAPI.add_event(function() SMODS.add_card({set = "Tarot", key = "c_death"}) G.GAME.consumeable_buffer = 0 return true end)
                end
            end

            card.ability.extra.final_hand = AddixAPI.random_hand(card.ability.extra.final_hand)
            return {
                message = localize('k_reset')
            }
        end
    end
})