-- Utility Code
local mistiutils = require('mistiutils')
 
--- @type SMODS.Back
local b = {
    key = "tribute",
    unlocked = true,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in ipairs(G.playing_cards) do
                    assert(SMODS.change_base(v, "Spades", "10"))
                end
                return true
            end,
        }))
    end,
}

return b
