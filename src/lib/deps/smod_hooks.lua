-- This is a slightly updated Center register that allows for custom crediting
local register_center = SMODS.Center.register
SMODS.Center.register = function(self)
    self.set_badges = function(_, card, badges)
        if self.mstg_credits.idea ~= nil then
            badges[#badges+1] = create_badge(localize({type = "variable", key = "k_mstg_credit_idea", vars = {self.mstg_credits.idea}}), HEX("867100FF"), G.C.WHITE, 0.8 )
        end

        if self.mstg_credits.art ~= nil then
            badges[#badges+1] = create_badge(localize({type = "variable", key = "k_mstg_credit_art", vars = {self.mstg_credits.art}}), HEX("860000FF"), G.C.WHITE, 0.8 )
        end

        if self.mstg_credits.code ~= nil then
            badges[#badges+1] = create_badge(localize({type = "variable", key = "k_mstg_credit_code", vars = {self.mstg_credits.code}}), HEX("00862eFF"), G.C.WHITE, 0.8 )
        end
    end
    return register_center(self)
end

-- This is a slightly updated Joker creator that allows for mod dependencies and for a custom placeholder atlas
local create_joker = SMODS.Joker
SMODS.Joker = function(joker)
    -- Dependencies for mod-specific Jokers, i.e. Cryptid
    if joker.dependencies ~= nil then
        for _, v in ipairs(joker.dependencies) do
            -- If we can't find a dependency, don't make the Joker
            if next(SMODS.find_mod(v)) == nil then
                do return end
            end
        end
    end

    -- Placeholder Joker Atlas
    if joker.atlas == nil then
        joker.atlas = 'placeholder'
        joker.pos = {x = joker.rarity-1, y = 0}
    end

    return create_joker(joker)
end