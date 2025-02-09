-- Diminishing Returns
create_joker({
    name = "Diminishing Returns",
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
    name = "Peeking Joker",
    key = "peekingjoker",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    config = { extra = { threshold = 0.4, mult_bonus = 16 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_bonus, card.ability.extra.threshold * 100 } }
    end,
    rarity = "C",
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main and to_big(G.GAME.chips) / to_big(G.GAME.blind.chips) >= to_big(card.ability.extra.threshold) then
            return {
                mult = card.ability.extra.mult_bonus,
            }
        end
    end
}

-- Timesheet
create_joker {
    name = "Timesheet",
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
            if not context.other_card.doitagain then
                local othercard = context.other_card
                context.other_card.doitagain = true
                add_event(function() if othercard then othercard.doitagain = nil end return true end)
            else
                ease_dollars(card.ability.extra.money)
            end
        end
    end
}



--[[
create_joker {
    name = "Allan please add details",
    key = "allan",
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    rarity = "C",
    cost = 1,
    calculate = function(self, card, context)
        if context.joker_main then 
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname="Straight",chips = G.GAME.hands["Straight"].chips, mult = G.GAME.hands["Straight"].mult, level=G.GAME.hands["Straight"].level}) 
            level_up_hand(self, "Straight", nil, 1) 
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=context.scoring_name,chips = G.GAME.hands[context.scoring_name].chips, mult = G.GAME.hands[context.scoring_name].mult, level=G.GAME.hands[context.scoring_name].level})
        end
    end
}
]]