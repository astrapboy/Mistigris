-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Blind
local bl = {
    key = "elk",
    atlas = "blinds",
    pos = { x = 0, y = 0 },
    boss = {
        min = 3,
        showdown = false
    },
    boss_colour = HEX("847f66"),
    dollars = 5,
    mult = 2,
    discovered = true,
    loc_vars = function(self)
        return {
            vars = {
                G.GAME.current_round.most_played_poker_hand
            }
        }
    end,
    collection_loc_vars = function(self)
        return {
            vars = {
                localize("ph_most_played")
            }
        }
    end,
    calculate = function(self, blind, context)
        if context.final_scoring_step and context.scoring_name == G.GAME.current_round.most_played_poker_hand then
            G.E_MANAGER:add_event(Event({
                func = function()
                    for k, v in ipairs(context.scoring_hand) do
                        v:shatter()
                    end
                    return true
                end,
                delay = 0.1,
                trigger = "after"
            }))
        end
    end,
}

return bl
