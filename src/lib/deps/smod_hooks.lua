-- Info about the mod (what the prefix is, what the id is)
local mod_prefix = SMODS.current_mod.prefix
local mod_id = SMODS.current_mod.id

-- This is a slightly updated Center creator that allows for custom crediting
local register_center = SMODS.Center.register
SMODS.Center.register = function(self)
    self.set_badges = function(_, card, badges)
        if self.mstg_vars ~= nil then
            if self.mstg_vars.credits ~= nil then
                badges[#badges+1] = (self.mstg_vars.credits.idea ~= nil) and create_badge(localize({type = "variable", key = "k_mstg_credit_idea", vars = {self.mstg_vars.credits.idea}}), HEX("867100FF"), G.C.WHITE, 0.8 ) or nil
                badges[#badges+1] = (self.mstg_vars.credits.art ~= nil) and create_badge(localize({type = "variable", key = "k_mstg_credit_art", vars = {self.mstg_vars.credits.art}}), HEX("860000FF"), G.C.WHITE, 0.8 ) or nil
                badges[#badges+1] = (self.mstg_vars.credits.code ~= nil) and create_badge(localize({type = "variable", key = "k_mstg_credit_code", vars = {self.mstg_vars.credits.code}}), HEX("00862eFF"), G.C.WHITE, 0.8 ) or nil
            end
        end
    end
    return register_center(self)
end

-- This is a slightly updated Joker creator that allows for a custom placeholder atlas
local register_joker = SMODS.Joker.register
SMODS.Joker.register = function(joker)
    -- Placeholder Joker Atlas
    if (joker.atlas == nil or joker.atlas == 'Joker') and SMODS.current_mod.id == mod_id then
        joker.atlas = mod_prefix..'_placeholder'
        joker.pos = {x = joker.rarity-1, y = 0}
    end

    return register_joker(joker)
end