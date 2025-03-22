-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Back
local b = {
    key = "plaid",
    unlocked = true,
    discovered = true,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in ipairs(G.playing_cards) do
                    if v.base.suit == "Hearts" then
                        assert(SMODS.change_base(v, "Diamonds"))
                    elseif v.base.suit == "Spades" then
                        assert(SMODS.change_base(v, "Clubs"))
                    end
                end
                return true
            end,
        }))
    end,
}

return b
