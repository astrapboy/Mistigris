-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Blind
local bl = {
    key = "birch",
    atlas = "blinds",
    pos = { x = 0, y = 0 },
    boss = {
        min = 3,
        showdown = false
    },
    boss_colour = HEX("fda0a5"),
    dollars = 5,
    mult = 2,
    discovered = true,
    debuff_hand = function(self, cards, hand, handname, check)
        if G.GAME.current_round.mstg_valid_hands == 0 then
            return mistiutils.is_not_least_fav_hand(handname)
        else
            return false
        end
    end
}

return bl
