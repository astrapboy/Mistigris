-- Utility Code
local mistiutils = require('mistiutils')
local function cost_refresh(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({
        func = function()
            for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
            end
            return true
        end,
    }))
end

--- @type SMODS.Joker
local j = {
    key = "know_your_worth",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true,
    add_to_deck = cost_refresh,
    remove_from_deck = cost_refresh
}

return j
