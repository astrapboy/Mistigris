-- Diminishing Returns
create_joker({
    key = "diminishingreturns",
    config = { extra = {base_xmult = 3.5, penalty = 0.5}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.base_xmult, card.ability.extra.penalty}}
    end,
    rarity = "C",
    cost = 6,
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    blueprint = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult = card.ability.extra.base_xmult - (card.ability.extra.penalty * #context.full_hand),
            }
        end
    end
})

-- Peeking Joker
create_joker {
    key = "peekingjoker",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    blueprint = true,
    config = { extra = { threshold = 0.6, mult_bonus = 12 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_bonus, card.ability.extra.threshold * 100 } }
    end,
    rarity = "C",
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main and to_big(G.GAME.chips) / to_big(G.GAME.blind.chips) >= to_big(card.ability.extra.threshold) then
            return {
                mult = card.ability.extra.mult_bonus
            }
        end
    end
}

-- Ninja Joker
create_joker {
    key = "ninjajoker",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    blueprint = true,
    config = { extra = { threshold = 0.6, chip_bonus = 150 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chip_bonus, card.ability.extra.threshold * 100 } }
    end,
    rarity = "C",
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main and to_big(G.GAME.chips) / to_big(G.GAME.blind.chips) < to_big(card.ability.extra.threshold) then
            return {
                chips = card.ability.extra.chip_bonus
            }
        end
    end
}

-- Timesheet
create_joker {
    key = "timesheet",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    config = { extra = { money = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,
    blueprint = true,
    rarity = "C",
    cost = 6,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if not context.other_card.timesheeted then
                local othercard = context.other_card
                context.other_card.timesheeted = true
                add_event(function() if othercard then othercard.timesheeted = nil end return true end)
            else
                ease_dollars(card.ability.extra.money)
            end
        end
    end
}

-- Banana Factory
create_joker {
    key = "bananafactory",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    config = { extra = {} },
    blueprint = false,
    rarity = "C",
    cost = 6,
    calculate = function(self, card, context)
        if context.entering_shop and not context.blueprint then
            if not next(SMODS.find_card("j_gros_michel")) and not next(SMODS.find_card("j_cavendish")) and not next(SMODS.find_card("j_showman")) then
                change_shop_size(1)
                local key = G.GAME.pool_flags.gros_michel_extinct and "j_cavendish" or "j_gros_michel"
                local sold_card = SMODS.create_card({set = 'Joker', area = G.shop_jokers, key = key})
                create_shop_card_ui(sold_card, "Joker", G.shop_jokers)
                G.shop_jokers:emplace(sold_card)
                sold_card:start_materialize()
                sold_card:set_cost()
            end
        end

        if context.setting_blind and not context.blueprint then
            change_shop_size(-1)
        end
    end
}