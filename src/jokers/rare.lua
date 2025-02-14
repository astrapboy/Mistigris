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
    config = { extra = {bonus_xmult = 0.33, current_xmult = 1, multiple_of = 3}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.bonus_xmult, 3, card.ability.extra.current_xmult}}
    end,
    rarity = "R",
    blueprint = true,
    cost = 9,
    calculate = function(self, card, context)
        local multiples = {3, 6, 9}
        if context.before and not context.blueprint then
            if ranks_count(context.scoring_hand, multiples) > 0 then
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

local base_endround = end_round
function end_round()
    base_endround()
    print_line("UNRIGGED")
    G.GAME.rig_all_probs = false
end

create_joker({
    key = "weighteddice",
    credits = {
        idea = "astrapboy",
        code = "astrapboy"
    },
    config = { extra = {}},
    rarity = "R",
    blueprint = false,
    cost = 9,
    calculate = function(self, card, context)
        if context.selling_self == true and not context.blueprint then
            G.GAME.rig_all_probs = true
        end
    end
})
