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

-- Up To Eleven
create_joker {
    key = "uptoeleven",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    blueprint = false,
    rarity = "C",
    cost = 6
}