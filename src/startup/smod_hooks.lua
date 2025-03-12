-- Info about the mod (what the prefix is, what the id is)
local mod_prefix, mod_id = "", ""
for _, mod in ipairs(SMODS.find_mod("mistigris")) do
	mod_prefix = mod.prefix
	mod_id = mod.id
end

-- This is a slightly updated Joker creator that allows for a custom placeholder atlas
local register_joker = SMODS.Joker.register
SMODS.Joker.register = function(joker)
	-- Placeholder Joker Atlas
	if (joker.atlas == nil or joker.atlas == 'Joker') and SMODS.current_mod.id == mod_id then
		joker.atlas = mod_prefix .. '_placeholder'
		joker.pos = { x = joker.rarity - 1, y = 0 }
	end

	return register_joker(joker)
end
