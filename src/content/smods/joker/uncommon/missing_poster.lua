-- Utility Code
local mistiutils = require('mistiutils')
 
--- @type SMODS.Joker
local j = {
    key = "missing_poster",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(SMODS.Ranks) do
            if k == "10" or k == "Jack" or k == "Queen" then
                v.next[#v.next + 1] = "Ace"
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(SMODS.Ranks) do
            if k == "10" or k == "Jack" or k == "Queen" then
                for k2, v2 in ipairs(v.next) do
                    if v2 == "Ace" then v.next[k2] = nil end
                end
            end
        end
    end,
}

return j
