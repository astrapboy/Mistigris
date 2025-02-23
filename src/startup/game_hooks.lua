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

-- Card Functions
local Card_isfaceRef = Card.is_face
Card.is_face = function(self, from_boss)
	Card_isfaceRef(self, from_boss)
	if next(SMODS.find_card("j_mstg_uptoeleven")) and id >= 10 then
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
