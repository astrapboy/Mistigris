local mistiutils = require("mistigris.mistiutils")

-- Game Functions
local Game_igoRef = Game.init_game_object
Game.init_game_object = function(self)
	local ref = Game_igoRef(self)
	ref.probabilities.mstg_base_normal = 1
	ref.mstg = {
		unique_jokers = {},
		first_joker = nil
	}
	return ref
end

local Game_updateRef = Game.update
Game.update = function(self, dt)
	Game_updateRef(self, dt)


	local lerp_by = math.sin(self.TIMERS.REAL * 1.3)

	local first_red = 200 / 255
	local second_red = 200 / 255

	local first_blue = 0
	local second_blue = 200 / 255

	local first_green = 100 / 255
	local second_green = 100 / 255

	self.C.MISTIGRIS[1] = mistiutils.lerp(first_red, second_red, lerp_by)
	self.C.MISTIGRIS[2] = mistiutils.lerp(first_green, second_green, lerp_by)
	self.C.MISTIGRIS[3] = mistiutils.lerp(first_blue, second_blue, lerp_by)
end

-- Card Functions
local Card_isfaceRef = Card.is_face
Card.is_face = function(self, from_boss)
	Card_isfaceRef(self, from_boss)
	if next(SMODS.find_card("j_mstg_uptoeleven")) and self:get_id() >= 10 then
		return true
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
