-- Utility Code
local mistiutils = require('mistiutils')

local enable = true

if CardSleeves then
    CardSleeves.Sleeve {
        key = "tribute",
        name = "Tribute Sleeve",
        atlas = "sleeve-ph",
        pos = { x = 0, y = 2 },
        unlocked = true,
        apply = function(self)
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
end
