local mistiutils = require('mistigris.mistiutils')

-- G Functions
local G_FUNCS_rerollshopRef = G.FUNCS.reroll_shop
G.FUNCS.reroll_shop = function(self, e)
	G.GAME.current_round.caught_reroll = false
	G_FUNCS_rerollshopRef(self, e)
end

-- Game Functions
local Game_igoRef = Game.init_game_object
Game.init_game_object = function(self)
	local ref = Game_igoRef(self)
	ref.probabilities.mstg_base_normal = 1
	ref.mstg = {
		unique_jokers = {}
	}
	return ref
end

local Game_updateRef = Game.update
Game.update = function(self, dt)
	Game_updateRef(self, dt)

	-- Shoutout to Breezebuilder for this next bit
	local cycle_speed = 1.3
	local sin_time = math.sin(self.TIMERS.REAL * cycle_speed)

	self.C.MISTIGRIS[1] = (sin_time * 0.5 + 0.5) * (1.00 - 0.50) + 0.50 -- r = 0.50 -> 1.00
	self.C.MISTIGRIS[2] = (sin_time * 0.5 + 0.5) * (0.65 - 0.00) + 0.00 -- g = 0.00 -> 0.65
	self.C.MISTIGRIS[3] = (sin_time * -0.5 + 0.5) * (0.50 - 0.00) + 0.00 -- b = 0.50 -> 0.00
end

-- Card Functions
local Card_isfaceRef = Card.is_face
Card.is_face = function(self, from_boss)
	if next(SMODS.find_card("j_mstg_up_to_eleven")) and self:get_id() >= 10 then
		return true
	else
		return Card_isfaceRef(self, from_boss)
	end
end

-- CardArea Functions
local CardArea_emplaceRef = CardArea.emplace
CardArea.emplace = function(self, card, location, stay_flipped)
	CardArea_emplaceRef(self, card, location, stay_flipped)
	if self == G.jokers then
		local k = card.config.center.key
		if G.GAME.mstg.unique_jokers[k] == nil then
			table.insert(G.GAME.mstg.unique_jokers, k)
			G.GAME.mstg.unique_jokers[k] = true
		end
	end
end
