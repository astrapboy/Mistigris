-- Initialize MistiUtils
local MistiUtils = require("MistiUtils")

-- Diminishing Returns
SMODS.Joker({
    key = "diminishingreturns",
    config = { extra = {base_xmult = 3.5, penalty = 0.5}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.base_xmult, card.ability.extra.penalty}}
    end,
    rarity = 1,
    cost = 5,
    mstg_vars = {
        credits = {
            idea = "astrapboy",
            code = "astrapboy"
        }
    },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult = card.ability.extra.base_xmult - (card.ability.extra.penalty * #context.full_hand),
            }
        end
    end
})

-- Peeking Joker
SMODS.Joker({
    key = "peekingjoker",
    mstg_vars = {
        credits = {
            idea = "astrapboy",
            code = "astrapboy"
        }
    },
    blueprint_compat = true,
    config = { extra = { threshold = 0.6, mult_bonus = 8 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_bonus, card.ability.extra.threshold * 100 } }
    end,
    rarity = 1,
    cost = 5,
    calculate = function(self, card, context)
        if context.joker_main and to_big(G.GAME.chips) / to_big(G.GAME.blind.chips) < to_big(card.ability.extra.threshold) then
            return {
                mult = card.ability.extra.mult_bonus
            }
        end
    end
})

-- Ninja Joker
SMODS.Joker({
    key = "ninjajoker",
    mstg_vars = {
        credits = {
            idea = "astrapboy",
            code = "astrapboy"
        }
    },
    blueprint_compat = true,
    config = { extra = { threshold = 0.6, chip_bonus = 150 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chip_bonus, card.ability.extra.threshold * 100 } }
    end,
    rarity = 1,
    cost = 5,
    calculate = function(self, card, context)
        if context.joker_main and to_big(G.GAME.chips) / to_big(G.GAME.blind.chips) < to_big(card.ability.extra.threshold) then
            return {
                chips = card.ability.extra.chip_bonus
            }
        end
    end
})

-- Timesheet
SMODS.Joker({
    key = "timesheet",
    mstg_vars = {
        credits = {
            idea = "astrapboy",
            code = "astrapboy"
        }
    },
    config = { extra = { money = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,
    blueprint_compat = true,
    rarity = 1,
    cost = 6,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if not context.other_card.timesheeted then
                local c = context.other_card
                context.other_card.timesheeted = true
                MistiUtils.add_event(function() if c then c.timesheeted = nil end return true end)
            else
                ease_dollars(card.ability.extra.money)
            end
        end
    end
})

-- Up To Eleven
SMODS.Joker({
    key = "uptoeleven",
    mstg_vars = {
        credits = {
            idea = "astrapboy",
            code = "astrapboy"
        }
    },
    blueprint_compat = false,
    rarity = 1,
    cost = 4
})


-- Sleepy Joker
SMODS.Joker({
    key = "sleepy",
    mstg_vars = {
        credits = {
            idea = "astrapboy",
            code = "astrapboy"
        }
    },
    config = { extra = { xmult_gain = 0.2, xmult_to_pass = 1, nightmared = false } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, localize({type = 'name_text', set = 'Joker', key = 'j_mstg_awake'}), card.ability.extra.xmult_to_pass } }
    end,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    rarity = 1,
    cost = 4,
    calculate = function(self, card, context)
        -- Nightmare!
        if next(SMODS.find_card("j_scary_face")) and not card.ability.extra.nightmared and not context.blueprint then
            card.ability.extra.nightmared = true
            MistiUtils.destroy_joker(card, function() if G.jokers then
                local c = SMODS.add_card({set = 'Joker', key = 'j_mstg_awake'})
                c.ability.extra.Xmult = card.ability.extra.xmult_to_pass
                return true end
            end)
            return {
                message = localize('k_mstg_nightmare_ex')
            }
        end
        
        if context.end_of_round and context.cardarea == G.jokers and not context.game_over and not context.blueprint then
            card.ability.extra.xmult_to_pass = card.ability.extra.xmult_to_pass + card.ability.extra.xmult_gain
            return {
                message = localize('k_upgrade_ex')
            }
        end

        if context.selling_self and not context.blueprint then
            MistiUtils.add_event(function() if G.jokers then
                local c = SMODS.add_card({set = 'Joker', key = 'j_mstg_awake'})
                c.ability.extra.Xmult = card.ability.extra.xmult_to_pass
                return true end 
            end)
            return {
                message = localize('k_mstg_wakeup_ex')
            }
        end
    end
})

-- Awake Joker
SMODS.Joker({
    key = "awake",
    mstg_vars = {
        credits = {
            idea = "astrapboy",
            code = "astrapboy"
        }
    },
    config = { extra = { Xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    rarity = 1,
    in_pool = function() return false  end,
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
})