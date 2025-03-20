-- This is a slightly updated Joker creator that allows for a custom placeholder atlas
local register_joker = SMODS.Joker.register
SMODS.Joker.register = function(joker)
    -- Placeholder Joker Atlas
    if (joker.atlas == nil or joker.atlas == 'Joker') and SMODS.current_mod.id == MistigrisMod.id then
        joker.atlas = MistigrisMod.prefix .. '_placeholder'
        joker.pos = { x = joker.rarity - 1, y = 0 }
    end

    return register_joker(joker)
end
